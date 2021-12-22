

import Foundation

struct LoginResponse: Decodable {
    let code: String
    let message: String
}


class LoginClient {
    var session: URLSession?
    
    func login(email: String, password: String, completion: @escaping (String) -> Void, error errorHandler: @escaping (String?) -> Void) {
        guard let parameters = "email=\(email)&password=\(password)".addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) else {
            errorHandler("Cannot generate parameters")
            return
        }
        
        let postData = parameters.data(using: .utf8)
        
        var request = URLRequest(
            url: URL(string: "http://dev.rapptrlabs.com/Tests/scripts/login.php")!
        )
        
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpMethod = "POST"
        request.httpBody = postData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                errorHandler(error.localizedDescription)
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                errorHandler("No response")
                return
            }
            
            guard
                let data = data,
                let loginResponse = try? JSONDecoder().decode(LoginResponse.self, from: data)
            else {
                errorHandler("No data")
                return
            }
            
            switch response.statusCode {
            case 200 ..< 300:
                completion(loginResponse.message)
            default:
                errorHandler(loginResponse.message)
            }
        }
        
        task.resume()
    }
}
