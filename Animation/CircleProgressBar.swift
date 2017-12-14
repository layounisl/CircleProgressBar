//
//  CircleProgressBar.swift
//  Animation
//
//  Created by Slah Layouni on 12/13/17.
//  Copyright © 2017 Layouni. All rights reserved.
//

import UIKit

class CircleProgressBar:UIView{
    
    
    
    open var progress : Int = 0 {
        didSet {
            DispatchQueue.main.async {
                self.percentageLabel.text = "\(self.progress)%"
                self.shapeLayer?.strokeEnd = CGFloat(self.progress)/100
            }
        }
    }
    
    open var trackerColor : UIColor = UIColor.trackStrokeColor {
        didSet {
            trackLayer?.strokeColor = trackerColor.cgColor
        }
    }
    
    open var progressColor : UIColor = UIColor.outlineStrokeColor {
        didSet {
            shapeLayer?.strokeColor = progressColor.cgColor
        }
    }

    open var pulsingColor : UIColor = UIColor.pulsatingFillColor {
        didSet {
            pulsatingLayer?.strokeColor = pulsingColor.cgColor
        }
    }
    
    open var circleBackgroundColor : UIColor = UIColor.clear {
        didSet {
            shapeLayer?.fillColor = circleBackgroundColor.cgColor
        }
    }
    
    open var progressThickness: CGFloat = 10 {
        didSet {
            shapeLayer?.lineWidth = progressThickness
            trackLayer?.lineWidth = progressThickness
        }
    }
    
    
    private func createLayer() -> CAShapeLayer
    {
        let circularPath = UIBezierPath(arcCenter: .zero, radius: self.frame.width, startAngle: 0, endAngle: 2 * CGFloat.pi, clockwise: self.clockWise)
        let shape = CAShapeLayer()
        shape.path = circularPath.cgPath
        shape.strokeColor = UIColor.red.cgColor
        shape.lineWidth = 20
        shape.fillColor = UIColor.clear.cgColor
        shape.lineCap = kCALineCapRound
        shape.position = center
        return shape
    }
    
    private func prepareLayers(){
        shapeLayer = createLayer()
        shapeLayer?.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        shapeLayer?.strokeEnd = 0
        trackLayer = createLayer()
        pulsatingLayer = createLayer()
        shapeLayer?.strokeColor = progressColor.cgColor
        pulsatingLayer?.strokeColor = pulsingColor.cgColor
        trackLayer?.strokeColor = trackerColor.cgColor
        self.layer.addSublayer(pulsatingLayer!)
        self.layer.addSublayer(trackLayer!)
        self.layer.addSublayer(shapeLayer!)
        animatePulsatingLayer()
    }
    
    private var shapeLayer:CAShapeLayer?
    private var trackLayer:CAShapeLayer?
    private var pulsatingLayer:CAShapeLayer?
    
    
    open lazy var percentageLabel:UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 32)
        label.textAlignment = .center
        label.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: 100)
        label.center = self.center
        label.text = "0%"
        return label
    }()
    
    var clockWise:Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.prepareLayers()
        self.addSubview(percentageLabel)
    }
    
    init(frame: CGRect,clockWise: Bool) {
        super.init(frame: frame)
        self.clockWise = clockWise
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func animatePulsatingLayer() {
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.toValue = 1.1
        animation.duration = 0.8
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.autoreverses = true
        animation.repeatCount = Float.infinity
        pulsatingLayer?.add(animation, forKey: "pulsing")
    }
    
    
}
extension UIColor {
    static func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
    }
    static let backgroundColor = UIColor.rgb(r: 21, g: 22, b: 33)
    static let outlineStrokeColor = UIColor.rgb(r: 234, g: 46, b: 111)
    static let trackStrokeColor = UIColor.rgb(r: 56, g: 25, b: 49)
    static let pulsatingFillColor = UIColor.rgb(r: 86, g: 30, b: 63)
}

