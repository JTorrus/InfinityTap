//
//  Game.swift
//  InfinityTap
//
//  Created by Alumne on 15/5/18.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation
import UIKit

class Game {
    var rows: Int
    var cols: Int
    
    init(rows: Int, cols: Int) {
        self.rows = rows
        self.cols = cols
    }
    
    private func randomizeCorrectCellPositionAppearance() -> Int {
        let rowsToUInt32 = UInt32(rows)
        let colsToUint32 = UInt32(cols)
        
        return Int(arc4random_uniform(rowsToUInt32 * colsToUint32))
    }
    
    func didPlayerHitTheCorrectCell(cellHit: inout Cell) -> Int? {
        if cellHit.isCorrect {
            cellHit.isCorrect = false
            cellHit.backgroundColor = UIColor(red:0.10, green:0.31, blue:0.46, alpha:1.0)
            return randomizeCorrectCellPositionAppearance()
        } else {
            return nil
        }
    }
}
