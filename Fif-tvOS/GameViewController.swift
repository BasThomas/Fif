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
      hintButton.setTitle("Show hint".localized, for: .normal)
    }
  }
  @IBOutlet weak var shuffleButton: UIButton! {
    didSet {
      shuffleButton.setTitle("Shuffle".localized, for: .normal)
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
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Deep linking
extension GameViewController {
  
  func deepLink(withPuzzleName puzzleName: String, difficulty: Int) {
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
      let randomTilenumber = Int.random(inRange: 0..<indexPaths.count)
      let randomIndexPath = indexPaths[randomTilenumber]
      
      guard puzzleCollectionView.swap(randomIndexPath, with: emptyIndexPath) else { continue }
      emptyIndexPath = randomIndexPath
    }
    
    self.emptyIndexPath = emptyIndexPath
  }
}

// MARK: - UICollectionViewDataSource
extension GameViewController: UICollectionViewDataSource {
  
  func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
    return puzzle.rows
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return puzzle.rows
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return puzzleCollectionView.dequeueReusableCell(withReuseIdentifier: Constant.ReuseIdentifier.puzzlePiece, for: indexPath)
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: IndexPath) {
    guard let cell = cell as? PuzzleCollectionViewCell else { return }
    cell.tileNumber = 1 + indexPath.row + (indexPath.section * puzzle.rows)
    guard cell.tileNumber != Int(pow(Double(puzzle.rows), 2)) else {
      emptyIndexPath = indexPath
      return cell.empty()
    }
    if puzzle.puzzleType == .classic {
      hintButton.isEnabled = false
      cell.tileNumberLabel.isHidden = false
      cell.backgroundColor = .randomColor()
    } else {
      hintButton.isEnabled = true
      guard let cellFrame = collectionView.layoutAttributesForItem(at: indexPath)?.frame else { return }
      
      let image = UIImage(puzzle: puzzle)?.crop(to: CGRect(
        origin: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
        size: CGSize(width: cellFrame.width, height: cellFrame.height)))
      
      cell.puzzlePieceImageView.image = image
    }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: IndexPath) {
    guard let emptyIndexPath = emptyIndexPath else { return }
    // Check if the cell can be moved; or if it touches the emptyIndexPath.
    _ = collectionView.swap(indexPath, with: emptyIndexPath) { swapped in
      guard swapped else { return }
      self.emptyIndexPath = indexPath
    }
  }
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let width = puzzleCollectionView.frame.size.width / CGFloat(puzzle.rows)
    return CGSize(width: width, height: width)
  }
}

// MARK: - TouchButtonDelegate + Hintable
extension GameViewController: TouchButtonDelegate, Hintable {
  
  func pressBegan(sender: AnyObject) {
    showHint(sender: sender)
  }
  
  func pressEnded(sender: AnyObject) {
    hideHint(sender: sender)
  }
  
  func pressCancelled(sender: AnyObject) {
    hideHint(sender: sender)
  }
  
  // MARK: Actions
  func showHint(sender: AnyObject) {
    UIView.animate(withDuration: 0.7) {
      self.solvedImageView.alpha = 1.0
      self.puzzleCollectionView.alpha = 0.0
    }
  }
  
  func hideHint(sender: AnyObject) {
    guard let button = sender as? TouchButton else { return }
    button.isHighlighted = false
    UIView.animate(withDuration: 0.7) {
      self.solvedImageView.alpha = 0.0
      self.puzzleCollectionView.alpha = 1.0
    }
  }
}
