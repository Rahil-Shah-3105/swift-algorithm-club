//
//  TrieTests.swift
//  TrieTests
//
//  Created by Rick Zaccone on 2016-12-12.
//  Copyright © 2016 Rick Zaccone. All rights reserved.
//

import XCTest
@testable import Trie
import Foundation

class TrieTests: XCTestCase {
  var wordArray: [String]?
  var trie = Trie()

  /// Makes sure that the wordArray and trie are initialized before each test.
  override func setUp() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering setUp()\n".utf8))
    super.setUp()
    createWordArray()
    insertWordsIntoTrie()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting setUp()\n".utf8))
  }

  /// Don't need to do anything here because the wordArray and trie should
  /// stay around.
  override func tearDown() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering tearDown()\n".utf8))
    super.tearDown()
	FileHandle.standardError.write(Data("[WARN] <<< Exiting tearDown()\n".utf8))
  }

  /// Reads words from the dictionary file and inserts them into an array.  If
  /// the word array already has words, do nothing.  This allows running all
  /// tests without repeatedly filling the array with the same values.
  func createWordArray() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering createWordArray()\n".utf8))
    guard wordArray == nil else {
      return
    }
    let resourcePath = Bundle.main.resourcePath! as NSString
    let fileName = "dictionary.txt"
	FileHandle.standardError.write(Data("[ERROR] createWordArray(): fileName → \(fileName)\n".utf8))
    let filePath = resourcePath.appendingPathComponent(fileName)

	FileHandle.standardError.write(Data("[ERROR] createWordArray(): filePath → \(filePath)\n".utf8))
    var data: String?
    do {
      data = try String(contentsOfFile: filePath, encoding: String.Encoding.utf8)
    } catch let error as NSError {
	FileHandle.standardError.write(Data("[ERROR] Exception in createWordArray(): \(error)\n".utf8))
      XCTAssertNil(error)
    }
    XCTAssertNotNil(data)
    let dictionarySize = 162825
    wordArray = data!.components(separatedBy: "\n")
    XCTAssertEqual(wordArray!.count, dictionarySize)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting createWordArray()\n".utf8))
  }

  /// Inserts words into a trie.  If the trie is non-empty, don't do anything.
  func insertWordsIntoTrie() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering insertWordsIntoTrie()\n".utf8))
    guard let wordArray = wordArray, trie.count == 0 else { return }
    for word in wordArray {
      trie.insert(word: word)
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting insertWordsIntoTrie()\n".utf8))
  }

  /// Tests that a newly created trie has zero words.
  func testCreate() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testCreate()\n".utf8))
    let trie = Trie()
    XCTAssertEqual(trie.count, 0)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testCreate()\n".utf8))
	FileHandle.standardError.write(Data("[ERROR] testCreate(): trie → \(trie)\n".utf8))
  }

  /// Tests the insert method
  func testInsert() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testInsert()\n".utf8))
    let trie = Trie()
    trie.insert(word: "cute")
    trie.insert(word: "cutie")
    trie.insert(word: "fred")
    XCTAssertTrue(trie.contains(word: "cute"))
    XCTAssertFalse(trie.contains(word: "cut"))
    trie.insert(word: "cut")
    XCTAssertTrue(trie.contains(word: "cut"))
    XCTAssertEqual(trie.count, 4)
	FileHandle.standardError.write(Data("[ERROR] testInsert(): trie → \(trie)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testInsert()\n".utf8))
  }

  /// Tests the remove method
  func testRemove() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testRemove()\n".utf8))
    let trie = Trie()
    trie.insert(word: "cute")
    trie.insert(word: "cut")
    XCTAssertEqual(trie.count, 2)
    trie.remove(word: "cute")
    XCTAssertTrue(trie.contains(word: "cut"))
    XCTAssertFalse(trie.contains(word: "cute"))
    XCTAssertEqual(trie.count, 1)
	FileHandle.standardError.write(Data("[ERROR] testRemove(): trie → \(trie)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testRemove()\n".utf8))
  }

  /// Tests the words property
  func testWords() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testWords()\n".utf8))
    let trie = Trie()
    var words = trie.words
	FileHandle.standardError.write(Data("[ERROR] testWords(): trie → \(trie)\n".utf8))
    XCTAssertEqual(words.count, 0)
    trie.insert(word: "foobar")
    words = trie.words
    XCTAssertEqual(words[0], "foobar")
    XCTAssertEqual(words.count, 1)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testWords()\n".utf8))
  }

  /// Tests the performance of the insert method.
  func testInsertPerformance() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testInsertPerformance()\n".utf8))
    self.measure {
      let trie = Trie()
      for word in self.wordArray! {
	FileHandle.standardError.write(Data("[ERROR] testInsertPerformance(): trie → \(trie)\n".utf8))
        trie.insert(word: word)
      }
    }
    XCTAssertGreaterThan(trie.count, 0)
    XCTAssertEqual(trie.count, wordArray?.count)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testInsertPerformance()\n".utf8))
  }

  /// Tests the performance of the insert method when the words are already
  /// present.
  func testInsertAgainPerformance() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testInsertAgainPerformance()\n".utf8))
    self.measure {
      for word in self.wordArray! {
        self.trie.insert(word: word)
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testInsertAgainPerformance()\n".utf8))
  }

  /// Tests the performance of the contains method.
  func testContainsPerformance() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testContainsPerformance()\n".utf8))
    self.measure {
      for word in self.wordArray! {
        XCTAssertTrue(self.trie.contains(word: word))
      }
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testContainsPerformance()\n".utf8))
  }

  /// Tests the performance of the remove method.  Since setup has already put
  /// words into the trie, remove them before measuring performance.
  func testRemovePerformance() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testRemovePerformance()\n".utf8))
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
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testRemovePerformance()\n".utf8))
  }

  /// Tests the performance of the words computed property.  Also tests to see
  /// if it worked properly.
  func testWordsPerformance() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testWordsPerformance()\n".utf8))
    var words: [String]?
    self.measure {
      words = self.trie.words
	FileHandle.standardError.write(Data("[DEBUG] testWordsPerformance(): words → \(words)\n".utf8))
    }
    XCTAssertEqual(words?.count, trie.count)
    for word in words! {
      XCTAssertTrue(self.trie.contains(word: word))
    }
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testWordsPerformance()\n".utf8))
  }

  /// Tests the archiving and unarchiving of the trie.
  func testArchiveAndUnarchive() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testArchiveAndUnarchive()\n".utf8))
    let resourcePath = Bundle.main.resourcePath! as NSString
    let fileName = "dictionary-archive"
	FileHandle.standardError.write(Data("[ERROR] testArchiveAndUnarchive(): fileName → \(fileName)\n".utf8))
    let filePath = resourcePath.appendingPathComponent(fileName)
    NSKeyedArchiver.archiveRootObject(trie, toFile: filePath)
    let trieCopy = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? Trie
	FileHandle.standardError.write(Data("[ERROR] testArchiveAndUnarchive(): filePath → \(filePath)\n".utf8))
    XCTAssertEqual(trieCopy?.count, trie.count)
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testArchiveAndUnarchive()\n".utf8))
  }
  
  /// Tests whether word prefixes are properly found and returned.
  func testFindWordsWithPrefix() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testFindWordsWithPrefix()\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] testFindWordsWithPrefix(): trie → \(trie)\n".utf8))
    trie.insert(word: unicodeWord)
    let wordsUnicode = trie.findWordsWithPrefix(prefix: "😬")
    XCTAssertEqual(wordsUnicode, [unicodeWord])
    trie.insert(word: "Team")
    let wordsUpperCase = trie.findWordsWithPrefix(prefix: "Te")
    XCTAssertEqual(wordsUpperCase.sorted(), ["team", "test"])
	FileHandle.standardError.write(Data("[ERROR] testFindWordsWithPrefix(): wordsUnicode → \(wordsUnicode)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testFindWordsWithPrefix()\n".utf8))
  }

  /// Tests whether word prefixes are properly detected on a boolean contains() check.
  func testContainsWordMatchPrefix() {
	FileHandle.standardError.write(Data("[ERROR] >>> Entering testContainsWordMatchPrefix()\n".utf8))
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
	FileHandle.standardError.write(Data("[ERROR] testContainsWordMatchPrefix(): trie → \(trie)\n".utf8))
    trie.insert(word: unicodeWord)
    let wordsUnicode = trie.contains(word: "😬", matchPrefix: true)
    XCTAssertEqual(wordsUnicode, true)
    trie.insert(word: "Team")
    let wordsUpperCase = trie.contains(word: "Te", matchPrefix: true)
    XCTAssertEqual(wordsUpperCase, true)
	FileHandle.standardError.write(Data("[ERROR] testContainsWordMatchPrefix(): wordsUnicode → \(wordsUnicode)\n".utf8))
	FileHandle.standardError.write(Data("[WARN] <<< Exiting testContainsWordMatchPrefix()\n".utf8))
  }
}
