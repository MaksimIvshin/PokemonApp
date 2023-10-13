//
//  PokemonAppTests.swift
//  PokemonAppTests
//
//  Created by Maks Ivshin on 30.09.23.
//

import XCTest
@testable import PokemonApp
// MARK: - Test for file manager.
class LocalFileManagerTests: XCTestCase {
    var fileManager: LocalFileManager!
    // Initialization.
    override func setUp() {
        super.setUp()
        fileManager = LocalFileManager()
    }
    // Clean up resources after finishing the test.
    override func tearDown() {
        fileManager = nil
        super.tearDown()
    }
    func testSaveString() {
        // Arrange
        let stringName = "testString"
        let testString = "This is a test string"
        // Act
        fileManager.saveString(testString, withName: stringName)
        // Assert
        let savedString = fileManager.getString(named: stringName)
        XCTAssertEqual(savedString, testString, "Saved string does not match")
    }
    func testSaveInteger() {
        // Arrange
        let integerName = "testInteger"
        let testInteger = 42
        // Act
        fileManager.saveInteger(testInteger, withName: integerName)
        // Assert
        let savedInteger = fileManager.getInteger(named: integerName)
        XCTAssertEqual(savedInteger, testInteger, "Saved integer does not match")
    }
}
