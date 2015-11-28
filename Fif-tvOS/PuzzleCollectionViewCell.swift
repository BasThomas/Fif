//
//  PuzzleCollectionViewCell.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

private let debug = true

class PuzzleCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var puzzlePieceImageView: UIImageView!
  @IBOutlet weak var tileNumberLabel: UILabel!
  
  var tileNumber: Int = -1 {
    didSet {
      guard tileNumber != -1 else { tileNumberLabel.text = nil; return }
      tileNumberLabel.text = "\(tileNumber)"
    }
  }
  
  override func awakeFromNib() {
    if debug { tileNumberLabel.hidden = false }
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    userInteractionEnabled = true
  }
  
  func empty() {
    userInteractionEnabled = false
    puzzlePieceImageView.image = nil
    tileNumber = -1
  }
  
  func focus() {
    puzzlePieceImageView.alpha = 0.5
  }
  
  func unfocus() {
    puzzlePieceImageView.alpha = 1.0
  }
}

// MARK: - UIFocusEnvironment
extension PuzzleCollectionViewCell {
  
  override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
    coordinator.addCoordinatedAnimations({
      if self.focused {
        self.focus()
      } else {
        self.unfocus()
      }
    }, completion: nil)
  }
}