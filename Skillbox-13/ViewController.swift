//
//  ViewController.swift
//  Skillbox-13
//
//  Created by Антон Тимоненков on 28.06.2020.
//  Copyright © 2020 Антон Тимоненков. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var animationNumber = 0
  var a = UIColor(), b = CGAffineTransform(), c = CGFloat(), d = CGFloat()
  var isAnimating = false
  
  @IBOutlet weak var squareView: UIView!
  @IBOutlet weak var animationNumberLabel: UILabel!
  @IBOutlet weak var rightConst: NSLayoutConstraint!
  @IBOutlet weak var topConst: NSLayoutConstraint!
  @IBOutlet weak var nextButton: UIButton!
  @IBOutlet weak var prevButton: UIButton!

  @IBAction func prevAnimation(_ sender: Any) {
    counter(false)
  }
  @IBAction func nextAnimation(_ sender: Any) {
    counter(true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    a = squareView.backgroundColor!
    b = squareView.transform
    c = squareView.layer.cornerRadius
    d = squareView.alpha
  }
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    isAnimating ? squareView.layer.removeAllAnimations() : _animate(animationNumber)
  }
  
  func counter(_ direction: Bool){
    if direction {
      if animationNumber + 1 == 8 { animationNumber = 1 } else { animationNumber += 1 }
      animationNumberLabel.text = "\(animationNumber)"
    }else{
      if animationNumber - 1 == 0 { animationNumber = 7 } else { animationNumber -= 1 }
      animationNumberLabel.text = "\(animationNumber)"
    }
  }
  func _animate(_ animationNumber: Int){
    self.isAnimating = true
    var options = UIView.AnimationOptions()
    if animationNumber == 6 {
      self.squareView.transform = CGAffineTransform(scaleX: 2, y: 2)
    }
    if animationNumber == 7 {
      options = [.repeat, .curveLinear]
    }
    UIView.animate(withDuration: 2, delay: 0, options: options, animations: {
      switch animationNumber {
      case 1: self.squareView.backgroundColor = .systemYellow
      case 2: self.squareView.transform = CGAffineTransform(translationX: self.rightConst.constant, y: -self.topConst.constant)
      case 3: self.squareView.layer.cornerRadius = self.squareView.frame.size.width/2
      case 4: self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
      case 5: self.squareView.alpha = 0
      case 6: self.squareView.transform = CGAffineTransform(scaleX: 1, y: 1)
      case 7: self.squareView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
      default: return
      }
    }) { (isCompleted) in
      self.squareView.backgroundColor = self.a
      self.squareView.transform = self.b
      self.squareView.layer.cornerRadius = self.c
      self.squareView.alpha = self.d
      self.isAnimating = false
    }
  }
}

