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
    return .Sectioned
  }
  
  var topShelfItems: [TVContentItem] {
    guard let
      featuredPuzzlesID = TVContentIdentifier(identifier: "top-shelf-wrapper", container: nil),
      featuredPuzzlesItem = TVContentItem(contentIdentifier: featuredPuzzlesID) else { return [] }
    var _topShelfItems: [TVContentItem] = []
    
    let featuredPuzzles = [
      Puzzle(type: .MountainRange, difficulty: .Easy),
      Puzzle(type: .Classic, difficulty: .Normal),
      Puzzle(type: .ElCapitan, difficulty: .Hard)
    ]
    
    for (index, puzzle) in featuredPuzzles.enumerate() {
      let puzzleName = puzzle.puzzleType.rawValue
      guard let
        contentIdentifier = TVContentIdentifier(identifier: "top-shelf-\(index)", container: featuredPuzzlesID),
        contentItem = TVContentItem(contentIdentifier: contentIdentifier),
        imageURL = NSURL(string: "\(Constant.Web.baseURL)\(puzzleName.lowercaseString)\(Constant.Image.Extension.jpg)") else { continue }
      
      contentItem.imageURL = imageURL
      contentItem.imageShape = .Square
      contentItem.title = "[\(puzzle.difficulty)] \(puzzleName.splittedStringAtCapital)"
      
      let contentURL = NSURL(string: "\(Constant.Application.baseURL)puzzle/\(puzzleName)/\(puzzle.difficulty.rawValue)")
      contentItem.displayURL = contentURL
      contentItem.playURL = contentURL
      
      _topShelfItems.append(contentItem)
    }
    
    featuredPuzzlesItem.title = "Featured Puzzles"
    featuredPuzzlesItem.topShelfItems = _topShelfItems
    
    return [featuredPuzzlesItem]
  }
}