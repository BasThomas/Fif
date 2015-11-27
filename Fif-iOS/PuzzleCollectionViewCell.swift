//
//  PuzzleCollectionViewCell.swift
//  Fif
//
//  Created by Bas Broek on 27/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class PuzzleCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var puzzlePieceImageView: UIImageView!
  
  var tileNumber: Int = -1
  
  override func prepareForReuse() {
    super.prepareForReuse()
    userInteractionEnabled = true
  }
  
  func empty() {
    userInteractionEnabled = false
    puzzlePieceImageView.backgroundColor = .whiteColor()
    puzzlePieceImageView.image = nil
    tileNumber = -1
  }
  
  func focus() {
    UIView.animateWithDuration(0.8) {
      self.puzzlePieceImageView.alpha = 0.5
    }
  }
  
  func unfocus() {
    UIView.animateWithDuration(0.8) {
      self.puzzlePieceImageView.alpha = 1.0
    }
  }
}

// MARK: - Highlight+Select
extension PuzzleCollectionViewCell {
  
  override var highlighted: Bool {
    didSet {
      highlighted ? focus() : unfocus()
    }
  }
  
  override var selected: Bool {
    didSet {
      selected ? focus() : unfocus()
    }
  }
}