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
    return UIColor(
      hue: .random(in: 0...1),
      saturation: .random(in: 0.5...1), // from 0.5 to 1.0 to stay away from white
      brightness: .random(in: 0.5...1), // from 0.5 to 1.0 to stay away from black
      alpha: 1.0
    )
  }
}
