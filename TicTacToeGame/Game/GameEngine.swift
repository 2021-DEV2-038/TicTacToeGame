//
//  GameEngine.swift
//  TicTacToeGame
//
//  Created by Adem Özgür on 28.06.2021.
//

import Foundation

enum MoveType: String {
    case x
    case o
}

struct BoardCoordinates: Hashable {
    var x: Int
    var y: Int
}

struct Move: Equatable {
    var moveType: MoveType
    var coordinates: BoardCoordinates
}

enum GameEngineError: Error, LocalizedError, Equatable {
    
    case firstMoveNeedsToBeAnX
    
    var errorDescription: String? {
        switch self {
        case .firstMoveNeedsToBeAnX:
            return "First move need to be an x."
        }
    }
}

class GameEngine {
    
    private var moves = [Move]()
    
    func addMove(move: Move) -> Error? {
        
        if moves.isEmpty, move.moveType == .o {
            return GameEngineError.firstMoveNeedsToBeAnX
        }

        moves.append(move)
        
        return nil
    }
    
    func getNextMoveType() -> MoveType {
        
        if let lastMove = moves.last, lastMove.moveType == .x {
            return .o
        }
        
        return MoveType.x
    }
    
}
