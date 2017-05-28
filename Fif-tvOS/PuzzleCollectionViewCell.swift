//
//  PuzzleCollectionViewCell.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

private let debug = false

class PuzzleCollectionViewCell: UICollectionViewCell {
  
  @IBOutlet weak var puzzlePieceImageView: UIImageView!
  @IBOutlet weak var tileNumberLabel: UILabel!
  
  var tileNumber: Int = -1 {
    didSet {
      guard tileNumber != -1 else {
        tileNumberLabel.text = nil
        return
      }
      tileNumberLabel.text = "\(tileNumber)"
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    tileNumberLabel.isHidden = !debug
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    puzzlePieceImageView.image = nil
    backgroundColor = nil
    tileNumberLabel.isHidden = !debug
    isUserInteractionEnabled = true
  }
  
  func empty() {
    isUserInteractionEnabled = false
    puzzlePieceImageView.image = nil
    tileNumber = -1
  }
  
  func focus() {
    backgroundColor = backgroundColor?.withAlphaComponent(0.5)
    puzzlePieceImageView.alpha = 0.5
  }
  
  func unfocus() {
    backgroundColor = backgroundColor?.withAlphaComponent(1.0)
    puzzlePieceImageView.alpha = 1.0
  }
}

// MARK: - UIFocusEnvironment
extension PuzzleCollectionViewCell {
  
  override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
    coordinator.addCoordinatedAnimations({
      if self.isFocused {
        self.focus()
      } else {
        self.unfocus()
      }
    }, completion: nil)
  }
}
