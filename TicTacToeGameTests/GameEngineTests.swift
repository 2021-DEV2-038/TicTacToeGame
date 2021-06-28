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

}
