//
//  UIImage+Extension.swift
//  Fif
//
//  Created by Bas Broek on 27/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension UIImage {
  
  func crop(toRect rect: CGRect) -> UIImage? {
    guard let imageRef = CGImageCreateWithImageInRect(self.CGImage, rect) else { return nil }
    let cropped = UIImage(CGImage: imageRef)
    return cropped
  }
}