//
//  Puzzle.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

struct Puzzle {
  var puzzleType: PuzzleType
  var difficulty: Difficulty
  private (set) var _rows: Int
  
  init(type puzzleType: PuzzleType, difficulty: Difficulty) {
    self.puzzleType = puzzleType
    self.difficulty = difficulty
    self._rows = difficulty.rawValue
  }
}

enum PuzzleType: String {
  case Escher
  case ElCapitan
  case MountainRange
}

enum Difficulty: Int {
  case Easy = 3
  case Normal = 4
  case Hard = 5
}