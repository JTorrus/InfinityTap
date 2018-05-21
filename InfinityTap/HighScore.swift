//
//  HighScore.swift
//  InfinityTap
//
//  Created by Javier Torrus on 21/05/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class HighScore: Codable {
    var playerScores: [Player]
    
    init() {
        self.playerScores = [Player]()
    }
    
    func addPlayerScore(newPlayerScore: Player) {
        playerScores.append(newPlayerScore)
        playerScores.sort(){ $0>$1 }
        
        while (playerScores.count > 10) {
            playerScores.remove(at: 10)
        }
    }
}
