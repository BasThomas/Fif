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
  
  var game: Game!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    game = Game(difficulty: .Normal)
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
    return game._rows
  }
  
  func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return game._rows
  }
  
  func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    return puzzleCollectionView.dequeueReusableCellWithReuseIdentifier(Constant.ReuseIdentifier.puzzlePiece, forIndexPath: indexPath)
  }
  
  func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
    guard let cell = cell as? PuzzleCollectionViewCell else { return }
    cell.tileNumber = 1 + indexPath.row + (indexPath.section * game._rows)
    if let cellFrame = collectionView.layoutAttributesForItemAtIndexPath(indexPath)?.frame {
      let image = UIImage(named: "puzzle1")?.crop(toRect: CGRect(
        origin: CGPoint(x: cellFrame.minX, y: cellFrame.minY),
        size: CGSize(width: cellFrame.width, height: cellFrame.height)))
      
      cell.puzzlePieceImageView.image = image
    }
    guard cell.tileNumber != pow(game._rows, 2) else { return cell.empty() }
  }
  
  func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    guard let cell = collectionView.cellForItemAtIndexPath(indexPath) as? PuzzleCollectionViewCell else { return }
    print(cell.tileNumber)
  }
}

// MARK: - UICollectionViewDelegate
extension GameViewController: UICollectionViewDelegate {
  
  func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
    let width = puzzleCollectionView.frame.size.width / CGFloat(game._rows)
    return CGSize(width: width, height: width)
  }
}