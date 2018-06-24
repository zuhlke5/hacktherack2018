import UIKit

class MoodBoardViewController: UICollectionViewController, MoodBoardViewProtocol {

    var interactor: MoodBoardInteractorProtocol?

    func present(data: MoodBoardData) {
        self.data = data
        self.stopLoading()
    }

    func presentFailure() {
        self.stopLoading()
    }

    // MARK: Internal Implementation

    private var data: MoodBoardData? {
        didSet {
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        }
    }

    private let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    private func startLoading() {
        self.view.isUserInteractionEnabled = false
        self.spinner.startAnimating()
    }

    private func stopLoading() {
        self.view.isUserInteractionEnabled = true
        self.spinner.stopAnimating()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.interactor = MoodBoardInteractor()
        self.interactor?.presenter = MoodBoardPresenter()
        self.interactor?.presenter?.view = self

        self.spinner.hidesWhenStopped = true
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.spinner)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.startLoading()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Image", for: indexPath)
        if let cell = cell as? MoodBoardImageCell, let data = data {
            let item: MoodBoardData.ImageItem = {
                if indexPath.section == 0 {
                    return data.primaryImage
                } else {
                    return data.dimensions[indexPath.section - 1][indexPath.item]
                }
            }()
            cell.imageURL = item.imageURL
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

        self.startLoading()
        self.interactor?.searchWithTags(item.tags)
    }

}
