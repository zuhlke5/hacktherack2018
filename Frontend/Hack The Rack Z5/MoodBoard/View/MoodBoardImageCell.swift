import UIKit

class MoodBoardImageCell: UICollectionViewCell {

    private let imageView = UIImageView()

    override func layoutSubviews() {
        if self.imageView.superview == nil {
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.contentView.addSubview(self.imageView)
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[view]|",
                    options: [],
                    metrics: nil,
                    views: ["view": self.imageView]
                )
            )
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[view]|",
                    options: [],
                    metrics: nil,
                    views: ["view": self.imageView]
                )
            )
        }

        super.layoutSubviews()
    }

}
