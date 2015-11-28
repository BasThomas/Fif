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
  var puzzle: Puzzle!
  var emptyIndexPath: NSIndexPath?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    puzzle = Puzzle(type: .Escher, difficulty: .Normal)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}

// MARK: - Actions
extension GameViewController {
  
  @IBAction func reload(sender: AnyObject) {
    puzzleCollectionView.reloadData()
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
    guard indexPath.adjacent(toIndexPath: emptyIndexPath, inCollectionView: collectionView) else { return }
    
    collectionView.performBatchUpdates( {
      collectionView.moveItemAtIndexPath(indexPath, toIndexPath: emptyIndexPath)
      collectionView.moveItemAtIndexPath(emptyIndexPath, toIndexPath: indexPath)
    }, completion: { success in
      self.emptyIndexPath = indexPath
    })
  }
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let width = puzzleCollectionView.frame.size.width / CGFloat(puzzle._rows)
    return CGSize(width: width, height: width)
  }
}