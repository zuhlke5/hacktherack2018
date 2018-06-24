import Foundation

class MoodBoardInteractor: MoodBoardInteractorProtocol {

    var presenter: MoodBoardPresenterProtocol?

    var imageAPIWorker: ImageAPIWorker? = ImageAPIWorker()

    func searchWithTerms(_ terms: String) {
        let tags = terms.split(separator: " ").map { String($0) }.filter { !$0.isEmpty }
        self.imageAPIWorker?.searchImage(tags: tags, completion: { success, images in
            guard success, let data = images.makeMoodBoardData(with: tags) else {
                self.presenter?.handleFailure()
                return
            }
            self.presenter?.handleResponse(data)
        })
    }

    func searchWithTags(_ tags: [String]) {
        self.imageAPIWorker?.searchImage(tags: tags, completion: { success, images in
            guard success, let data = images.makeMoodBoardData(with: tags) else {
                self.presenter?.handleFailure()
                return
            }
            self.presenter?.handleResponse(data)
        })
    }

}

extension Array where Element == SearchedImage {

    func makeMoodBoardData(with tags: [String]) -> MoodBoardData? {
        var sorted = self.sorted(by: { $0.relevance(with: tags) < $1.relevance(with: tags) })

        guard let primaryImage = sorted.first?.makeMoodBoardImageItem() else {
            return nil
        }

        let dimensions: [String: [MoodBoardData.ImageItem]] = sorted[1 ..< sorted.count].reduce(into: [:]) { result, image in
            guard let tag = image.mostRelevanceTag else {
                return
            }
            result[tag] = (result[tag] ?? []) + [image.makeMoodBoardImageItem()]
        }

        let dimensionList = dimensions.map { $0 }.sorted { $0.key < $1.key }.map { $0.value }

        let data = MoodBoardData(
            primaryImage: primaryImage,
            dimensions: dimensionList
        )
        return data
    }

}

extension SearchedImage {

    var mostRelevanceTag: String? {
        return self.predictions.max { $0.probability < $1.probability }?.tagName
    }

    func relevance(with tags: [String]) -> Double {
        let allConfidence: [Double] = tags.compactMap { tag -> Double? in
            return self.predictions.first { $0.tagName == tag }?.probability
        }

        return allConfidence.reduce(0.0) { return $0 + $1 / Double(allConfidence.count) }
    }

    func makeMoodBoardImageItem() -> MoodBoardData.ImageItem {
        return MoodBoardData.ImageItem(imageId: self.id, imageURL: self.thumbnailUri, tags: self.predictions.map { $0.tagName })
    }

}
