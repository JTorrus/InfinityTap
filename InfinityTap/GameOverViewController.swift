//
//  GameOverViewController.swift
//  InfinityTap
//
//  Created by Alumne on 15/5/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import UIKit

class GameOverViewController: UIViewController {
    
    @IBOutlet weak var reachedPointsLabel: UILabel!
    
    var pointsReached: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let points = pointsReached {
            reachedPointsLabel.text = "You reached \(points) points"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func performGame(_ sender: UIButton) {
        if let gameViewController = self.storyboard?.instantiateViewController(withIdentifier: "gameVC") as? GameViewController {
            self.present(gameViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func performScoreboard(_ sender: UIButton) {
        if let scoreboardViewController = self.storyboard?.instantiateViewController(withIdentifier: "scoreboardVC") as? ScoreboardViewController {
            self.present(scoreboardViewController, animated: true, completion: nil)
        }
    }
    
    @IBAction func performMainPage(_ sender: UIButton) {
        if let mainPageViewController = self.storyboard?.instantiateViewController(withIdentifier: "mainPageVC") as? MainPageViewController {
            self.present(mainPageViewController, animated: true, completion: nil)
        }
    }
}
