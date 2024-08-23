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

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let radius = min(bounds.size.width, bounds.size.height) / 2
        let center = CGPoint(x: bounds.midX, y: bounds.midY)

        for y in 0..<Int(bounds.size.height) {
            for x in 0..<Int(bounds.size.width) {
                let angle = atan2(CGFloat(y) - center.y, CGFloat(x) - center.x)
                let hue = (angle < 0 ? angle + 2 * .pi : angle) / (2 * .pi)
                let dist = hypot(CGFloat(x) - center.x, CGFloat(y) - center.y)
                let saturation = dist / radius
                if saturation <= 1.0 {
                    let color = UIColor(hue: hue, saturation: saturation, brightness: viewModel?.brightness(at: selectedIndex) ?? 1.0, alpha: 1.0)
                    context?.setFillColor(color.cgColor)
                    context?.fill(CGRect(x: x, y: y, width: 1, height: 1))
                }
            }
        }

        drawHandle(at: handlePosition(for: viewModel?.color(at: selectedIndex) ?? .white))
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        handleTouch(touches)
    }

    private func handleTouch(_ touches: Set<UITouch>) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            let color = getColor(at: location)
            viewModel?.updateColor(color, at: selectedIndex)
//            NotificationCenter.default.post(name: .colorWheelDidSelectColor, object: nil, userInfo: ["color": color])
            setNeedsDisplay()
        }
    }

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

    private func drawHandle(at position: CGPoint) {
        handleLayer.removeFromSuperlayer()

        let handlePath = UIBezierPath(arcCenter: position, radius: 12, startAngle: 0, endAngle: CGFloat(2 * Double.pi), clockwise: true)
        handleLayer.path = handlePath.cgPath
        handleLayer.fillColor = UIColor.white.cgColor
        handleLayer.shadowColor = UIColor.black.cgColor
        handleLayer.shadowOffset = CGSize(width: 1, height: 1)
        handleLayer.shadowOpacity = 0.3
        handleLayer.shadowRadius = 3
        layer.addSublayer(handleLayer)
    }
}
