//
//  ColorWheelView.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import UIKit

class ColorWheelView: UIView {
    var viewModel: ColorViewModel?
    var selectedIndex: Int = 0
    private var handleLayer = CAShapeLayer()
    private var colorWheelImage: UIImage?

    // Cache the color wheel image
    override func draw(_ rect: CGRect) {
        if colorWheelImage == nil {
            colorWheelImage = generateColorWheelImage(size: bounds.size)
        }
        colorWheelImage?.draw(in: rect)
        drawHandle(at: handlePosition(for: viewModel?.color(at: selectedIndex) ?? .white))
    }

    // Precompute the color wheel image for better performance
    private func generateColorWheelImage(size: CGSize) -> UIImage? {
        let radius = min(size.width, size.height) / 2
        let center = CGPoint(x: size.width / 2, y: size.height / 2)
        let renderer = UIGraphicsImageRenderer(size: size)

        return renderer.image { context in
            for y in 0..<Int(size.height) {
                for x in 0..<Int(size.width) {
                    let angle = atan2(CGFloat(y) - center.y, CGFloat(x) - center.x)
                    let hue = (angle < 0 ? angle + 2 * .pi : angle) / (2 * .pi)
                    let dist = hypot(CGFloat(x) - center.x, CGFloat(y) - center.y)
                    let saturation = dist / radius
                    if saturation <= 1.0 {
                        let color = UIColor(hue: hue, saturation: saturation, brightness: 1.0, alpha: 1.0)
                        context.cgContext.setFillColor(color.cgColor)
                        context.cgContext.fill(CGRect(x: x, y: y, width: 1, height: 1))
                    }
                }
            }
        }
    }

    // Handle touch began
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }

    // Handle touch moved to support dragging
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }

    // Handle the touch event and update the color
    private func handleTouch(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            guard bounds.contains(location) else { return }
            let selectedColor = getColor(at: location)
            viewModel?.updateColor(selectedColor, at: selectedIndex)
            setNeedsDisplay()
        }
    }

    // Get the color at the specified point
    private func getColor(at point: CGPoint) -> UIColor {
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let dx = point.x - center.x
        let dy = point.y - center.y
        let distance = hypot(dx, dy)
        let radius = min(bounds.width, bounds.height) / 2
        let saturation = min(distance / radius, 1.0)

        let angle = atan2(dy, dx)
        let hue = (angle < 0 ? angle + 2 * .pi : angle) / (2 * .pi)

        if distance <= radius {
            return UIColor(hue: hue, saturation: saturation, brightness: viewModel?.brightness(at: selectedIndex) ?? 1.0, alpha: 1.0)
        } else {
            return UIColor.white
        }
    }

    // Calculate the handle position based on the selected color
    private func handlePosition(for color: UIColor) -> CGPoint {
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0

        color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

        let angle = hue * 2 * .pi
        let radius = saturation * min(bounds.width, bounds.height) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        return CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
    }

    // Draw the handle at the calculated position
    private func drawHandle(at position: CGPoint) {
        handleLayer.removeFromSuperlayer()

        let handlePath = UIBezierPath(arcCenter: position, radius: 12, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        handleLayer.path = handlePath.cgPath
        handleLayer.fillColor = viewModel?.color(at: selectedIndex).cgColor ?? UIColor.white.cgColor
        handleLayer.shadowColor = UIColor.black.cgColor
        handleLayer.shadowOffset = CGSize(width: 1, height: 1)
        handleLayer.shadowOpacity = 0.3
        handleLayer.shadowRadius = 3
        layer.addSublayer(handleLayer)
    }
}
