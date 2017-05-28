//
//  IndexPath+Extension.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension IndexPath {
  
  func isAdjacent(to indexPath: IndexPath, in collectionView: UICollectionView) -> Bool {
    return !collectionView.adjacentIndexPaths(for: self).filter { $0 == indexPath }.isEmpty
  }
}
