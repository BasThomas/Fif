//
//  UIColor+Extension.swift
//  Fif
//
//  Created by Bas Broek on 29/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension UIColor {
  
  static var random: UIColor {
    let hue = CGFloat(arc4random() % 256) / 256 // use 256 to get full range from 0.0 to 1.0
    let saturation = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from white
    let brightness = CGFloat(arc4random() % 128) / 256 + 0.5 // from 0.5 to 1.0 to stay away from black
    
    return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
  }
}
