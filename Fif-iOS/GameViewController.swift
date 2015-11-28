//
//  GameViewController.swift
//  Fif
//
//  Created by Bas Broek on 27/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
  
  @IBOutlet var leadingConstraint: NSLayoutConstraint!
  @IBOutlet var trailingConstraint: NSLayoutConstraint!
  @IBOutlet var topConstraint: NSLayoutConstraint!
  @IBOutlet var bottomConstraint: NSLayoutConstraint!
  
  @IBOutlet var centerXConstraint: NSLayoutConstraint!
  @IBOutlet var centerYConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var puzzleCollectionView: UICollectionView!
  var puzzle: Puzzle!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    puzzle = Puzzle(type: .MountainRange, difficulty: .Easy)
    
    // Dirty auto-layout fix, for now.
    view.removeConstraint(bottomConstraint)
  }
  
  override func updateViewConstraints() {
    updatePosition()
    super.updateViewConstraints()
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
    guard cell.tileNumber != pow(puzzle.rows, 2) else { return cell.empty() }
    guard let cellFrame = collectionView.layoutAttributesForItemAtIndexPath(indexPath)?.frame else { return }
    let image = UIImage(puzzle: puzzle)?.scale(toSize: cellFrame.size).crop(toRect: CGRect(
      origin: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
      size: CGSize(width: cellFrame.width, height: cellFrame.height)))
    
    cell.puzzlePieceImageView.image = image
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    collectionView.deselectItemAtIndexPath(indexPath, animated: false)
    guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? PuzzleCollectionViewCell else { return }
    print(cell.tileNumber)
  }
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let width = puzzleCollectionView.frame.size.width / CGFloat(puzzle.rows)
    return CGSize(width: width, height: width)
  }
}

// MARK: - UIContentContainer
extension GameViewController {
  
  override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
    view.setNeedsUpdateConstraints()
  }
}

// MARK: - Helpers
private extension GameViewController {
  
  func updatePosition() {
    guard let windowSize = view.window?.bounds.size else { return }
    let higher = windowSize.height > windowSize.width
    
    if higher {
      view.removeConstraints([bottomConstraint, topConstraint, centerXConstraint])
      leadingConstraint.constant = 0.0
      trailingConstraint.constant = 0.0
      view.addConstraints([leadingConstraint, trailingConstraint, centerYConstraint])
    } else {
      view.removeConstraints([leadingConstraint, trailingConstraint, centerYConstraint])
      view.addConstraints([bottomConstraint, topConstraint, centerXConstraint])
    }
  }
  
  var currentOrientation: UIDeviceOrientation {
    return UIDevice.currentDevice().orientation
  }
}