import UIKit

private let MoodBoardItemSize: CGSize = CGSize(width: 100, height: 100)

private let MoodBoardShinking = 0.85

private let MoodBoardMargin: CGFloat = 16

class MoodBoardLayout: UICollectionViewLayout {

    var isInvalidated: Bool = false

    // MARK: Private properties

    private var attributes: [UICollectionViewLayoutAttributes] = []

    // MARK: Overrides

    override func prepare() {
        guard
            self.isInvalidated,
            let collectionView = self.collectionView,
            collectionView.numberOfSections > 0,
            collectionView.numberOfItems(inSection: 0) > 0
            else
        {
            return
        }

        var newAttributes: [UICollectionViewLayoutAttributes] = []

        // Primary
        let primaryAttr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: 0, section: 0))
        primaryAttr.bounds = CGRect(origin: CGPoint.zero, size: MoodBoardItemSize)
        primaryAttr.center = CGPoint(x: collectionView.frame.size.width / 2, y: collectionView.frame.size.height / 2)
        newAttributes.append(primaryAttr)

        // Dimensions
        if collectionView.numberOfSections > 1 {
            for section in 1 ..< collectionView.numberOfSections {
                var dimensionAttributes: [UICollectionViewLayoutAttributes] = []
                for item in 0 ..< collectionView.numberOfItems(inSection: section) {
                    let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: item, section: section))
                    let shink = pow(MoodBoardShinking, Double(item + 1))
                    attr.frame = CGRect(
                        x: MoodBoardItemSize.width * CGFloat(shink) / -2.0,
                        y: (dimensionAttributes.last?.frame.minY ?? 0) - MoodBoardMargin - MoodBoardItemSize.height * CGFloat(shink),
                        width: MoodBoardItemSize.width * CGFloat(shink),
                        height: MoodBoardItemSize.height * CGFloat(shink)
                    )
                    dimensionAttributes.append(attr)
                }
                dimensionAttributes.forEach {
                    self.adjustPosition(
                        of: $0,
                        numberOfSections: collectionView.numberOfSections,
                        center: primaryAttr.center
                    )
                }
                newAttributes.append(contentsOf: dimensionAttributes)
            }
        }

        self.attributes = newAttributes
        self.isInvalidated = false
    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return self.attributes.filter{ rect.intersects($0.frame) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return attributes.first { $0.indexPath == indexPath }
    }

    override var collectionViewContentSize: CGSize {
        return self.collectionView?.bounds.size ?? CGSize.zero
    }

    override func invalidateLayout(with context: UICollectionViewLayoutInvalidationContext) {
        if context.invalidateEverything || context.invalidateDataSourceCounts {
            self.isInvalidated = true
        }
        super.invalidateLayout(with: context)
    }

    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        guard let size = self.collectionView?.bounds.size else {
            return super.shouldInvalidateLayout(forBoundsChange: newBounds)
        }
        return size.equalTo(newBounds.size)
    }

}

extension MoodBoardLayout {

    private func adjustPosition(of attribute: UICollectionViewLayoutAttributes, numberOfSections: Int, center: CGPoint) {
        let angle = CGFloat(2 * Double.pi * Double(attribute.indexPath.section - 1) / Double(numberOfSections - 1))
        let transform = CGAffineTransform.identity
            .translatedBy(x: center.x, y: center.y)
            .rotated(by: angle)
            .translatedBy(x: 0, y: MoodBoardItemSize.height / -2)
        attribute.center = attribute.center.applying(transform)
    }

}
