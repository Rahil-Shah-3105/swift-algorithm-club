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
	print(">>> Entering add(value=\(value))")
    guard children[value] == nil else {
      return
    }
    children[value] = TrieNode(value: value, parentNode: self)
	print("<<< Exiting add(value=\(value))")
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
	print(">>> Entering encode(coder=\(coder))")
    coder.encode(self.words, forKey: "words")
	print("<<< Exiting encode(coder=\(coder))")
  }
}

// MARK: - Adds methods: insert, remove, contains
extension Trie {
  /// Inserts a word into the trie.  If the word is already present,
  /// there is no change.
  ///
  /// - Parameter word: the word to be inserted.
  func insert(word: String) {
	print(">>> Entering insert(word=\(word))")
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
	print("insert(word=\(word)): currentNode.isTerminating → \(currentNode.isTerminating)")
    currentNode.isTerminating = true
	print("<<< Exiting insert(word=\(word))")
  }

  /// Determines whether a word is in the trie.
  ///
  /// - Parameters:
  ///   - word: the word to check for
  ///   - matchPrefix: whether the search word should match
  ///   if it is only a prefix of other nodes in the trie
  /// - Returns: true if the word is present, false otherwise.
  func contains(word: String, matchPrefix: Bool = false) -> Bool {
	print(">>> Entering contains(word=\(word),matchPrefix=\(matchPrefix))")
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
	print("<<< Exiting contains(word=\(word),matchPrefix=\(matchPrefix))")
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
	print(">>> Entering findLastNodeOf(word=\(word))")
    var currentNode = root
    for character in word.lowercased() {
      guard let childNode = currentNode.children[character] else {
        return nil
      }
      currentNode = childNode
    }
	print("<<< Exiting findLastNodeOf(word=\(word))")
    return currentNode
  }

  /// Attempts to walk to the terminating node of a word.  The
  /// search will fail if the word is not present.
  ///
  /// - Parameter word: the word in question
  /// - Returns: the node where the search ended, nil if the
  /// search failed.
  private func findTerminalNodeOf(word: String) -> Node? {
	print(">>> Entering findTerminalNodeOf(word=\(word))")
    if let lastNode = findLastNodeOf(word: word) {
	print("findTerminalNodeOf(word=\(word)): lastNode → \(lastNode)")
	print("<<< Exiting findTerminalNodeOf(word=\(word))")
      return lastNode.isTerminating ? lastNode : nil
    }
    return nil
  }

  /// Deletes a word from the trie by starting with the last letter
  /// and moving back, deleting nodes until either a non-leaf or a
  /// terminating node is found.
  ///
  /// - Parameter terminalNode: the node representing the last node
  /// of a word
  private func deleteNodesForWordEndingWith(terminalNode: Node) {
	print(">>> Entering deleteNodesForWordEndingWith(terminalNode=\(terminalNode))")
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
	print("<<< Exiting deleteNodesForWordEndingWith(terminalNode=\(terminalNode))")
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
	print(">>> Entering remove(word=\(word))")
    guard !word.isEmpty else {
      return
    }
    guard let terminalNode = findTerminalNodeOf(word: word) else {
	print("remove(word=\(word)): terminalNode → \(terminalNode)")
      return
    }
    if terminalNode.isLeaf {
      deleteNodesForWordEndingWith(terminalNode: terminalNode)
    } else {
      terminalNode.isTerminating = false
	print("remove(word=\(word)): terminalNode.isTerminating → \(terminalNode.isTerminating)")
    }
    wordCount -= 1
	print("<<< Exiting remove(word=\(word))")
  }

  /// Returns an array of words in a subtrie of the trie
  ///
  /// - Parameters:
  ///   - rootNode: the root node of the subtrie
  ///   - partialWord: the letters collected by traversing to this node
  /// - Returns: the words in the subtrie
  fileprivate func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
	print(">>> Entering wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord))")
    var subtrieWords = [String]()
    var previousLetters = partialWord
	print("wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord)): subtrieWords → \(subtrieWords)")
    if let value = rootNode.value {
      previousLetters.append(value)
    }
    if rootNode.isTerminating {
      subtrieWords.append(previousLetters)
    }
    for childNode in rootNode.children.values {
      let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
      subtrieWords += childWords
	print("wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord)): childWords → \(childWords)")
    }
	print("<<< Exiting wordsInSubtrie(rootNode=\(rootNode),partialWord=\(partialWord))")
    return subtrieWords
  }

  /// Returns an array of words in a subtrie of the trie that start
  /// with given prefix
  ///
  /// - Parameters:
  ///   - prefix: the letters for word prefix
  /// - Returns: the words in the subtrie that start with prefix
  func findWordsWithPrefix(prefix: String) -> [String] {
	print(">>> Entering findWordsWithPrefix(prefix=\(prefix))")
    var words = [String]()
    let prefixLowerCased = prefix.lowercased()
    if let lastNode = findLastNodeOf(word: prefixLowerCased) {
	print("findWordsWithPrefix(prefix=\(prefix)): prefixLowerCased → \(prefixLowerCased)")
	print("findWordsWithPrefix(prefix=\(prefix)): lastNode → \(lastNode)")
	print("findWordsWithPrefix(prefix=\(prefix)): words → \(words)")
      if lastNode.isTerminating {
        words.append(prefixLowerCased)
      }
      for childNode in lastNode.children.values {
        let childWords = wordsInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
        words += childWords
		print("findWordsWithPrefix(prefix=\(prefix)): childWords → \(childWords)")
      }
    }
	print("<<< Exiting findWordsWithPrefix(prefix=\(prefix))")
    return words
  }
}
