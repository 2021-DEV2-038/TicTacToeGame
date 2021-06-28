//
//  GameBoardButton.swift
//  TicTacToeGame
//
//  Created by Anonymous on 27.06.2021.
//

import UIKit

class GameBoardButton: UIButton {
    
    private(set) var boardCoordinates: BoardCoordinates
    
    init(boardCoordinates: BoardCoordinates) {
        self.boardCoordinates = boardCoordinates
        super.init(frame: CGRect.zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        self.boardCoordinates = BoardCoordinates(x: 0, y: 0)
        super.init(coder: coder)
    }
    
    func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        
        titleLabel?.font = UIFont.systemFont(ofSize: 80, weight: .semibold)
    }
}
