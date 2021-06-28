//
//  ViewController.swift
//  TicTacToeGame
//
//  Created by Anonymous on 23.06.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let gameView = GameView()
        view.addSubview(gameView)
        gameView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        gameView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        gameView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }


}

