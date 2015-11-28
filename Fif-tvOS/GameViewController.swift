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
  
  var puzzle: Puzzle!
  var emptyIndexPath: NSIndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    puzzle = Puzzle(type: .Escher, difficulty: .Normal)
    solvedImageView.image = UIImage(puzzle: puzzle)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Actions
extension GameViewController {
  
  @IBAction func hint(sender: AnyObject) {
    guard let button = sender as? UIButton else { return }
    guard let buttonText = button.titleLabel?.text else { return }
    
    if buttonText == "Show hint" {
      UIView.animateWithDuration(1.0, animations: {
        self.solvedImageView.alpha = 1.0
        self.puzzleCollectionView.alpha = 0.0
      }, completion: { _ in
        button.setTitle("Hide hint", forState: .Normal)
      })
    } else if buttonText == "Hide hint" {
      UIView.animateWithDuration(1.0, animations: {
        self.solvedImageView.alpha = 0.0
        self.puzzleCollectionView.alpha = 1.0
      }, completion: { _ in
        button.setTitle("Show hint", forState: .Normal)
      })
    }
  }
  
  @IBAction func shuffle(sender: AnyObject) {
    guard var emptyIndexPath = emptyIndexPath else { return }
    
    for _ in 1...pow(puzzle._rows, 2) {
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
    return puzzle._rows
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return puzzle._rows
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return puzzleCollectionView.dequeueReusableCellWithReuseIdentifier(Constant.ReuseIdentifier.puzzlePiece, forIndexPath: indexPath)
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    guard let cell = cell as? PuzzleCollectionViewCell else { return }
    cell.tileNumber = 1 + indexPath.row + (indexPath.section * puzzle._rows)
    guard cell.tileNumber != pow(puzzle._rows, 2) else { emptyIndexPath = indexPath; return cell.empty() }
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
    let width = puzzleCollectionView.frame.size.width / CGFloat(puzzle._rows)
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