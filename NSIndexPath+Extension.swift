//
//  NSIndexPath+Extension.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension NSIndexPath {
  
  func adjacent(toIndexPath indexPath: NSIndexPath, inCollectionView collectionView: UICollectionView) -> Bool {
    return !collectionView.touchingIndexPaths(forIndexPath: self).filter { $0 == indexPath }.isEmpty
  }
}