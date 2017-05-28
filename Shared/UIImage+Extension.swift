//
//  UIImage+Extension.swift
//  Fif
//
//  Created by Bas Broek on 27/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

extension UIImage {
  
  func crop(to rect: CGRect) -> UIImage? {
    guard
      let cgImage = cgImage,
      let imageRef = cgImage.cropping(to: rect) else { return nil }
    let cropped = UIImage(cgImage: imageRef)
    return cropped
  }
  
  convenience init?(puzzle: Puzzle) {
    #if os(iOS)
      self.init(named: "iOS-\(puzzle.puzzleType.rawValue)")
    #else
      self.init(named: "tvOS-\(puzzle.puzzleType.rawValue)")
    #endif
  }
  
  func scale(to size: CGSize) -> UIImage {
    let hasAlpha = false
    let scale: CGFloat = 0.0 // Automatically use scale factor of main screen
    
    UIGraphicsBeginImageContextWithOptions(size, !hasAlpha, scale)
    self.draw(in: CGRect(origin: .zero, size: size))
    
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    
    return scaledImage ?? UIImage()
  }
}
