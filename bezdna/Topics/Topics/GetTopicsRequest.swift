import Foundation

struct GetTopicsRequest: ApiRequest {
  typealias ApiResponse = GetTopicsResponseModel

  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/topics"
  }

  var queryItems: [URLQueryItem]?

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct GetTopicsResponseModel: Decodable {
  let topics: [Topic]
  let emojis: [Emoji]
  let permissions: Permissions

  struct Topic: Decodable {
    let topicId: UUID
    let title: String
  }

  struct Emoji: Decodable {
    let title: String
    let code: String
  }

  struct Permissions: Decodable {
    let topics: Bool
  }
}
