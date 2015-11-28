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
    let nsSelf = self as NSString
    var capitalized = ""
    
    for i in 0..<self.characters.count {
      let char = nsSelf.substringWithRange(NSRange(location: i, length: 1)) as NSString
      
      if char.rangeOfCharacterFromSet(NSCharacterSet.uppercaseLetterCharacterSet()).location != NSNotFound && i != 0 {
        capitalized += " "
      }
      
      capitalized += char as String
    }
    
    return capitalized as String
  }
}