//
//  NameNotification.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//


import Foundation
import UIKit

extension NSNotification.Name {
    static let didSelectSegment = NSNotification.Name("didSelectSegment")
    static let didUpdateBrightness = NSNotification.Name("didUpdateBrightness")
    static let colorWheelDidSelectColor = Notification.Name("colorWheelDidSelectColor")
}


protocol ColorViewModelDelegate: AnyObject {
    func didUpdateColor(at index: Int, with color: UIColor)
    func didUpdateBrightness(at index: Int, with brightness: CGFloat)
    func didSelectSegment(at index: Int)
}

protocol SegmentedControlCollectionViewCellDelegate: AnyObject {
    func didSelectSegmentCollection(at index: Int)
}

protocol BrightnessSliderTableViewCellDelegate: AnyObject {
    func didUpdateBrightness(to brightness: CGFloat, for index: Int)
}
