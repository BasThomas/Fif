//
//  UICollectionView+Extension.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func adjacentIndexPaths(forIndexPath indexPath: NSIndexPath) -> [NSIndexPath] {
    let indexPaths = visibleCells().flatMap { indexPathForCell($0) }
    var touchingIndexPaths: [NSIndexPath] = []
    
    for indexPath_ in indexPaths {
      guard indexPath_ != indexPath else { continue }
      let _indexPath = (section: indexPath_.section, row: indexPath_.row)
      switch _indexPath {
        // NSIndexPath above
      case (indexPath.section - 1, indexPath.row):
        touchingIndexPaths.append(indexPath_)
        // NSIndexPath to the left
      case (indexPath.section, indexPath.row - 1):
        touchingIndexPaths.append(indexPath_)
        // NSIndexPath below
      case (indexPath.section + 1, indexPath.row):
        touchingIndexPaths.append(indexPath_)
        // NSIndexPath to the right
      case (indexPath.section, indexPath.row + 1):
        touchingIndexPaths.append(indexPath_)
      default:
        continue
      }
    }
    
    return touchingIndexPaths
  }
  
  func swap(indexPath firstIndexPath: NSIndexPath, withIndexPath secondIndexPath: NSIndexPath, completionHandler: ((swapped: Bool) -> Void)? = nil) -> Bool {
    guard firstIndexPath.adjacent(toIndexPath: secondIndexPath, inCollectionView: self) else { return false }
    self.performBatchUpdates( {
      self.moveItemAtIndexPath(firstIndexPath, toIndexPath: secondIndexPath)
      self.moveItemAtIndexPath(secondIndexPath, toIndexPath: firstIndexPath)
    }, completion: completionHandler)
    
    return true
  }
}