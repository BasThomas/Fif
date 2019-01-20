//
//  UICollectionView+Extension.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension UICollectionView {
  
  func adjacentIndexPaths(for indexPath: IndexPath) -> [IndexPath] {
    let indexPaths = visibleCells.compactMap { self.indexPath(for: $0) }
    var touchingIndexPaths: [IndexPath] = []
    
    for indexPath_ in indexPaths {
      guard indexPath_ != indexPath else { continue }
      let _indexPath = (section: indexPath_.section, row: indexPath_.row)
      switch _indexPath {
        // IndexPath above
      case (indexPath.section - 1, indexPath.row):
        touchingIndexPaths.append(indexPath_)
        // IndexPath to the left
      case (indexPath.section, indexPath.row - 1):
        touchingIndexPaths.append(indexPath_)
        // IndexPath below
      case (indexPath.section + 1, indexPath.row):
        touchingIndexPaths.append(indexPath_)
        // IndexPath to the right
      case (indexPath.section, indexPath.row + 1):
        touchingIndexPaths.append(indexPath_)
      default:
        continue
      }
    }
    
    return touchingIndexPaths
  }
  
  func swap(_ firstIndexPath: IndexPath, with secondIndexPath: IndexPath, completionHandler: ((Bool) -> Void)? = nil) -> Bool {
    guard firstIndexPath.isAdjacent(to: secondIndexPath, in: self) else { return false }
    performBatchUpdates({ [weak self] in
      guard let `self` = self else { return }
      self.moveItem(at: firstIndexPath, to: secondIndexPath)
      self.moveItem(at: secondIndexPath, to: firstIndexPath)
    }, completion: completionHandler)
    
    return true
  }
}
