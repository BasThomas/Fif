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
  
  var tileNumber = -1
  
  override func prepareForReuse() {
    super.prepareForReuse()
    isUserInteractionEnabled = true
  }
  
  func empty() {
    isUserInteractionEnabled = false
    puzzlePieceImageView.backgroundColor = .white
    puzzlePieceImageView.image = nil
    tileNumber = -1
  }
  
  func focus() {
    UIView.animate(withDuration: 0.8) { [weak self] in
      guard let `self` = self else { return }
      self.puzzlePieceImageView.alpha = 0.5
    }
  }
  
  func unfocus() {
    UIView.animate(withDuration: 0.8) { [weak self] in
      guard let `self` = self else { return }
      self.puzzlePieceImageView.alpha = 1.0
    }
  }
}

extension PuzzleCollectionViewCell {
  
  override var isHighlighted: Bool {
    didSet {
      isHighlighted ? focus() : unfocus()
    }
  }
  
  override var isSelected: Bool {
    didSet {
      isSelected ? focus() : unfocus()
    }
  }
}
