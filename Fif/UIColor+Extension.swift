//
//  UIColor+Extension.swift
//  Fif
//
//  Created by Bas Broek on 22/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension UIColor {
  
  static func randomColor() -> UIColor {
    let h = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let s = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let b = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
    
    return UIColor(hue: h, saturation: s, brightness: b, alpha: 1.0)
  }
}