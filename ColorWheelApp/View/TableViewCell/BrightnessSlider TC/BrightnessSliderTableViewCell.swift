//
//  BrightnessSliderTableViewCell.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import UIKit

class BrightnessSliderTableViewCell: UITableViewCell {
    @IBOutlet weak var brightnessSlider: UISlider!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var percentageLabel: UILabel!

    static let identifier = "BrightnessSliderTableViewCell"
       var viewModel: ColorViewModel?
       var selectedIndex: Int = 0

       override func awakeFromNib() {
           super.awakeFromNib()
           brightnessSlider.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
           self.designChanges()
       }

       @objc private func sliderValueChanged(_ sender: UISlider) {
           let brightnessValue = sender.value / 100.0
                  updatePercentageLabel(value: sender.value)
                  
                  // Notify the view controller that the brightness has changed
                  NotificationCenter.default.post(name: .didUpdateBrightness, object: nil, userInfo: ["brightness": brightnessValue])
       }
    
    private func designChanges(){
        titleLabel.text = "Brightness"
        brightnessSlider.minimumValue = 0
        brightnessSlider.maximumValue = 100
        brightnessSlider.value = 50
        brightnessSlider.minimumTrackTintColor = UIColor(white: 1.0, alpha: 0.8)
        brightnessSlider.maximumTrackTintColor = UIColor(white: 0.4, alpha: 0.5)
        brightnessSlider.thumbTintColor = .white
    }

    func configureSlider(for index: Int, with viewModel: ColorViewModel) {
            self.viewModel = viewModel
            self.selectedIndex = index
            let brightness = Float(viewModel.brightness(at: index))
            brightnessSlider.value = brightness * 100
            updatePercentageLabel(value: brightnessSlider.value)
        }
    private func updatePercentageLabel(value: Float) {
            let percentage = Int(value)
            percentageLabel.text = "\(percentage)%"
        }
   }
