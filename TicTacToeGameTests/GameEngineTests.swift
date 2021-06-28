//
//  GameEngineTests.swift
//  TicTacToeGameTests
//
//  Created by Adem Özgür on 28.06.2021.
//

import XCTest
@testable import TicTacToeGame

class GameEngineTests: XCTestCase {

    func testFirstMove() {
        let gameEngine = GameEngine()
        let move = Move(moveType: .o, coordinates: BoardCoordinates(x: 0, y: 0))
        let result = gameEngine.addMove(move: move)
        guard let error = result as? GameEngineError else {
            XCTFail("It should return an error here."); return
        }
        XCTAssertTrue(error == GameEngineError.firstMoveNeedsToBeAnX)
    }
    
    func testSuccessfullAddMoveShouldReturnNil() {
        let gameEngine = GameEngine()
        let move = Move(moveType: .x, coordinates: BoardCoordinates(x: 0, y: 0))
        let result = gameEngine.addMove(move: move)
        XCTAssertTrue(result == nil)
    }
    
    func testGetNextMoveType() {
        let gameEngine = GameEngine()
        let nextMoveType = gameEngine.getNextMoveType()
        XCTAssertTrue(nextMoveType == .x)
    }
    
    func getSecondMoveType() {
        
        let gameEngine = GameEngine()
        
        var nextMoveType = gameEngine.getNextMoveType()
        let move = Move(moveType: nextMoveType, coordinates: BoardCoordinates(x: 0, y: 0))
        gameEngine.addMove(move: move)
        
        nextMoveType = gameEngine.getNextMoveType()
        XCTAssertTrue(nextMoveType == .o)
    }

    func testAlternatingMoveTypes() {
        let gameEngine = GameEngine()
        
        var move = Move(moveType: .x, coordinates: BoardCoordinates(x: 0, y: 0))
        gameEngine.addMove(move: move)
        
        move = Move(moveType: .x, coordinates: BoardCoordinates(x: 0, y: 1))
        let result = gameEngine.addMove(move: move)
        guard let error = result as? GameEngineError else {
            XCTFail("It should return an error here."); return
        }
        XCTAssertTrue(error == GameEngineError.moveTypesMustBeAlternating)
    }
    
    func testOccupiedSlot() {
        let gameEngine = GameEngine()
        
        var move = Move(moveType: gameEngine.getNextMoveType(), coordinates: BoardCoordinates(x: 0, y: 0))
        gameEngine.addMove(move: move)
        
        move = Move(moveType: gameEngine.getNextMoveType(), coordinates: BoardCoordinates(x: 0, y: 0))
        let result = gameEngine.addMove(move: move)
        guard let error = result as? GameEngineError else {
            XCTFail("It should return an error here."); return
        }
        XCTAssertTrue(error == GameEngineError.occupiedSlot)
        
    }
    
    func testGameStateAtTheBeginning() {
        let gameEngine = GameEngine()
        XCTAssertTrue(gameEngine.gameState == .inProgress)
    }
}
