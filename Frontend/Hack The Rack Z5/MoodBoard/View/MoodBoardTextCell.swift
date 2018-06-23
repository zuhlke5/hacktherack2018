import UIKit

class MoodBoardTextCell: UICollectionViewCell {

    var text: String? {
        get {
            return self.label.text
        }
        set {
            self.label.text = newValue
        }
    }

    private let label = UILabel()

    override func layoutSubviews() {
        if self.label.superview == nil {
            self.label.translatesAutoresizingMaskIntoConstraints = false
            self.label.font = UIFont.preferredFont(forTextStyle: .body)
            self.label.textColor = UIColor.darkText
            self.label.textAlignment = .center
            self.contentView.addSubview(self.label)
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "H:|[view]|",
                    options: [],
                    metrics: nil,
                    views: ["view": self.label]
                )
            )
            NSLayoutConstraint.activate(
                NSLayoutConstraint.constraints(
                    withVisualFormat: "V:|[view]|",
                    options: [],
                    metrics: nil,
                    views: ["view": self.label]
                )
            )
            self.label.layer.backgroundColor = UIColor.lightGray.cgColor
        }

        super.layoutSubviews()

        self.label.layer.cornerRadius = self.frame.width / 2.0
    }

}
