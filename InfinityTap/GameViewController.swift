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
    var currentPlayer: Player?
    var cellViews: [UIView] = [UIView]()
    var gameTimer: Timer = Timer()
    var gameState = GameState.RUNNING
    var auxTime: Int?
    var playerHighScore: HighScore?
    var playerNames: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateBoard()
        
        playerNames = getPlayerNames()
        currentPlayer = Player(name: playerNames![randomizePlayerName()], points: 0)
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        timerLabel.text = "\(currentGame.gameDuration)"
        pointsLabel.text = "\(currentPlayer!.points)"
        
        buildGameStatePersistence()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    private func buildGameStatePersistence() {
        let application = UIApplication.shared
        
        NotificationCenter.default.addObserver(self, selector: #selector(didApplicationGoBackground), name: Notification.Name.UIApplicationWillResignActive, object: application)
        NotificationCenter.default.addObserver(self, selector: #selector(didApplicationGoForeground), name: Notification.Name.UIApplicationDidBecomeActive, object: application)
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
        
        if (currentPlayer!.points < 8) {
            currentGame.gameDuration = 10 - currentPlayer!.points
        }
        
        gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    private func addPoints() {
        currentPlayer!.points += 1
        pointsLabel.text = "\(currentPlayer!.points)"
    }
    
    private func randomizePlayerName() -> Int {
        return Int(arc4random_uniform(UInt32(playerNames!.count - 1)))
    }
    
    private func getPlayerNames() -> [String] {
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.dateFormat = "dd-MM-yyyy hh:mm:ss"
        
        return ["CaptainAmerica\(formatter.string(from: date))", "BlackWidow\(formatter.string(from: date))", "BlackPanther\(formatter.string(from: date))", "IronMan\(formatter.string(from: date))", "WinterSoldier\(formatter.string(from: date))", "SpiderMan\(formatter.string(from: date))", "Hulk\(formatter.string(from: date))", "DrStrange\(formatter.string(from: date))", "Thor\(formatter.string(from: date))"]
    }
    
    private func gameOver() {
        var alert: UIAlertController?
        
        if (gameState == GameState.NON_CORRECT) {
            gameTimer.invalidate()
            alert = UIAlertController(title: "Game Over", message: "You didn't hit the correct cell", preferredStyle: UIAlertControllerStyle.alert)
        } else if (gameState == GameState.TIME_OUT) {
            alert = UIAlertController(title: "Game Over", message: "Time is out", preferredStyle: UIAlertControllerStyle.alert)
        }
        
        writeHighScore()
        
        alert!.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action: UIAlertAction!) in
            if let gameOverViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameOverVC") as? GameOverViewController {
                gameOverViewController.pointsReached = self.currentPlayer!.points
                self.present(gameOverViewController, animated: true, completion: nil)
            }
        }))
        
        self.present(alert!, animated: true, completion: nil)
    }
    
    private func writeHighScore() {
        if let data = UserDefaults.standard.object(forKey: "IT_HS") as? Data {
            let decoder = PropertyListDecoder()
            self.playerHighScore = try! decoder.decode(HighScore.self, from: data)
        } else {
            self.playerHighScore = HighScore()
        }
        
        self.playerHighScore!.addPlayerScore(newPlayerScore: currentPlayer!)
        
        let encoder = PropertyListEncoder()
        let data = try? encoder.encode(self.playerHighScore)
        
        UserDefaults.standard.set(data, forKey: "IT_HS")
    }
    
    @objc private func didApplicationGoBackground() {
        gameTimer.invalidate()
        auxTime = currentGame.gameDuration
    }
    
    @objc private func didApplicationGoForeground() {
        if let timeFromBackground = auxTime {
            currentGame.gameDuration = timeFromBackground
            gameTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(GameViewController.updateTimer)), userInfo: nil, repeats: true)
        }
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
