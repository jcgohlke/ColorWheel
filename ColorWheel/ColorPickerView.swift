//
//  ColorPickerView.swift
//  ColorWheel
//
//  Created by Ben Gohlke on 2/6/19.
//  Copyright © 2019 Ben Gohlke. All rights reserved.
//

import UIKit

class ColorPickerView: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let radius = frame.size.width / 2.0
        let wheelfilter = CIFilter(name: "CIHueSaturationValueGradient", parameters: [
            "inputColorSpace": CGColorSpaceCreateDeviceRGB(),
            "inputDither": 0,
            "inputRadius": radius,
            "inputSoftness": 0,
            "inputValue": 1
            ])!
        self.image = UIImage(ciImage: wheelfilter.outputImage!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let radius = frame.size.width / 2.0
        let wheelfilter = CIFilter(name: "CIHueSaturationValueGradient", parameters: [
            "inputColorSpace": CGColorSpaceCreateDeviceRGB(),
            "inputDither": 0,
            "inputRadius": radius,
            "inputSoftness": 0,
            "inputValue": 1
            ])!
        image = UIImage(ciImage: wheelfilter.outputImage!)
    }
    
}
