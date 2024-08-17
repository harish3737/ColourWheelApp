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

    func updateSelectedColor(at index: Int, with color: UIColor) {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        if color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            colors[index].hue = hue
            colors[index].saturation = saturation
            colors[index].brightness = brightness
        }
    }

    func color(at index: Int) -> UIColor {
        return colors[index].color
    }

    func brightness(at index: Int) -> CGFloat {
        return colors[index].brightness
    }

    func updateBrightness(at index: Int, with brightness: CGFloat) {
        colors[index].brightness = brightness
    }
}

