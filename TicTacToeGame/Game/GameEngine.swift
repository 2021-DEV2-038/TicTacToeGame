//
//  GameEngine.swift
//  TicTacToeGame
//
//  Created by Anonymous on 28.06.2021.
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

enum GameResult: Equatable {
    case draw
    // keeping a copy of last move won the game
    case won(Move)
}

enum GameState: Equatable {
    case inProgress
    case ended(GameResult)
}

enum GameEngineError: Error, LocalizedError, Equatable {
    
    case firstMoveNeedsToBeAnX
    case occupiedSlot
    case moveTypesMustBeAlternating
    case gameEnded(GameResult)
    
    var errorDescription: String? {
        switch self {
        case .firstMoveNeedsToBeAnX:
            return "First move need to be an x."
        case .occupiedSlot:
            return "That slot is occupied, please select another one."
        case .moveTypesMustBeAlternating:
            return "Move types must be alternating."
        case .gameEnded:
            return "Game ended, please restart the game."
        }
    }
}

class GameEngine {
    
    static let boardSize = 3
    
    private(set) var gameState: GameState = .inProgress
    
    private var moves = [Move]()
    
    private var occupied = [BoardCoordinates: Move]()
    
    private func isOccupied(coordinates: BoardCoordinates) -> Bool {
        return occupied[coordinates] != nil
    }
    
    @discardableResult
    func addMove(move: Move) -> Error? {
        
        switch gameState {
        case .ended(let result):
            return GameEngineError.gameEnded(result)
        default:
            break
        }
        
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
        
        if isWinnerMove() {
            gameState = .ended(GameResult.won(move))
        } else {
            if occupied.count == GameEngine.boardSize * GameEngine.boardSize {
                gameState = .ended(GameResult.draw)
            }
        }
        
        return nil
    }
    
    func getNextMoveType() -> MoveType {
        
        if let lastMove = moves.last, lastMove.moveType == .x {
            return .o
        }
        
        return MoveType.x
    }
    
    private func getWholeRow(y: Int) -> [Move] {
        var moves = [Move?]()
        
        for x in 0..<GameEngine.boardSize {
            moves.append(occupied[BoardCoordinates(x: x, y: y)])
        }
        
        return moves.compactMap({ $0 })
    }
    
    private func getWholeColumn(x: Int) -> [Move] {
        var moves = [Move?]()
        
        for y in 0..<GameEngine.boardSize {
            moves.append(occupied[BoardCoordinates(x: x, y: y)])
        }
        
        return moves.compactMap({ $0 })
    }
    
    private func getFirstDiagonal() -> [Move] {
        var moves = [Move?]()
        
        for i in 0..<GameEngine.boardSize {
            moves.append(occupied[BoardCoordinates(x: i, y: i)])
        }
        
        return moves.compactMap({ $0 })
    }
    
    private func getSecondDiagonal() -> [Move] {
        var moves = [Move?]()
        
        for i in 0..<GameEngine.boardSize {
            
            moves.append(occupied[BoardCoordinates(x: GameEngine.boardSize - 1 - i, y: i)])
            
        }
        
        return moves.compactMap({ $0 })
    }
    
    private func isWinnerMove() -> Bool {
        
        guard let lastMove = moves.last else { return false }
        
        // if last move's row all the same, then last move is winner
        if getWholeRow(y: lastMove.coordinates.y).filter({ $0.moveType == lastMove.moveType }).count == GameEngine.boardSize {
            return true
        }
        
        // if last move's column all the same, then last move is winner
        if getWholeColumn(x: lastMove.coordinates.x).filter({ $0.moveType == lastMove.moveType }).count == GameEngine.boardSize {
            return true
        }
        
        // is it on diagonal?
        guard lastMove.coordinates.x == lastMove.coordinates.y || (lastMove.coordinates.x + lastMove.coordinates.y) == GameEngine.boardSize - 1 else {
            return false
        }
        
        // if last move's column all the same, then last move is winner
        if getFirstDiagonal().filter({ $0.moveType == lastMove.moveType }).count == GameEngine.boardSize {
            return true
        }
        
        if getSecondDiagonal().filter({ $0.moveType == lastMove.moveType }).count == GameEngine.boardSize {
            return true
        }
        
        return false
    }
    
    func restart() {
        moves.removeAll()
        occupied.removeAll()
        gameState = .inProgress
    }
}
