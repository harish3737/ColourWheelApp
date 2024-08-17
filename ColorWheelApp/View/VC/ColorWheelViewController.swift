//
//  ViewController.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import UIKit

class ColorWheelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ColorViewModel()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupTableView()
    }


}



extension ColorWheelViewController {
    
    private func setupTableView() {
        tableView.delegate = self
              tableView.dataSource = self

              // Register the custom cells with XIBs
        tableView.register(UINib(nibName: "SegmentedControlCollectionViewCell", bundle: nil), forCellReuseIdentifier: SegmentedControlCollectionViewCell.identifier)
        tableView.register(UINib(nibName: "BrightnessSliderTableViewCell", bundle: nil), forCellReuseIdentifier: BrightnessSliderTableViewCell.identifier)
        tableView.register(ColorWheelTableViewCell.self, forCellReuseIdentifier: ColorWheelTableViewCell.identifier)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none  // Remove cell separators for a cleaner look
        tableView.backgroundColor = .black  // Match the background color to the color wheel
        
        // Observers for handling segment and brightness changes
                NotificationCenter.default.addObserver(self, selector: #selector(didSelectSegment(_:)), name: .didSelectSegment, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(didUpdateBrightness), name: .didUpdateBrightness, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(didSelectColor(_:)), name: .colorWheelDidSelectColor, object: nil)
            
            
            
    }
    
    @objc private func didSelectSegment(_ notification: Notification) {
           if let index = notification.userInfo?["index"] as? Int {
               viewModel.selectedSegmentIndex = index
               tableView.reloadData() // Reload the table view to update the color wheel and slider
           }
       }
    
    @objc private func didSelectColor(_ notification: Notification) {
            if let color = notification.userInfo?["color"] as? UIColor {
                     var hue: CGFloat = 0
                       var saturation: CGFloat = 0
                       var brightness: CGFloat = 0
                       var alpha: CGFloat = 0
                color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
                      
                viewModel.colors[viewModel.selectedSegmentIndex] =  ColorModel(hue: hue, saturation: saturation, brightness: brightness)
                tableView.reloadData()  // Update the table view with the new color
            }
        }
       
    @objc private func didUpdateBrightness(_ notification: Notification) {
        if let brightness = notification.userInfo?["brightness"] as? CGFloat {
            viewModel.colors[viewModel.selectedSegmentIndex].updateBrightness(to: brightness)
            tableView.reloadData()  // Update the table view to reflect the new brightness
        }
    }
    
    
}


extension ColorWheelViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // Segmented control, color wheel, and brightness slider
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: SegmentedControlCollectionViewCell.identifier, for: indexPath) as! SegmentedControlCollectionViewCell
                cell.configure(with: viewModel.colors.map { $0.color }, selectedIndex: viewModel.selectedSegmentIndex)
            cell.backgroundColor = .clear  // Transparent background to blend with overall design
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: ColorWheelTableViewCell.identifier, for: indexPath) as! ColorWheelTableViewCell
            cell.configure(with: viewModel, selectedIndex: viewModel.selectedSegmentIndex)
                      return cell
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: BrightnessSliderTableViewCell.identifier, for: indexPath) as! BrightnessSliderTableViewCell
            cell.configureSlider(for: viewModel.selectedSegmentIndex, with: viewModel)
            cell.backgroundColor = .clear  // Transparent background
            return cell
        }

        return UITableViewCell()
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let screenHeight = UIScreen.main.bounds.height
        switch indexPath.row {
        case 0:
            return screenHeight * 0.1  // Adjusted for better visual alignment
        case 1:
            return screenHeight * 0.55  // Slightly reduced to fit better
        case 2:
            return screenHeight * 0.15  // Adjusted to reduce white space
        default:
            return UITableView.automaticDimension
        }
    }
}
