//
//  TouchButton.swift
//  Fif
//
//  Created by Bas Broek on 28/11/15.
//  Copyright © 2015 Bas Broek. All rights reserved.
//

import UIKit

class TouchButton: UIButton {
  
  @IBOutlet weak var delegate: TouchButtonDelegate?
  
  override func pressesBegan(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
    super.pressesBegan(presses, withEvent: event)
    guard let presses = event?.allPresses().filter({ $0.type == .Select }) where presses.count == 1 else { return }
    delegate?.pressBegan(self)
  }
  
  override func pressesEnded(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
    super.pressesEnded(presses, withEvent: event)
    guard let presses = event?.allPresses().filter({ $0.type == .Select }) where presses.count == 1 else { return }
    delegate?.pressEnded(self)
  }
  
  override func pressesCancelled(presses: Set<UIPress>, withEvent event: UIPressesEvent?) {
    super.pressesCancelled(presses, withEvent: event)
    guard let presses = event?.allPresses().filter({ $0.type == .Select }) where presses.count == 1 else { return }
    delegate?.pressCancelled(self)
  }
}