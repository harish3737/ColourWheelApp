//
//  SegmentedControlTableViewCell.swift
//  ColorWheelApp
//
//  Created by Sethuram Vijayakumar on 2024-08-17.
//

import UIKit

class SegmentedControlCollectionViewCell: UITableViewCell {

    static let identifier = "SegmentedControlCollectionViewCell"
    
    @IBOutlet weak var collectionView: UICollectionView!  // Connect via storyboard
    
    var colors: [UIColor] = []
    var selectedIndex: Int = 0
    
    override func awakeFromNib() {
          super.awakeFromNib()
          collectionView.delegate = self
          collectionView.dataSource = self
          
          // Register the cell
          collectionView.register(SegmentCollectionViewCell.self, forCellWithReuseIdentifier: SegmentCollectionViewCell.identifier)
          
          // Set the collection view layout
          let layout = UICollectionViewFlowLayout()
          layout.scrollDirection = .horizontal
          layout.minimumLineSpacing = 16  // Adjust spacing between items
          layout.minimumInteritemSpacing = 0  // Set to 0 to avoid extra spacing
          collectionView.collectionViewLayout = layout
          collectionView.backgroundColor = .black // Set the background color to black
      }
      
      func configure(with colors: [UIColor], selectedIndex: Int) {
          self.colors = colors
          self.selectedIndex = selectedIndex
          collectionView.reloadData()
          
          let indexPath = IndexPath(item: selectedIndex, section: 0)
          collectionView.selectItem(at: indexPath, animated: false, scrollPosition: [])
      }
  }

  extension SegmentedControlCollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
      
      func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
          return colors.count
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SegmentCollectionViewCell.identifier, for: indexPath) as! SegmentCollectionViewCell
          let color = colors[indexPath.item]
          let isSelected = indexPath.item == selectedIndex
          cell.configure(with: color, isSelected: isSelected)
          
          return cell
      }
      
      func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
          selectedIndex = indexPath.item
          collectionView.reloadData()  // Update UI for all cells
          NotificationCenter.default.post(name: .didSelectSegment, object: nil, userInfo: ["index": indexPath.item])
      }
      
      func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
          guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
              return CGSize(width: 0, height: 0) // Fallback to avoid crash
          }

          let availableWidth = collectionView.frame.width - (layout.minimumLineSpacing * CGFloat(colors.count - 1))
          let itemWidth = availableWidth / CGFloat(colors.count)
          return CGSize(width: itemWidth, height: itemWidth) // Ensure square cells
      }
  }
