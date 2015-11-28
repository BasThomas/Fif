//
//  TouchButtonDelegate.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

@objc protocol TouchButtonDelegate: class {
  func pressBegan(sender: AnyObject)
  func pressEnded(sender: AnyObject)
  func pressCancelled(sender: AnyObject)
}