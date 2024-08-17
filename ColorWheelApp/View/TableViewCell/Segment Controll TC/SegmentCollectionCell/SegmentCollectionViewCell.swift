import UIKit

class SegmentCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SegmentCollectionViewCell"
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black // Set background to black
        view.layer.cornerRadius = 8 // Adjust for rounded corners
        view.layer.masksToBounds = true
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 2.0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let circleView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 15 // Adjust based on size
        view.layer.masksToBounds = true
        return view
    }()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.blue.withAlphaComponent(0.5) // Blue overlay for selection
        view.layer.cornerRadius = 8 // Match the containerView's corner radius
        view.layer.masksToBounds = true
        view.isHidden = true // Hidden by default
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(containerView)
        containerView.addSubview(circleView)
        contentView.addSubview(overlayView)
        
        NSLayoutConstraint.activate([
            // Set up the container view to fill the cell with some padding
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            // Center the circle view within the container view
            circleView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            circleView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            circleView.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 0.6),
            circleView.heightAnchor.constraint(equalTo: circleView.widthAnchor),
            
            // Overlay view covers the entire container
            overlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with color: UIColor, isSelected: Bool) {
        // Set the circle color
        circleView.backgroundColor = color
        
        // Show overlay when selected
        overlayView.isHidden = !isSelected
        
        // Highlight the containerView when selected
        containerView.layer.borderColor = isSelected ? UIColor.blue.cgColor : UIColor.gray.cgColor
        containerView.layer.borderWidth = isSelected ? 4.0 : 2.0 // Thicker border when selected
    }
}
