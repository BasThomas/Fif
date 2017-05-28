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
  
  override func pressesBegan(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
    super.pressesBegan(presses, with: event)
    guard
      let presses = event?.allPresses.filter({ $0.type == .select }),
      presses.count == 1 else { return }
    delegate?.pressBegan(sender: self)
  }
  
  override func pressesEnded(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
    super.pressesEnded(presses, with: event)
    guard
      let presses = event?.allPresses.filter({ $0.type == .select }),
      presses.count == 1 else { return }
    delegate?.pressEnded(sender: self)
  }
  
  override func pressesCancelled(_ presses: Set<UIPress>, with event: UIPressesEvent?) {
    super.pressesCancelled(presses, with: event)
    guard
      let presses = event?.allPresses.filter({ $0.type == .select }),
      presses.count == 1 else { return }
    delegate?.pressCancelled(sender: self)
  }
}
