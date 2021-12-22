
import Foundation

struct DecodingError: Error {}

struct Message: Decodable {
    var userID: Int
    var username: String
    var avatarURL: URL?
    var text: String
    
    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case username = "name"
        case avatarURL = "avatar_url"
        case text = "message"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let userIDString = try container.decode(String.self, forKey: .userID)
        guard let userIDInteger = Int(userIDString) else {
            throw DecodingError()
        }
        userID = userIDInteger
        username = try container.decode(String.self, forKey: .username)
        avatarURL = try? container.decode(URL.self, forKey: .avatarURL)
        text = try container.decode(String.self, forKey: .text)
    }
}








