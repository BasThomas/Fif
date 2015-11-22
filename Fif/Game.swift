//
//  Game.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

struct Game {
  var difficulty: Difficulty
  var _rows: Int
  
  init(difficulty: Difficulty) {
    self.difficulty = difficulty
    self._rows = difficulty.rawValue
  }
}

enum Difficulty: Int {
  case Easy = 3
  case Normal = 4
  case Hard = 5
}