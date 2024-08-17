//
//  NameNotification.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//


import Foundation

extension NSNotification.Name {
    static let didSelectSegment = NSNotification.Name("didSelectSegment")
    static let didUpdateBrightness = NSNotification.Name("didUpdateBrightness")
    static let colorWheelDidSelectColor = Notification.Name("colorWheelDidSelectColor")
}
