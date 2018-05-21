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
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    
    var buttonWidth: CGFloat?
    var buttonHeight: CGFloat?
    var currentGame: Game = Game(rows: 3, cols: 3, gameDuration: 10)
    var currentPlayer: Player = Player(name: Utils.playerNames[Utils.randomizePlayerName()], points: 0)
    var cellViews: [UIView] = [UIView]()
    var gameTimer: Timer = Timer()
    var gameState = GameState.RUNNING
        
    override func viewDidLoad() {
        super.viewDidLoad()
        generateBoard()
        
        timerLabel.text = "\(currentGame.gameDuration)"
        pointsLabel.text = "\(currentPlayer.points)"
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func generateBoard() {
        cellViews.removeAll()
        
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
            
            cellViews.append(newCell)
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
            
            cellViews.append(newCell)
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
            
            cellViews.append(newCell)
            gameBoard.addSubview(newCell)
        }
    }
    
    private func addTime() {
        gameTimer.invalidate()
        
        if (currentPlayer.points < 8) {
            currentGame.gameDuration = 10 - currentPlayer.points
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    private func addPoints() {
        currentPlayer.points += 1
        pointsLabel.text = "\(currentPlayer.points)"
    }
    
    private func gameOver() {
        var alert: UIAlertController?
        
        if (gameState == GameState.NON_CORRECT) {
            gameTimer.invalidate()
            alert = UIAlertController(title: "Game Over", message: "You didn't hit the correct cell", preferredStyle: UIAlertControllerStyle.alert)
        } else if (gameState == GameState.TIME_OUT) {
            alert = UIAlertController(title: "Game Over", message: "Time is out", preferredStyle: UIAlertControllerStyle.alert)
        }
        
        alert!.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            if let gameOverViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameOverVC") as? GameOverViewController {
                gameOverViewController.pointsReached = self.currentPlayer.points
                self.present(gameOverViewController, animated: true, completion: nil)
            }
        }))
        
        self.present(alert!, animated: true, completion: nil)
    }
    
    @objc private func updateTimer() {
        if (currentGame.gameDuration == 0) {
            timerLabel.text = "0"
            gameTimer.invalidate()
            gameState = GameState.TIME_OUT
            gameOver()
        } else {
            currentGame.gameDuration -= 1
            timerLabel.text = "\(currentGame.gameDuration)"
        }
    }
    
    @objc private func tap(gesture: UITapGestureRecognizer) {
        if let accessibilityIdentifier = gesture.view?.accessibilityIdentifier {
            let cellHitId = Int(accessibilityIdentifier)
            
            if (currentGame.didPlayerHitTheCorrectCell(cellHit: &currentGame.cells[cellHitId!])) {
                for subview in cellViews {
                    if (subview.accessibilityIdentifier == accessibilityIdentifier) {
                        subview.backgroundColor = currentGame.cells[cellHitId!].backgroundColor
                        addTime()
                        addPoints()
                        currentGame.changeCells()
                        generateBoard()
                    }
                }
            } else {
                gameState = GameState.NON_CORRECT
                gameOver()
            }
        }
    }
}
