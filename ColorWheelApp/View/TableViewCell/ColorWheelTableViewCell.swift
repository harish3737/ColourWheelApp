//
//  ColorWheelTableViewCell.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import UIKit

class ColorWheelTableViewCell: UITableViewCell {
    
    static let identifier = "ColorWheelTableViewCell"
    
    var colorWheelView: ColorWheelView = {
        let view = ColorWheelView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupColorWheelView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupColorWheelView() {
        contentView.addSubview(colorWheelView)
        contentView.backgroundColor = .black
        colorWheelView.backgroundColor = .black
        NSLayoutConstraint.activate([
            colorWheelView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            colorWheelView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            colorWheelView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            colorWheelView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            colorWheelView.heightAnchor.constraint(equalTo: colorWheelView.widthAnchor)  // Maintain a square aspect ratio
        ])
    }
    
    func configure(with viewModel: ColorViewModel, selectedIndex: Int) {
        colorWheelView.viewModel = viewModel
        colorWheelView.selectedIndex = selectedIndex
        colorWheelView.setNeedsDisplay()
    }
}
