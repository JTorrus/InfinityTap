//
//  Player.swift
//  InfinityTap
//
//  Created by Javier Torrus on 21/05/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

struct Player: Codable, Comparable {
    var name: String
    var points: Int
    
    static func <(lhs: Player, rhs: Player) -> Bool {
        return lhs.name == rhs.name && lhs.points == rhs.points
    }
    
    static func ==(lhs: Player, rhs: Player) -> Bool {
        if (lhs.points == rhs.points) {
            return lhs.name < rhs.name
        } else {
            return lhs.points < rhs.points
        }
    }
}
