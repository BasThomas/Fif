//
//  Math.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

func pow(lhs: Int, _ rhs: Int) -> Int {
  let lhs = Double(lhs)
  let rhs = Double(rhs)
  let _pow = pow(lhs, rhs)
  
  return Int(_pow)
}