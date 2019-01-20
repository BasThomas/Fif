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
  private (set) var rows: Int
  
  init(type puzzleType: PuzzleType, difficulty: Difficulty) {
    self.puzzleType = puzzleType
    self.difficulty = difficulty
    self.rows = difficulty.rawValue
  }
}

enum PuzzleType: String {
  case escher
  case elCapitan
  case mountainRange
  case classic
}

extension PuzzleType: CustomStringConvertible {
  
  var description: String {
    return NSLocalizedString(rawValue, comment: "")
  }
}

enum Difficulty: Int {
  case easy = 3
  case normal = 4
  case hard = 5
}

// MARK: - CustomStringConvertible
extension Difficulty: CustomStringConvertible {
  
  var description: String {
    switch self {
    case .easy:
      return NSLocalizedString("Easy", comment: "Easy difficulty")
    case .normal:
      return NSLocalizedString("Normal", comment: "Normal difficulty")
    case .hard:
      return NSLocalizedString("Hard", comment: "Hard difficulty")
    }
  }
}
