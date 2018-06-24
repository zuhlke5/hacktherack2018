import UIKit
import Kingfisher

class MoodBoardImageCell: UICollectionViewCell {

    var imageURL: String? {
        willSet {
            guard let url = URL(string: newValue ?? "") else {
                return
            }
            self.imageView.kf.setImage(with: url)
        }
    }

    private let imageView = UIImageView()

    override func layoutSubviews() {
        if self.imageView.superview == nil {
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.imageView.contentMode = .scaleAspectFill
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

            self.imageView.layer.masksToBounds = true
        }

        super.layoutSubviews()

        self.imageView.layer.cornerRadius = self.frame.width / 2.0
    }

}
