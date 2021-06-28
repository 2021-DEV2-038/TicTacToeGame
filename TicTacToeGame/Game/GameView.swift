//
//  GameView.swift
//  TicTacToeGame
//
//  Created by Anonymous on 27.06.2021.
//

import UIKit

class GameView: UIView {
    
    private let gameEngine = GameEngine()
    
    private var stackView: UIStackView!
    private var statusLabel: UILabel!
    private var restartGameButton: UIButton!
    
    private var allGameButtons = [GameBoardButton]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        updateGameStatusLabel()
        updateRestartGameButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
        updateGameStatusLabel()
        updateRestartGameButton()
    }
    
    private func setup() {
        
        stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 8
        stackView.distribution = .fill
        
        statusLabel = UILabel()
        statusLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        statusLabel.translatesAutoresizingMaskIntoConstraints = false
        statusLabel.textColor = UIColor.black
        stackView.addArrangedSubview(statusLabel)
        stackView.addArrangedSubview(getGameBoardStackView())
        
        
        restartGameButton = UIButton()
        restartGameButton.addTarget(self, action: #selector(resetGame(sender:)), for: .touchUpInside)
        restartGameButton.setTitle("Restart Game", for: .normal)
        restartGameButton.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        restartGameButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        stackView.addArrangedSubview(restartGameButton)
        NSLayoutConstraint.activate([
            restartGameButton.heightAnchor.constraint(equalToConstant: 54)
        ])
        
        addSubview(stackView)
        stackView.pinEdges(to: self)
        
        translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func getGameBoardStackView() -> UIStackView {
        
        let rowsStackView = UIStackView()
        rowsStackView.axis = .vertical
        rowsStackView.translatesAutoresizingMaskIntoConstraints = false
        rowsStackView.spacing = 8
        rowsStackView.distribution = .fillEqually
        
        for i in 0..<GameEngine.boardSize {
            
            let line = UIStackView()
            line.axis = .horizontal
            line.translatesAutoresizingMaskIntoConstraints = false
            line.spacing = 8
            line.distribution = .fillEqually
            
            for j in 0..<GameEngine.boardSize {
                let button = GameBoardButton(boardCoordinates: BoardCoordinates(x: j, y: i))
                allGameButtons.append(button)
                button.widthAnchor.constraint(equalTo: button.heightAnchor).isActive = true
                button.addTarget(self, action: #selector(didTapGameButton(sender:)), for: .touchUpInside)
                line.addArrangedSubview(button)
            }
            
            rowsStackView.addArrangedSubview(line)
        }
        
        return rowsStackView
    }
    
    private func updateGameStatusLabel() {
        switch gameEngine.gameState {
        case .inProgress:
            statusLabel.text = "Next turn: " + gameEngine.getNextMoveType().rawValue
        case .ended(let gameResult):
            switch gameResult {
            case .draw:
                statusLabel.text = "Game ended!. It is a draw."
            case .won(let move):
                statusLabel.text = "Game ended! \(move.moveType.rawValue) won the game."
            }
        }
    }
    
    @objc private func didTapGameButton(sender: GameBoardButton) {
        
        let move = Move(moveType: gameEngine.getNextMoveType(), coordinates: sender.boardCoordinates)
        
        if let error = gameEngine.addMove(move: move) {
            print(error)
        } else {
            sender.setTitle(move.moveType.rawValue, for: .normal)
        }
        updateRestartGameButton()
        updateGameStatusLabel()
    }
    
    private func updateRestartGameButton() {
        
        switch gameEngine.gameState {
        case .inProgress:
            restartGameButton.alpha = 0.0
        case .ended:
            restartGameButton.alpha = 1.0
        }
    }
    
    @objc private func resetGame(sender: UIButton) {
        gameEngine.restart()
        updateGameStatusLabel()
        updateRestartGameButton()
        
        for button in allGameButtons {
            button.setTitle("", for: .normal)
        }
    }

}
