import Foundation
//: Playground - noun: a place where people can play

internal enum OperatorAssociativity {
  case leftAssociative
  case rightAssociative
}

public enum OperatorType: CustomStringConvertible {
  case add
  case subtract
  case divide
  case multiply
  case percent
  case exponent

  public var description: String {
    switch self {
    case .add:
      return "+"
    case .subtract:
      return "-"
    case .divide:
      return "/"
    case .multiply:
      return "*"
    case .percent:
      return "%"
    case .exponent:
      return "^"
    }
  }
}

public enum TokenType: CustomStringConvertible {
  case openBracket
  case closeBracket
  case Operator(OperatorToken)
  case operand(Double)

  public var description: String {
    switch self {
    case .openBracket:
      return "("
    case .closeBracket:
      return ")"
    case .Operator(let operatorToken):
      return operatorToken.description
    case .operand(let value):
      return "\(value)"
    }
  }
}

public struct OperatorToken: CustomStringConvertible {
  let operatorType: OperatorType

  init(operatorType: OperatorType) {
    self.operatorType = operatorType
  }

  var precedence: Int {
    switch operatorType {
    case .add, .subtract:
      return 0
    case .divide, .multiply, .percent:
      return 5
    case .exponent:
      return 10
    }
  }

  var associativity: OperatorAssociativity {
    switch operatorType {
    case .add, .subtract, .divide, .multiply, .percent:
      return .leftAssociative
    case .exponent:
      return .rightAssociative
    }
  }

  public var description: String {
    return operatorType.description
  }
}

func <= (left: OperatorToken, right: OperatorToken) -> Bool {
  return left.precedence <= right.precedence
}

func < (left: OperatorToken, right: OperatorToken) -> Bool {
  return left.precedence < right.precedence
}

public struct Token: CustomStringConvertible {
  let tokenType: TokenType

  init(tokenType: TokenType) {
    self.tokenType = tokenType
  }

  init(operand: Double) {
    tokenType = .operand(operand)
  }

  init(operatorType: OperatorType) {
    tokenType = .Operator(OperatorToken(operatorType: operatorType))
  }

  var isOpenBracket: Bool {
    switch tokenType {
    case .openBracket:
      return true
    default:
      return false
    }
  }

  var isOperator: Bool {
    switch tokenType {
    case .Operator(_):
      return true
    default:
      return false
    }
  }

  var operatorToken: OperatorToken? {
    switch tokenType {
    case .Operator(let operatorToken):
      return operatorToken
    default:
      return nil
    }
  }

  public var description: String {
    return tokenType.description
  }
}

public class InfixExpressionBuilder {
  private var expression = [Token]()

  public func addOperator(_ operatorType: OperatorType) -> InfixExpressionBuilder {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addOperator(operatorType=\(operatorType))\n".utf8))
    expression.append(Token(operatorType: operatorType))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addOperator(operatorType=\(operatorType))\n".utf8))
    return self
  }

  public func addOperand(_ operand: Double) -> InfixExpressionBuilder {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addOperand(operand=\(operand))\n".utf8))
    expression.append(Token(operand: operand))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addOperand(operand=\(operand))\n".utf8))
    return self
  }

  public func addOpenBracket() -> InfixExpressionBuilder {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addOpenBracket()\n".utf8))
    expression.append(Token(tokenType: .openBracket))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addOpenBracket()\n".utf8))
    return self
  }

  public func addCloseBracket() -> InfixExpressionBuilder {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering addCloseBracket()\n".utf8))
    expression.append(Token(tokenType: .closeBracket))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting addCloseBracket()\n".utf8))
    return self
  }

  public func build() -> [Token] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering build()\n".utf8))
    // Maybe do some validation here
	FileHandle.standardError.write(Data("[WARN] <<< Exiting build()\n".utf8))
    return expression
  }
}

// This returns the result of the shunting yard algorithm
public func reversePolishNotation(_ expression: [Token]) -> String {
FileHandle.standardError.write(Data("[ERROR] >>> Entering reversePolishNotation(expression=\(expression))\n".utf8))

  var tokenStack = Stack<Token>()
  var reversePolishNotation = [Token]()

FileHandle.standardError.write(Data("[ERROR] reversePolishNotation(expression=\(expression)): tokenStack → <redacted>\n".utf8))
  for token in expression {
    switch token.tokenType {
    case .operand(_):
      reversePolishNotation.append(token)

    case .openBracket:
      tokenStack.push(token)

    case .closeBracket:
      while tokenStack.count > 0, let tempToken = tokenStack.pop(), !tempToken.isOpenBracket {
        reversePolishNotation.append(tempToken)
      }

    case .Operator(let operatorToken):
      for tempToken in tokenStack.makeIterator() {
        if !tempToken.isOperator {
          break
        }

        if let tempOperatorToken = tempToken.operatorToken {
          if operatorToken.associativity == .leftAssociative && operatorToken <= tempOperatorToken
            || operatorToken.associativity == .rightAssociative && operatorToken < tempOperatorToken {
            reversePolishNotation.append(tokenStack.pop()!)
          } else {
            break
          }
        }
      }
      tokenStack.push(token)
    }
  }

  while tokenStack.count > 0 {
    reversePolishNotation.append(tokenStack.pop()!)
  }

FileHandle.standardError.write(Data("[WARN] <<< Exiting reversePolishNotation(expression=\(expression))\n".utf8))
  return reversePolishNotation.map({token in token.description}).joined(separator: " ")
}

// Simple demo

let expr = InfixExpressionBuilder()
  .addOperand(3)
  .addOperator(.add)
  .addOperand(4)
  .addOperator(.multiply)
  .addOperand(2)
  .addOperator(.divide)
  .addOpenBracket()
  .addOperand(1)
  .addOperator(.subtract)
  .addOperand(5)
  .addCloseBracket()
  .addOperator(.exponent)
  .addOperand(2)
  .addOperator(.exponent)
  .addOperand(3)
  .build()

print(expr.description)
print(reversePolishNotation(expr))
