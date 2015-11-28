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
    var offset = 0
    
    if range.startIndex < 0   // allow negative ranges
    {
      offset = abs(range.startIndex)
    }
    
    let min = UInt32(range.startIndex + offset)
    let max = UInt32(range.endIndex + offset)
    
    return Int(min + arc4random_uniform(max - min)) - offset
  }
}