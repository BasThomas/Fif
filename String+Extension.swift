//
//  String+Extension.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

extension String {
  
  var splittedStringAtCapital: String {
    let ns = self as NSString
    var capitalized = ""
    
    for index in 0..<self.count {
      let character = ns.substring(with: NSRange(location: index, length: 1)) as NSString
      
      if character.rangeOfCharacter(from: .uppercaseLetters).location != NSNotFound && index != 0 {
        capitalized += " "
      }
      
      capitalized += character as String
    }
    
    return capitalized as String
  }
  
  var localized: String {
    return NSLocalizedString(self, comment: "")
  }
}
