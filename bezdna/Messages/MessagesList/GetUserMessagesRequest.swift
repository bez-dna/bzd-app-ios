import Foundation

class GetUserMessagesRequest: ApiRequest {
  typealias ApiResponse = GetUserMessagesResponseModel

  var method: HTTPMethod { .get }
  var path: String { "/messages" }
  var queryItems: [URLQueryItem]?

  func encode() throws -> Data? {
    return nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    return try ApiCodec.shared.decode(data)
  }
}

struct GetUserMessagesRequestModel: Encodable {
  let cursorMessageId: UUID?
}

struct GetUserMessagesResponseModel: Decodable {
  let messages: [Message]

  struct Message: Decodable {
    let messageId: UUID
    let text: String
  }
}
