import Foundation

class MoodBoardPresenter: MoodBoardPresenterProtocol {

    weak var view: MoodBoardViewProtocol?

    func handleResponse(_ response: MoodBoardData) {
        self.view?.present(data: response)
    }

}
