import Foundation

protocol MoodBoardViewProtocol: class {

    var interactor: MoodBoardInteractorProtocol? { get set }

    func present(data: MoodBoardData)

}

protocol MoodBoardInteractorProtocol: class {

    var presenter: MoodBoardPresenterProtocol? { get set }

    func searchWithTerms(_ terms: String)

    func searchWithImageId(_ imageId: String)

}

protocol MoodBoardPresenterProtocol: class {

    var view: MoodBoardViewProtocol? { get set }

    func handleResponse(_ response: MoodBoardData)

}

struct MoodBoardData: Codable {

    struct ImageItem: Codable {

        var imageId: String

        var imageURL: String

    }

    var primaryImage: ImageItem

    var dimensions: [[ImageItem]]
    
}
