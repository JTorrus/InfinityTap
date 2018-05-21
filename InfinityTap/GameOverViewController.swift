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
}
