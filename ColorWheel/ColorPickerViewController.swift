//
//  ViewController.swift
//  ColorWheel
//
//  Created by Ben Gohlke on 2/5/19.
//  Copyright © 2019 Ben Gohlke. All rights reserved.
//

import UIKit
import CoreImage

class ColorPickerViewController: UIViewController
{
    // MARK: - Outlets
    @IBOutlet weak private var colorPV: ColorPickerView!
    
    @IBOutlet weak private var rgbRedValue: UILabel!
    @IBOutlet weak private var rgbBlueValue: UILabel!
    @IBOutlet weak private var rgbGreenValue: UILabel!
    
    @IBOutlet weak private var hsbHueValue: UILabel!
    @IBOutlet weak private var hsbSatValue: UILabel!
    @IBOutlet weak private var hsbBrightValue: UILabel!
    
    // MARK: - Private Properties
    private var colorSwatchView: ColorSwatchView?
    
    // MARK: - View Lifecycle
    
    override func viewDidLayoutSubviews()
    {
        
    }
    
    // MARK: - Action Handlers
    
    @IBAction func userDidTapColorWheel(sender: UITapGestureRecognizer)
    {
        if sender.state == .ended
        {
            updateSwatchAndInfo(using: sender.location(in: colorPV))
        }
    }
    
    @IBAction func userDidPanColorWheel(sender: UIPanGestureRecognizer)
    {
        if sender.state == .changed
        {
            updateSwatchAndInfo(using: sender.location(in: colorPV))
        }
    }
    
    // MARK: - Private Helpers
    
    private func updateSwatchAndInfo(using location: CGPoint)
    {
        let selectedColor = colorPV.getPixelColorAt(point: location)
        
        if let colorView = colorSwatchView {
            colorView.update(position: location, color: selectedColor)
        } else {
            let view = ColorSwatchView(as: selectedColor, anchor: CGPoint(x: location.x, y: location.y))
            colorPV.addSubview(view)
            colorSwatchView = view
        }
        
        var hue: CGFloat = 0
        var sat: CGFloat = 0
        var bright: CGFloat = 0
        var alpha: CGFloat = 0
        
        if selectedColor.getHue(&hue, saturation: &sat, brightness: &bright, alpha: &alpha)
        {
            print("hue: \(hue), sat: \(sat), bright: \(bright)")
            hsbHueValue.text = "\(Int((hue * 360).rounded()))°"
            hsbSatValue.text = "\(Int((sat * 100).rounded()))%"
            hsbBrightValue.text = "\(Int((bright * 100).rounded()))%"
        }
        
        var red: CGFloat = 0
        var blue: CGFloat = 0
        var green: CGFloat = 0
        
        if selectedColor.getRed(&red, green: &blue, blue: &green, alpha: &alpha) {
            print("red: \(red), green: \(green), blue: \(blue)")
            rgbRedValue.text = "\(Int((red * 255).rounded()))"
            rgbBlueValue.text = "\(Int((blue * 255).rounded()))"
            rgbGreenValue.text = "\(Int((green * 255).rounded()))"
        }
        
    }
}
