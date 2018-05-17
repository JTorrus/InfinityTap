//
//  GameViewController.swift
//  InfinityTap
//
//  Created by Alumne on 15/5/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var gameBoard: UIView!
    var buttonWidth: CGFloat?
    var buttonHeight: CGFloat?
    var currentGame: Game = Game(rows: 3, cols: 3, difficulty: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        generateBoard()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func generateBoard() {
        let cellHeight = gameBoard.frame.height / CGFloat(currentGame.cols)
        let cellWidth = gameBoard.frame.width / CGFloat(currentGame.rows)
        
        for i in 0 ..< currentGame.rows {
            let newCell = UIView(frame: CGRect(x: CGFloat(i) * cellWidth, y: 0, width: cellWidth, height: cellHeight))
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
            
            newCell.accessibilityIdentifier = currentGame.cells[i].identifier
            newCell.backgroundColor = currentGame.cells[i].backgroundColor
            newCell.layer.borderColor = UIColor.white.cgColor
            newCell.layer.borderWidth = 1.0
            newCell.addGestureRecognizer(tapGestureRecognizer)
            
            gameBoard.addSubview(newCell)
        }
        
        for i in 0 ..< currentGame.rows {
            let newCell = UIView(frame: CGRect(x: CGFloat(i) * cellWidth, y: cellWidth, width: cellWidth, height: cellHeight))
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
            
            newCell.accessibilityIdentifier = currentGame.cells[i + 3].identifier
            newCell.backgroundColor = currentGame.cells[i + 3].backgroundColor
            newCell.layer.borderColor = UIColor.white.cgColor
            newCell.layer.borderWidth = 1.0
            newCell.addGestureRecognizer(tapGestureRecognizer)
            
            gameBoard.addSubview(newCell)
        }
        
        for i in 0 ..< currentGame.rows {
            let newCell = UIView(frame: CGRect(x: CGFloat(i) * cellWidth, y: cellWidth * 2, width: cellWidth, height: cellHeight))
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(gesture:)))
            
            newCell.accessibilityIdentifier = currentGame.cells[i + 6].identifier
            newCell.backgroundColor = currentGame.cells[i + 6].backgroundColor
            newCell.layer.borderColor = UIColor.white.cgColor
            newCell.layer.borderWidth = 1.0
            newCell.addGestureRecognizer(tapGestureRecognizer)
            
            gameBoard.addSubview(newCell)
        }
    }
    
    @objc func tap(gesture: UITapGestureRecognizer) {
        // TO DO
    }
}
