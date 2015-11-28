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
    return []
  }
}