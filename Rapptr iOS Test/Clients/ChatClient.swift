
import Foundation


class ChatClient {
    var session: URLSession?
    
    func fetchChatData(completion: @escaping ([Message]) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let url = URL(string: "http://dev.rapptrlabs.com/Tests/scripts/chat_log.php") else {
            errorHandler("Cannot generate URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                errorHandler(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                errorHandler("No response")
                return
            }
            
            struct ChatResponse: Decodable {
                let data: [Message]
            }
            
            guard
                let data = data
            else {
                errorHandler("No data")
                return
            }
            
            do {
                let chatResponse = try JSONDecoder().decode(ChatResponse.self, from: data)
                completion(chatResponse.data)
            } catch {
                print("Error decoding chat response:", error)
                errorHandler("Something went wrong")
            }
        }
        
        task.resume()
    }
}
