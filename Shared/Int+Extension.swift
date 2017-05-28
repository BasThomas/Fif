//
//  Int+Extension.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension Int {
  
  static func random(inRange range: Range<Int>) -> Int {
    let offset = (range.lowerBound < 0) ? abs(range.lowerBound) : 0
    let min = UInt32(range.lowerBound + offset)
    let max = UInt32(range.upperBound + offset)
    
    return Int(min + arc4random_uniform(max - min)) - offset
  }
}
