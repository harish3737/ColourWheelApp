//
//  ColorModel.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import Foundation
import UIKit

struct ColorModel {
    var hue: CGFloat
    var saturation: CGFloat
    var brightness: CGFloat

    var color: UIColor {
        return UIColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    }
    
    mutating func updateBrightness(to newBrightness: CGFloat) {
           brightness = newBrightness
       }
}
