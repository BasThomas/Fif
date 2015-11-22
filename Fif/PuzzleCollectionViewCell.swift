//
//  PuzzleCollectionViewCell.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class PuzzleCollectionViewCell: UICollectionViewCell {
    
  @IBOutlet weak var _numberLabel: UILabel! {
    didSet {
      _numberLabel.textColor = .whiteColor()
    }
  }
  
  func empty() {
    backgroundColor = .whiteColor()
    _numberLabel.text = nil
  }
  
  func focus() {
    let fontSize = self.frame.size.width * 0.8
    
    backgroundColor = backgroundColor?.colorWithAlphaComponent(0.5)
//    contentView.transform = CGAffineTransformMakeScale(2.0, 2.0)
    _numberLabel.font = UIFont.systemFontOfSize(fontSize)
  }
  
  func unfocus() {
    backgroundColor = backgroundColor?.colorWithAlphaComponent(1.0)
//    contentView.transform = CGAffineTransformMakeScale(1.0, 1.0)
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