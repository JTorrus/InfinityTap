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
    var gameDuration: Int
    var cells: [Cell] = [Cell]()
    
    init(rows: Int, cols: Int, gameDuration: Int) {
        self.rows = rows
        self.cols = cols
        self.gameDuration = gameDuration
        self.cells = generateCells()
    }
    
    private func randomizeCorrectCellPositionAppearance() -> Int {
        let rowsToUInt32 = UInt32(rows)
        let colsToUint32 = UInt32(cols)
        
        return Int(arc4random_uniform(rowsToUInt32 * colsToUint32))
    }
    
    func changeCells() {
        self.cells = generateCells()
    }
    
    func generateCells() -> [Cell] {
        let correctCell = randomizeCorrectCellPositionAppearance()
        var cell: Cell
        var cellsToReturn: [Cell] = [Cell]()
        
        for i in 0 ..< cols * rows {
            if (i == correctCell) {
                cell = Cell(identifier: String(i), backgroundColor: UIColor(red:0.13, green:0.67, blue:0.47, alpha:1.0), isCorrect: true)
            } else {
                cell = Cell(identifier: String(i), backgroundColor: UIColor(red:0.10, green:0.31, blue:0.46, alpha:1.0), isCorrect: false)
            }
            
           cellsToReturn.append(cell)
        }
        
        return cellsToReturn
    }
    
    func didPlayerHitTheCorrectCell(cellHit: inout Cell) -> Bool {
        if cellHit.isCorrect {
            cellHit.isCorrect = false
            cellHit.backgroundColor = UIColor(red:0.10, green:0.31, blue:0.46, alpha:1.0)
            return true
        } else {
            return false
        }
    }
}
