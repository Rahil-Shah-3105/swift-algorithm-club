//
//  Trie.swift
//  Trie
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import Foundation

/// A node in the trie
class TrieNode<T: Hashable> {
  var value: T?
  weak var parentNode: TrieNode?
  var children: [T: TrieNode] = [:]
  var isTerminating = false
  var isLeaf: Bool {
    return children.count == 0
  }

  /// Initializes a node.
  ///
  /// - Parameters:
  ///   - value: The value that goes into the node
  ///   - parentNode: A reference to this node's parent
  init(value: T? = nil, parentNode: TrieNode? = nil) {
    self.value = value
    self.parentNode = parentNode
  }

  /// Adds a child node to self.  If the child is already present,
  /// do nothing.
  ///
  /// - Parameter value: The item to be added to this node.
  func add(value: T) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering add(value=\(value))\n".utf8))
    guard children[value] == nil else {
      return
    }
    children[value] = TrieNode(value: value, parentNode: self)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting add(value=\(value))\n".utf8))
  }
}

/// A trie data structure containing words.  Each node is a single
/// character of a word.
class Trie: NSObject, NSCoding {
  typealias Node = TrieNode<Character>
  /// The number of words in the trie
  public var count: Int {
    return wordCount
  }
  /// Is the trie empty?
  public var isEmpty: Bool {
    return wordCount == 0
  }
  /// All words currently in the trie
  public var words: [String] {
    return wordsInSubtrie(rootNode: root, partialWord: "")
  }
  fileprivate let root: Node
  fileprivate var wordCount: Int

  /// Creates an empty trie.
  override init() {
    root = Node()
    wordCount = 0
    super.init()
  }

  // MARK: NSCoding

  /// Initializes the trie with words from an archive
  ///
  /// - Parameter decoder: Decodes the archive
  required convenience init?(coder decoder: NSCoder) {
    self.init()
    let words = decoder.decodeObject(forKey: "words") as? [String]
    for word in words! {
      self.insert(word: word)
    }
  }

  /// Encodes the words in the trie by putting them in an array then encoding
  /// the array.
  ///
  /// - Parameter coder: The object that will encode the array
  func encode(with coder: NSCoder) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering encode(coder=\(coder))\n".utf8))
    coder.encode(self.words, forKey: "words")
	FileHandle.standardError.write(Data("[WARN] <<< Exiting encode(coder=\(coder))\n".utf8))
  }
}

// MARK: - Adds methods: insert, remove, contains
extension Trie {
  /// Inserts a word into the trie.  If the word is already present,
  /// there is no change.
  ///
  /// - Parameter word: the word to be inserted.
  func insert(word: String) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insert(word=\(word))\n".utf8))
    guard !word.isEmpty else {
      return
    }
    var currentNode = root
    for character in word.lowercased() {
      if let childNode = currentNode.children[character] {
        currentNode = childNode
      } else {
        currentNode.add(value: character)
        currentNode = currentNode.children[character]!
      }
    }
    // Word already present?
    guard !currentNode.isTerminating else {
      return
    }
    wordCount += 1
    currentNode.isTerminating = true
	FileHandle.standardError.write(Data("[DEBUG] insert(word=\(word)): currentNode.isTerminating → \(currentNode.isTerminating)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insert(word=\(word))\n".utf8))
  }

  /// Determines whether a word is in the trie.
  ///
  /// - Parameters:
  ///   - word: the word to check for
  ///   - matchPrefix: whether the search word should match
  ///   if it is only a prefix of other nodes in the trie
  /// - Returns: true if the word is present, false otherwise.
  func contains(word: String, matchPrefix: Bool = false) -> Bool {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering contains(word=\(word),matchPrefix=\(matchPrefix))\n".utf8))
    guard !word.isEmpty else {
      return false
    }
    var currentNode = root
    for character in word.lowercased() {
      guard let childNode = currentNode.children[character] else {
        return false
      }
      currentNode = childNode
    }
    return matchPrefix || currentNode.isTerminating
  }

  /// Attempts to walk to the last node of a word.  The
  /// search will fail if the word is not present. Doesn't
  /// check if the node is terminating
  ///
  /// - Parameter word: the word in question
  /// - Returns: the node where the search ended, nil if the
  /// search failed.
  private func findLastNodeOf(word: String) -> Node? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findLastNodeOf(word=\(word))\n".utf8))
    var currentNode = root
    for character in word.lowercased() {
      guard let childNode = currentNode.children[character] else {
        return nil
      }
      currentNode = childNode
    }
    return currentNode
  }

  /// Attempts to walk to the terminating node of a word.  The
  /// search will fail if the word is not present.
  ///
  /// - Parameter word: the word in question
  /// - Returns: the node where the search ended, nil if the
  /// search failed.
  private func findTerminalNodeOf(word: String) -> Node? {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findTerminalNodeOf(word=\(word))\n".utf8))
    if let lastNode = findLastNodeOf(word: word) {
      return lastNode.isTerminating ? lastNode : nil
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting findTerminalNodeOf(word=\(word))\n".utf8))
    return nil
  }

  /// Deletes a word from the trie by starting with the last letter
  /// and moving back, deleting nodes until either a non-leaf or a
  /// terminating node is found.
  ///
  /// - Parameter terminalNode: the node representing the last node
  /// of a word
  private func deleteNodesForWordEndingWith(terminalNode: Node) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering deleteNodesForWordEndingWith(terminalNode=\(terminalNode))\n".utf8))
    var lastNode = terminalNode
    var character = lastNode.value
    while lastNode.isLeaf, let parentNode = lastNode.parentNode {
      lastNode = parentNode
      lastNode.children[character!] = nil
      character = lastNode.value
      if lastNode.isTerminating {
        break
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting deleteNodesForWordEndingWith(terminalNode=\(terminalNode))\n".utf8))
  }

  /// Removes a word from the trie.  If the word is not present or
  /// it is empty, just ignore it.  If the last node is a leaf,
  /// delete that node and higher nodes that are leaves until a
  /// terminating node or non-leaf is found.  If the last node of
  /// the word has more children, the word is part of other words.
  /// Mark the last node as non-terminating.
  ///
  /// - Parameter word: the word to be removed
  func remove(word: String) {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering remove(word=\(word))\n".utf8))
    guard !word.isEmpty else {
      return
    }
    guard let terminalNode = findTerminalNodeOf(word: word) else {
      return
    }
    if terminalNode.isLeaf {
      deleteNodesForWordEndingWith(terminalNode: terminalNode)
    } else {
      terminalNode.isTerminating = false
	FileHandle.standardError.write(Data("[DEBUG] remove(word=\(word)): terminalNode.isTerminating → \(terminalNode.isTerminating)\n".utf8))
    }
    wordCount -= 1
	FileHandle.standardError.write(Data("[WARN] <<< Exiting remove(word=\(word))\n".utf8))
  }

  /// Returns an array of words in a subtrie of the trie
  ///
  /// - Parameters:
  ///   - rootNode: the root node of the subtrie
  ///   - partialWord: the letters collected by traversing to this node
  /// - Returns: the words in the subtrie
  fileprivate func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord))\n".utf8))
    var subtrieWords = [String]()
    var previousLetters = partialWord
	FileHandle.standardError.write(Data("[ERROR] wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord)): subtrieWords → \(subtrieWords)\n".utf8))
    if let value = rootNode.value {
      previousLetters.append(value)
    }
    if rootNode.isTerminating {
      subtrieWords.append(previousLetters)
    }
    for childNode in rootNode.children.values {
      let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
      subtrieWords += childWords
	FileHandle.standardError.write(Data("[ERROR] wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord)): childWords → \(childWords)\n".utf8))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord))\n".utf8))
    return subtrieWords
  }

  /// Returns an array of words in a subtrie of the trie that start
  /// with given prefix
  ///
  /// - Parameters:
  ///   - prefix: the letters for word prefix
  /// - Returns: the words in the subtrie that start with prefix
  func findWordsWithPrefix(prefix: String) -> [String] {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering findWordsWithPrefix(prefix=\(prefix))\n".utf8))
    var words = [String]()
    let prefixLowerCased = prefix.lowercased()
    if let lastNode = findLastNodeOf(word: prefixLowerCased) {
	FileHandle.standardError.write(Data("[ERROR] findWordsWithPrefix(prefix=\(prefix)): prefixLowerCased → \(prefixLowerCased)\n".utf8))
      if lastNode.isTerminating {
		FileHandle.standardError.write(Data("[ERROR] findWordsWithPrefix(prefix=\(prefix)): words → \(words)\n".utf8))
        words.append(prefixLowerCased)
      }
      for childNode in lastNode.children.values {
        let childWords = wordsInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
        words += childWords
		FileHandle.standardError.write(Data("[ERROR] findWordsWithPrefix(prefix=\(prefix)): childWords → \(childWords)\n".utf8))
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting findWordsWithPrefix(prefix=\(prefix))\n".utf8))
    return words
  }
}
