//
//  ColorSwatchView.swift
//  ColorWheel
//
//  Created by Ben Gohlke on 2/6/19.
//  Copyright © 2019 Ben Gohlke. All rights reserved.
//

import UIKit

class ColorSwatchView: UIView
{
    private var color: UIColor
    private let swatchSize: CGFloat = 60
    private let border: CGFloat = 4
    private var swatchPath: UIBezierPath?
    private let bgColor = UIColor(hue: 0, saturation: 0, brightness: 35/100, alpha: 1.0)
    
    init(as color: UIColor, anchor: CGPoint)
    {
        self.color = color
        let width = swatchSize + border * 2
        let height = swatchSize + (border * 2) + (swatchSize / 2)
        let x = anchor.x - width / 2
        let y = anchor.y - height
        super.init(frame: CGRect(x: x, y: y, width: width, height: height))
        backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        // Triangle
        let trianglePath = UIBezierPath()
        let triangleStartY: CGFloat = swatchSize + border * 1.5
        let triangleStartX: CGFloat = 0
        
        trianglePath.move(to: CGPoint(x: triangleStartX, y: triangleStartY))
        trianglePath.addLine(to: CGPoint(x: rect.width , y: triangleStartY))
        trianglePath.addLine(to: CGPoint(x: rect.width / 2, y: rect.height))
        trianglePath.addLine(to: CGPoint(x: triangleStartX, y: triangleStartY))
        trianglePath.close()
        bgColor.setFill()
        trianglePath.fill()
        
        // Border behind swatch
        let squareBgPath = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: rect.width, height: swatchSize + border * 2), cornerRadius: 4)
        bgColor.setFill()
        squareBgPath.fill()
        
        // Swatch
        swatchPath = UIBezierPath(rect: CGRect(x: border, y: border, width: swatchSize, height: swatchSize))
        color.setFill()
        swatchPath?.fill()
    }
    
    
    func update(position anchor: CGPoint, color: UIColor)
    {
        let x = anchor.x - frame.size.width / 2
        let y = anchor.y - frame.size.height
        let width = frame.size.width
        let height = frame.size.height
        
        self.frame = CGRect(x: x, y: y, width: width, height: height)
        self.color = color
        self.setNeedsDisplay()
    }
}
