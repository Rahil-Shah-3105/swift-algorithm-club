//
//  TrieTests.swift
//  TrieTests
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import XCTest
@testable import Trie

class TrieTests: XCTestCase {
  var wordArray: [String]?
  var trie = Trie()

  /// Makes sure that the wordArray and trie are initialized before each test.
  override func setUp() {
	print(">>> Entering setUp()")
    super.setUp()
    createWordArray()
    insertWordsIntoTrie()
	print("<<< Exiting setUp()")
  }

  /// Don't need to do anything here because the wordArray and trie should
  /// stay around.
  override func tearDown() {
	print(">>> Entering tearDown()")
    super.tearDown()
	print("<<< Exiting tearDown()")
  }

  /// Reads words from the dictionary file and inserts them into an array.  If
  /// the word array already has words, do nothing.  This allows running all
  /// tests without repeatedly filling the array with the same values.
  func createWordArray() {
	print(">>> Entering createWordArray()")
    guard wordArray == nil else {
      return
    }
    let resourcePath = Bundle.main.resourcePath! as NSString
    let fileName = "dictionary.txt"
	print("createWordArray(): fileName → \(fileName)")
	print("createWordArray(): filePath → \(filePath)")
    let filePath = resourcePath.appendingPathComponent(fileName)

    var data: String?
    do {
      data = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    } catch let error as NSError {
	print("Exception in createWordArray(): \(error)")
      XCTAssertNil(error)
    }
    XCTAssertNotNil(data)
    let dictionarySize = 162825
    wordArray = data!.components(separatedBy: "\n")
    XCTAssertEqual(wordArray!.count, dictionarySize)
	print("<<< Exiting createWordArray()")
  }

  /// Inserts words into a trie.  If the trie is non-empty, don't do anything.
  func insertWordsIntoTrie() {
	print(">>> Entering insertWordsIntoTrie()")
    guard let wordArray = wordArray, trie.count == 0 else { return }
    for word in wordArray {
      trie.insert(word: word)
    }
	print("<<< Exiting insertWordsIntoTrie()")
  }

  /// Tests that a newly created trie has zero words.
  func testCreate() {
	print(">>> Entering testCreate()")
	print("testCreate(): trie → \(trie)")
    let trie = Trie()
    XCTAssertEqual(trie.count, 0)
	print("<<< Exiting testCreate()")
  }

  /// Tests the insert method
  func testInsert() {
	print(">>> Entering testInsert()")
    let trie = Trie()
    trie.insert(word: "cute")
    trie.insert(word: "cutie")
    trie.insert(word: "fred")
    XCTAssertTrue(trie.contains(word: "cute"))
    XCTAssertFalse(trie.contains(word: "cut"))
    trie.insert(word: "cut")
    XCTAssertTrue(trie.contains(word: "cut"))
    XCTAssertEqual(trie.count, 4)
	print("testInsert(): trie → \(trie)")
	print("<<< Exiting testInsert()")
  }

  /// Tests the remove method
  func testRemove() {
	print(">>> Entering testRemove()")
    let trie = Trie()
    trie.insert(word: "cute")
    trie.insert(word: "cut")
    XCTAssertEqual(trie.count, 2)
    trie.remove(word: "cute")
    XCTAssertTrue(trie.contains(word: "cut"))
    XCTAssertFalse(trie.contains(word: "cute"))
    XCTAssertEqual(trie.count, 1)
	print("testRemove(): trie → \(trie)")
	print("<<< Exiting testRemove()")
  }

  /// Tests the words property
  func testWords() {
	print(">>> Entering testWords()")
    let trie = Trie()
    var words = trie.words
	print("testWords(): trie → \(trie)")
    XCTAssertEqual(words.count, 0)
    trie.insert(word: "foobar")
    words = trie.words
    XCTAssertEqual(words[0], "foobar")
    XCTAssertEqual(words.count, 1)
	print("<<< Exiting testWords()")
  }

  /// Tests the performance of the insert method.
  func testInsertPerformance() {
	print(">>> Entering testInsertPerformance()")
    self.measure {
      let trie = Trie()
      for word in self.wordArray! {
	print("testInsertPerformance(): trie → \(trie)")
        trie.insert(word: word)
      }
    }
    XCTAssertGreaterThan(trie.count, 0)
    XCTAssertEqual(trie.count, wordArray?.count)
	print("<<< Exiting testInsertPerformance()")
  }

  /// Tests the performance of the insert method when the words are already
  /// present.
  func testInsertAgainPerformance() {
	print(">>> Entering testInsertAgainPerformance()")
    self.measure {
      for word in self.wordArray! {
        self.trie.insert(word: word)
      }
    }
	print("<<< Exiting testInsertAgainPerformance()")
  }

  /// Tests the performance of the contains method.
  func testContainsPerformance() {
	print(">>> Entering testContainsPerformance()")
    self.measure {
      for word in self.wordArray! {
        XCTAssertTrue(self.trie.contains(word: word))
      }
    }
	print("<<< Exiting testContainsPerformance()")
  }

  /// Tests the performance of the remove method.  Since setup has already put
  /// words into the trie, remove them before measuring performance.
  func testRemovePerformance() {
	print(">>> Entering testRemovePerformance()")
    for word in self.wordArray! {
      self.trie.remove(word: word)
    }
    self.measure {
      self.insertWordsIntoTrie()
      for word in self.wordArray! {
        self.trie.remove(word: word)
      }
    }
    XCTAssertEqual(trie.count, 0)
	print("<<< Exiting testRemovePerformance()")
  }

  /// Tests the performance of the words computed property.  Also tests to see
  /// if it worked properly.
  func testWordsPerformance() {
	print(">>> Entering testWordsPerformance()")
    var words: [String]?
    self.measure {
      words = self.trie.words
	print("testWordsPerformance(): words → \(words)")
    }
    XCTAssertEqual(words?.count, trie.count)
    for word in words! {
      XCTAssertTrue(self.trie.contains(word: word))
    }
	print("<<< Exiting testWordsPerformance()")
  }

  /// Tests the archiving and unarchiving of the trie.
  func testArchiveAndUnarchive() {
	print(">>> Entering testArchiveAndUnarchive()")
    let resourcePath = Bundle.main.resourcePath! as NSString
    let fileName = "dictionary-archive"
	print("testArchiveAndUnarchive(): fileName → \(fileName)")
	print("testArchiveAndUnarchive(): filePath → \(filePath)")
    let filePath = resourcePath.appendingPathComponent(fileName)
    NSKeyedArchiver.archiveRootObject(trie, toFile: filePath)
    let trieCopy = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Trie
	print("testArchiveAndUnarchive(): trieCopy → \(trieCopy)")
    XCTAssertEqual(trieCopy?.count, trie.count)
	print("<<< Exiting testArchiveAndUnarchive()")
  }
  
  /// Tests whether word prefixes are properly found and returned.
  func testFindWordsWithPrefix() {
	print(">>> Entering testFindWordsWithPrefix()")
    let trie = Trie()
    trie.insert(word: "test")
    trie.insert(word: "another")
    trie.insert(word: "exam")
    let wordsAll = trie.findWordsWithPrefix(prefix: "")
    XCTAssertEqual(wordsAll.sorted(), ["another", "exam", "test"])
    let words = trie.findWordsWithPrefix(prefix: "ex")
    XCTAssertEqual(words, ["exam"])
    trie.insert(word: "examination")
    let words2 = trie.findWordsWithPrefix(prefix: "exam")
    XCTAssertEqual(words2, ["exam", "examination"])
    let noWords = trie.findWordsWithPrefix(prefix: "tee")
    XCTAssertEqual(noWords, [])
    let unicodeWord = "😬😎"
	print("testFindWordsWithPrefix(): trie → \(trie)")
    trie.insert(word: unicodeWord)
    let wordsUnicode = trie.findWordsWithPrefix(prefix: "😬")
    XCTAssertEqual(wordsUnicode, [unicodeWord])
    trie.insert(word: "Team")
    let wordsUpperCase = trie.findWordsWithPrefix(prefix: "Te")
    XCTAssertEqual(wordsUpperCase.sorted(), ["team", "test"])
	print("testFindWordsWithPrefix(): wordsUnicode → \(wordsUnicode)")
	print("<<< Exiting testFindWordsWithPrefix()")
  }

  /// Tests whether word prefixes are properly detected on a boolean contains() check.
  func testContainsWordMatchPrefix() {
	print(">>> Entering testContainsWordMatchPrefix()")
    let trie = Trie()
    trie.insert(word: "test")
    trie.insert(word: "another")
    trie.insert(word: "exam")
    let wordsAll = trie.contains(word: "", matchPrefix: true)
    XCTAssertEqual(wordsAll, true)
    let words = trie.contains(word: "ex", matchPrefix: true)
    XCTAssertEqual(words, true)
    trie.insert(word: "examination")
    let words2 = trie.contains(word: "exam", matchPrefix: true)
    XCTAssertEqual(words2, true)
    let noWords = trie.contains(word: "tee", matchPrefix: true)
    XCTAssertEqual(noWords, false)
    let unicodeWord = "😬😎"
	print("testContainsWordMatchPrefix(): trie → \(trie)")
    trie.insert(word: unicodeWord)
    let wordsUnicode = trie.contains(word: "😬", matchPrefix: true)
    XCTAssertEqual(wordsUnicode, true)
    trie.insert(word: "Team")
    let wordsUpperCase = trie.contains(word: "Te", matchPrefix: true)
    XCTAssertEqual(wordsUpperCase, true)
	print("testContainsWordMatchPrefix(): wordsUnicode → \(wordsUnicode)")
	print("<<< Exiting testContainsWordMatchPrefix()")
  }
}
