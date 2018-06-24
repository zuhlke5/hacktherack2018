import Foundation

protocol MoodBoardViewProtocol: class {

    var interactor: MoodBoardInteractorProtocol? { get set }

    func present(data: MoodBoardData)

    func presentFailure()

}

protocol MoodBoardInteractorProtocol: class {

    var presenter: MoodBoardPresenterProtocol? { get set }

    func searchWithTerms(_ terms: String)

    func searchWithTags(_ tags: [String])

}

protocol MoodBoardPresenterProtocol: class {

    var view: MoodBoardViewProtocol? { get set }

    func handleResponse(_ response: MoodBoardData)

    func handleFailure()

}

struct MoodBoardData: Codable {

    struct ImageItem: Codable {

        var imageId: String

        var imageURL: String

        var width: Int

        var height: Int

        var tags: [String]

    }

    var primaryImage: ImageItem

    var dimensions: [[ImageItem]]
    
}
