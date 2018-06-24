import Foundation

class ImageAPIWorker {

    func searchImage(tags: [String], completion: @escaping (Bool, [SearchedImage]) -> Void) {
        let tagIds = tags.joined(separator: ",")
        let urlString = "https://southcentralus.api.cognitive.microsoft.com/customvision/v2.0/Training/projects/4b4cc7f0-1d4b-483f-8c6a-8fc6deec71dc/iterations/909f66a4-4b1a-4884-ba65-274a9c2a7f08/performance/images?tagIds=\(tagIds)&take=100"
        var request = URLRequest(url: URL(string: urlString)!)
        request.httpMethod = "GET"
        request.setValue("06ede47690cb4b729132b9037b2f0b15", forHTTPHeaderField: "Training-key")
        let task = URLSession.shared.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data, let response = self.serializeResponse(data: data) else {
                DispatchQueue.main.async {
                    completion(false, [])
                }
                return
            }
            DispatchQueue.main.async {
                completion(true, response)
            }
        }
        task.resume()
    }

    private func serializeResponse(data: Data) -> [SearchedImage]? {
        do {
            return try JSONDecoder().decode([SearchedImage].self, from: data)
        } catch {
            NSLog("Error Info: %@", (error as NSError).userInfo)
            NSLog("Error: %@", error.localizedDescription)
            return nil
        }
    }

}

struct SearchedImage: Codable {

    struct Predication: Codable {

        var probability: Double

        var tagId: String

        var tagName: String

    }

    var id: String

    var imageUri: String

    var thumbnailUri: String

    var width: Int

    var height: Int

    var predictions: [Predication]

}
