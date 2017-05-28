//
//  ServiceProvider.swift
//  TopShelf
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation
import TVServices

class ServiceProvider: NSObject {
  
  override init() {
    super.init()
  }
}

// MARK: - TVTopShelfProvider
extension ServiceProvider: TVTopShelfProvider {
  
  var topShelfStyle: TVTopShelfContentStyle {
    return .sectioned
  }
  
  var topShelfItems: [TVContentItem] {
    var topShelfItems: [TVContentItem] = []
    guard
      let featuredPuzzlesID = TVContentIdentifier(identifier: "top-shelf-wrapper", container: nil),
      let featuredPuzzlesItem = TVContentItem(contentIdentifier: featuredPuzzlesID) else { return topShelfItems }
    
    let featuredPuzzles = [
      Puzzle(type: .mountainRange, difficulty: .easy),
      Puzzle(type: .classic, difficulty: .normal),
      Puzzle(type: .elCapitan, difficulty: .hard)
    ]
    
    for (index, puzzle) in featuredPuzzles.enumerated() {
      let puzzleName = puzzle.puzzleType.rawValue
      guard
        let contentIdentifier = TVContentIdentifier(identifier: "top-shelf-\(index)", container: featuredPuzzlesID),
        let contentItem = TVContentItem(contentIdentifier: contentIdentifier),
        let imageURL = URL(string: "\(Constant.Web.baseURL)\(puzzleName.lowercased())\(Constant.Image.Extension.jpg)") else { continue }
      
      contentItem.imageURL = imageURL
      contentItem.imageShape = .square
      contentItem.title = "[\(puzzle.difficulty)] \(puzzleName.splittedStringAtCapital)"
      
      let contentURL = URL(string: "\(Constant.Application.baseURL)puzzle/\(puzzleName)/\(puzzle.difficulty.rawValue)")
      contentItem.displayURL = contentURL
      contentItem.playURL = contentURL
      
      topShelfItems.append(contentItem)
    }
    
    featuredPuzzlesItem.title = "Featured Puzzles".localized
    featuredPuzzlesItem.topShelfItems = topShelfItems
    
    return [featuredPuzzlesItem]
  }
}
