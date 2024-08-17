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

    var selectedSegmentIndex: Int = 0 {
        didSet {
            onSegmentChange?()
        }
    }

    // Closures for binding to the view controller
    var onSegmentChange: (() -> Void)?
    var onColorChange: (() -> Void)?
    var onBrightnessChange: (() -> Void)?

    init() {
        setupObservers()
    }

    // Setup NotificationCenter observers in the ViewModel
    private func setupObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectSegment(_:)), name: .didSelectSegment, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didUpdateBrightness(_:)), name: .didUpdateBrightness, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(didSelectColor(_:)), name: .colorWheelDidSelectColor, object: nil)
    }

    @objc private func didSelectSegment(_ notification: Notification) {
        if let index = notification.userInfo?["index"] as? Int {
            selectedSegmentIndex = index
        }
    }

    @objc private func didSelectColor(_ notification: Notification) {
        if let color = notification.userInfo?["color"] as? UIColor {
            var hue: CGFloat = 0
            var saturation: CGFloat = 0
            var brightness: CGFloat = 0
            var alpha: CGFloat = 0
            color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

            colors[selectedSegmentIndex] = ColorModel(hue: hue, saturation: saturation, brightness: brightness)
            onColorChange?() // Notify the view controller of the color change
        }
    }

    @objc private func didUpdateBrightness(_ notification: Notification) {
        if let brightness = notification.userInfo?["brightness"] as? CGFloat {
            colors[selectedSegmentIndex].updateBrightness(to: brightness)
            onBrightnessChange?() // Notify the view controller of the brightness change
        }
    }

    func color(at index: Int) -> UIColor {
        return colors[index].color
    }

    func brightness(at index: Int) -> CGFloat {
        return colors[index].brightness
    }
}


