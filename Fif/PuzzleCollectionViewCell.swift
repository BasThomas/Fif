//
//  PuzzleCollectionViewCell.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class PuzzleCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var puzzlePieceImageView: UIImageView!
  
  @IBOutlet weak var _numberLabel: UILabel! {
    didSet {
      _numberLabel.textColor = .whiteColor()
    }
  }
  
  var tileNumber: Int = -1 {
    didSet {
      guard tileNumber != -1 else {
        _numberLabel.text = nil
        return
      }
      _numberLabel.text = "\(tileNumber)"
    }
  }
  
  override func prepareForReuse() {
    userInteractionEnabled = true
  }
  
  func empty() {
    userInteractionEnabled = false
    puzzlePieceImageView.backgroundColor = .whiteColor()
  }
  
  func focus() {
    let fontSize = self.frame.size.width * 0.8
    
    backgroundColor = backgroundColor?.colorWithAlphaComponent(0.5)
    _numberLabel.font = UIFont.systemFontOfSize(fontSize)
  }
  
  func unfocus() {
    backgroundColor = backgroundColor?.colorWithAlphaComponent(1.0)
    _numberLabel.font = UIFont.systemFontOfSize(50.0)
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