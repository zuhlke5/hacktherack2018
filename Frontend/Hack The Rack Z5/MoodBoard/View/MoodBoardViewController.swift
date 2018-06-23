//
//  MoodBoardViewController.swift
//  Hack The Rack Z5
//
//  Created by Kevin Lo on 23/6/2018.
//  Copyright © 2018 Zuhlke. All rights reserved.
//

import UIKit

class MoodBoardViewController: UICollectionViewController, MoodBoardViewProtocol {

    var interactor: MoodBoardInteractorProtocol?

    func present(data: MoodBoardData) {
        self.data = data
    }

    // MARK: Internal Implementation

    var data: MoodBoardData? {
        didSet {
            self.collectionView?.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MoodBoardInteractor()
        self.interactor?.presenter = MoodBoardPresenter()
        self.interactor?.presenter?.view = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactor?.searchWithTerms(self.title ?? "")
    }

}

// MARK: - UICollectionViewDataSource

extension MoodBoardViewController {

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let data = data else {
            return 0
        }
        return data.dimensions.count + 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let data = data else {
            return 0
        }

        if section == 0 {
            return 1
        } else {
            let dimensionIndex = section - 1
            return data.dimensions[dimensionIndex].count
        }
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Text", for: indexPath)
        if let cell = cell as? MoodBoardTextCell {
            cell.text = "\(indexPath.section) - \(indexPath.row)"
        }
        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)

        guard let data = data else {
            return
        }

        let item: MoodBoardData.ImageItem = {
            if indexPath.section == 0 {
                return data.primaryImage
            } else {
                return data.dimensions[indexPath.section - 1][indexPath.item]
            }
        }()
        self.interactor?.searchWithImageId(item.imageId)
    }

}
