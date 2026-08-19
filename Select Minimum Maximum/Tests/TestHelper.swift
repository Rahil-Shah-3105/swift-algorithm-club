import Foundation

func createRandomList(_ numberOfElements: Int) -> [UInt32] {
print(">>> Entering createRandomList(numberOfElements=\(numberOfElements))")
print("<<< Exiting createRandomList(numberOfElements=\(numberOfElements))")
  return (1...numberOfElements).map {_ in arc4random()}
}
