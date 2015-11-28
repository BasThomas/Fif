//
//  GameViewController.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet weak var puzzleCollectionView: UICollectionView!
  @IBOutlet weak var solvedImageView: UIImageView!
  
  var puzzle: Puzzle! {
    didSet {
      solvedImageView.image = UIImage(puzzle: puzzle)
      puzzleCollectionView.reloadData()
    }
  }
  
  var emptyIndexPath: NSIndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    puzzle = Puzzle(type: .Escher, difficulty: .Easy)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Deep linking
extension GameViewController {
  
  func deepLink(puzzleName: String) {
    guard let puzzleType = PuzzleType(rawValue: puzzleName) else { return }
    puzzle = Puzzle(type: puzzleType, difficulty: .Easy)
  }
}

// MARK: - Actions
extension GameViewController {
  
  @IBAction func shuffle(sender: AnyObject) {
    guard var emptyIndexPath = emptyIndexPath else { return }
    
    for _ in 1...50 {
      let indexPaths = puzzleCollectionView.adjacentIndexPaths(forIndexPath: emptyIndexPath)
      let randomTilenumber = Int.random(inRange: 0...indexPaths.count - 1)
      let randomIndexPath = indexPaths[randomTilenumber]
      
      guard puzzleCollectionView.swap(indexPath: randomIndexPath, withIndexPath: emptyIndexPath, completionHandler: nil) else { continue }
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
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return puzzle.rows
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return puzzleCollectionView.dequeueReusableCellWithReuseIdentifier(Constant.ReuseIdentifier.puzzlePiece, forIndexPath: indexPath)
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    guard let cell = cell as? PuzzleCollectionViewCell else { return }
    cell.tileNumber = 1 + indexPath.row + (indexPath.section * puzzle.rows)
    guard cell.tileNumber != pow(puzzle.rows, 2) else { emptyIndexPath = indexPath; return cell.empty() }
    guard let cellFrame = collectionView.layoutAttributesForItemAtIndexPath(indexPath)?.frame else { return }
    
    let image = UIImage(puzzle: puzzle)?.crop(toRect: CGRect(
      origin: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
      size: CGSize(width: cellFrame.width, height: cellFrame.height)))
    
    cell.puzzlePieceImageView.image = image
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    guard let emptyIndexPath = emptyIndexPath else { return }
    // Check if the cell can be moved; or if it touches the emptyIndexPath.
    collectionView.swap(indexPath: indexPath, withIndexPath: emptyIndexPath) { swapped in
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
    showHint(sender)
  }
  
  func pressEnded(sender: AnyObject) {
    hideHint(sender)
  }
  
  func pressCancelled(sender: AnyObject) {
    hideHint(sender)
  }
  
  // MARK: Actions
  func showHint(sender: AnyObject) {
    UIView.animateWithDuration(0.7) {
      self.solvedImageView.alpha = 1.0
      self.puzzleCollectionView.alpha = 0.0
    }
  }
  
  func hideHint(sender: AnyObject) {
    guard let button = sender as? TouchButton else { return }
    button.highlighted = false
    UIView.animateWithDuration(0.7) {
      self.solvedImageView.alpha = 0.0
      self.puzzleCollectionView.alpha = 1.0
    }
  }
}