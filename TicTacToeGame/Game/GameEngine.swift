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
    case occupiedSlot
    case moveTypesMustBeAlternating
    
    var errorDescription: String? {
        switch self {
        case .firstMoveNeedsToBeAnX:
            return "First move need to be an x."
        case .occupiedSlot:
            return "That slot is occupied, please select another one."
        case .moveTypesMustBeAlternating:
            return "Move types must be alternating."
        }
    }
}

class GameEngine {
    
    private var moves = [Move]()
    
    private var occupied = [BoardCoordinates: Move]()
    
    private func isOccupied(coordinates: BoardCoordinates) -> Bool {
        return occupied[coordinates] != nil
    }
    
    @discardableResult
    func addMove(move: Move) -> Error? {
        
        if moves.isEmpty, move.moveType == .o {
            return GameEngineError.firstMoveNeedsToBeAnX
        }
        
        guard !isOccupied(coordinates: move.coordinates) else {
            return GameEngineError.occupiedSlot
        }
        
        guard move.moveType == getNextMoveType() else {
            return GameEngineError.moveTypesMustBeAlternating
        }

        moves.append(move)
        occupied[move.coordinates] = move
        
        return nil
    }
    
    func getNextMoveType() -> MoveType {
        
        if let lastMove = moves.last, lastMove.moveType == .x {
            return .o
        }
        
        return MoveType.x
    }
    
}
