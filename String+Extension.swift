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
    
    for index in 0..<self.characters.count {
      let character = ns.substringWithRange(NSRange(location: index, length: 1)) as NSString
      
      if character.rangeOfCharacterFromSet(.uppercaseLetterCharacterSet()).location != NSNotFound && index != 0 {
        capitalized += " "
      }
      
      capitalized += character as String
    }
    
    return capitalized as String
  }
}