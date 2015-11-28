//
//  Hintable.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import Foundation

protocol Hintable {
  func showHint(sender: AnyObject)
  func hideHint(sender: AnyObject)
}