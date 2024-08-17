//
//  ColorViewModel.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import Foundation
import UIKit


class ColorViewModel {
    var colors: [ColorModel] = [
        ColorModel(hue: 0.48, saturation: 0.78, brightness: 1.0),
        ColorModel(hue: 0.33, saturation: 0.67, brightness: 0.65),
        ColorModel(hue: 0.08, saturation: 1.0, brightness: 1.0)
    ]

    var selectedSegmentIndex: Int = 0 // Tracks the selected segment index



    func color(at index: Int) -> UIColor {
        return colors[index].color
    }

    func brightness(at index: Int) -> CGFloat {
        return colors[index].brightness
    }


}

