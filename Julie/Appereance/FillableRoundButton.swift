//
//  FillableRoundButton.swift
//  Julie
//
//  Created by Ivan Blagajić on 08/06/16.
//  Copyright © 2016 Five Dollar Milkshake. All rights reserved.
//

import UIKit

class FillableRoundButton: UIButton {
    
    private var fillCircle: CAShapeLayer?
    
    private let borderWidth: CGFloat = 3.0
    
    override var tintColor: UIColor! {
        didSet {
            fillCircle?.strokeColor = tintColor.CGColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.masksToBounds = true
        drawCircle(.standardBackground(), strokeEnd: 1.0)
        fillCircle = drawCircle(.action(), strokeEnd: 0.0)
    }
    
    private func drawBackgroundCircle() {
        let backgroundCircle = CAShapeLayer()
        backgroundCircle.path = circlePath().CGPath
        backgroundCircle.fillColor = UIColor.standardBackground().CGColor
        backgroundCircle.strokeColor = UIColor.standardBackground().CGColor
        backgroundCircle.lineWidth = 3.0
        
        layer.addSublayer(backgroundCircle)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = frame.size.width/2
        fillCircle?.frame = bounds
        fillCircle?.path = circlePath().CGPath
    }
    
    private func drawCircle(color: UIColor, strokeEnd: CGFloat) -> CAShapeLayer {
        let circle = CAShapeLayer()
        circle.path = circlePath().CGPath
        circle.strokeColor = color.CGColor
        circle.fillColor = UIColor.clearColor().CGColor
        circle.lineWidth = borderWidth
        circle.strokeEnd = strokeEnd
        layer.addSublayer(circle)
        return circle
    }
    
    private func circlePath() -> UIBezierPath {
        let radius = frame.width/2
        return UIBezierPath(arcCenter: CGPoint(x: radius, y: radius),
                            radius: radius - 1,
                            startAngle: CGFloat(-M_PI/2),
                            endAngle:CGFloat(M_PI * 2 - M_PI/2),
                            clockwise: true)
    }
    
    func rx_progress(progress: CGFloat) {
        if progress < 0 || progress > 1 {
            print("Warning: progress should be between 0 and 1. (progress: \(progress))")
        }
        let oldProgress = fillCircle?.strokeEnd
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.duration = 1.0
        animation.fromValue = oldProgress
        fillCircle?.strokeEnd = progress
        animation.removedOnCompletion = true
        fillCircle?.addAnimation(animation, forKey: nil)
    }
    
}
