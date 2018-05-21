//
//  Utils.swift
//  InfinityTap
//
//  Created by Javier Torrus on 21/05/2018.
//  Copyright © 2018 Alumne. All rights reserved.
//

import Foundation

class Utils {
    static let playerNames = ["CaptainAmerica\(CFAbsoluteTimeGetCurrent())", "BlackWidow\(CFAbsoluteTimeGetCurrent())", "BlackPanther\(CFAbsoluteTimeGetCurrent())", "IronMan\(CFAbsoluteTimeGetCurrent())", "WinterSoldier\(CFAbsoluteTimeGetCurrent())", "SpiderMan\(CFAbsoluteTimeGetCurrent())", "Hulk\(CFAbsoluteTimeGetCurrent())", "DrStrange\(CFAbsoluteTimeGetCurrent())", "Thor\(CFAbsoluteTimeGetCurrent())"]
    
    static func randomizePlayerName() -> Int {
        return Int(arc4random_uniform(UInt32(playerNames.count - 1)))
    }
}
