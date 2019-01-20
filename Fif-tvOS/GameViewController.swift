//
//  GameViewController.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet weak var hintButton: UIButton! {
    didSet {
      hintButton.setTitle(
        NSLocalizedString("Show Hint", comment: "Show Hint button"),
        for: .normal
      )
    }
  }
  @IBOutlet weak var shuffleButton: UIButton! {
    didSet {
      shuffleButton.setTitle(
        NSLocalizedString("Shuffle", comment: "Shuffle Button"),
        for: .normal
      )
    }
  }
  @IBOutlet weak var puzzleCollectionView: UICollectionView!
  @IBOutlet weak var solvedImageView: UIImageView!
  
  var puzzle: Puzzle! {
    didSet {
      solvedImageView.image = UIImage(puzzle: puzzle)
      puzzleCollectionView.reloadData()
    }
  }
  
  var emptyIndexPath: IndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    puzzle = Puzzle(type: .classic, difficulty: .normal)
  }
}

// MARK: - Deep linking
extension GameViewController {
  
  func deepLink(with puzzleName: String, difficulty: Int) {
    let puzzleType = PuzzleType(rawValue: puzzleName) ?? .escher
    let difficulty = Difficulty(rawValue: difficulty) ?? .normal
    puzzle = Puzzle(type: puzzleType, difficulty: difficulty)
  }
}

// MARK: - Actions
extension GameViewController {
  
  @IBAction func shuffle(sender: AnyObject) {
    guard var emptyIndexPath = emptyIndexPath else { return }
    
    for _ in 1...50 {
      let indexPaths = puzzleCollectionView.adjacentIndexPaths(for: emptyIndexPath)
      let randomTilenumber = Int.random(in: 0..<indexPaths.count)
      let randomIndexPath = indexPaths[randomTilenumber]
      
      guard puzzleCollectionView.swap(randomIndexPath, with: emptyIndexPath) else { continue }
      emptyIndexPath = randomIndexPath
    }
    
    self.emptyIndexPath = emptyIndexPath
  }
}

// MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {
  
  func numberOfSections(in collectionView: UICollectionView) -> Int {
    return puzzle.rows
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return puzzle.rows
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return puzzleCollectionView.dequeueReusableCell(withReuseIdentifier: Constant.ReuseIdentifier.puzzlePiece, for: indexPath)
  }
  
  func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    guard let cell = cell as? PuzzleCollectionViewCell else { return }
    cell.tileNumber = 1 + indexPath.row + (indexPath.section * puzzle.rows)
    guard cell.tileNumber != Int(pow(Double(puzzle.rows), 2)) else {
      emptyIndexPath = indexPath
      return cell.empty()
    }
    if puzzle.puzzleType == .classic {
      hintButton.isEnabled = false
      cell.tileNumberLabel.isHidden = false
      cell.backgroundColor = .random
    } else {
      hintButton.isEnabled = true
      guard let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame else { return }
      
      let image = UIImage(puzzle: puzzle)?.crop(to: CGRect(
        origin: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
        size: CGSize(width: cellFrame.width, height: cellFrame.height)))
      
      cell.puzzlePieceImageView.image = image
    }
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    guard let emptyIndexPath = emptyIndexPath else { return }
    // Check if the cell can be moved; or if it touches the emptyIndexPath.
    _ = collectionView.swap(indexPath, with: emptyIndexPath) { [weak self] isSwapped in
      guard
        let `self` = self,
        isSwapped else { return }
      self.emptyIndexPath = indexPath
    }
  }
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = puzzleCollectionView.frame.size.width / CGFloat(puzzle.rows)
    return CGSize(width: width, height: width)
  }
}

// MARK: - TouchButtonDelegate + Hintable
extension GameViewController: TouchButtonDelegate, Hintable {
  
  func pressBegan(_ sender: Any) {
    showHint(sender)
  }
  
  func pressEnded(_ sender: Any) {
    hideHint(sender)
  }
  
  func pressCancelled(_ sender: Any) {
    hideHint(sender)
  }
  
  // MARK: Actions
  func showHint(_ sender: Any) {
    UIView.animate(withDuration: 0.7) { [weak self] in
      guard let `self` = self else { return }
      self.solvedImageView.alpha = 1.0
      self.puzzleCollectionView.alpha = 0.0
    }
  }
  
  func hideHint(_ sender: Any) {
    guard let button = sender as? TouchButton else { return }
    button.isHighlighted = false
    UIView.animate(withDuration: 0.7) { [weak self] in
      guard let `self` = self else { return }
      self.solvedImageView.alpha = 0.0
      self.puzzleCollectionView.alpha = 1.0
    }
  }
}
