import Foundation

class GetMessageRequest: ApiRequest {
  typealias ApiResponse = GetMessageResponseModel

  let messageId: UUID
  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/messages/\(messageId)"
  }

  var queryItems: [URLQueryItem]?

  init(messageId: UUID) {
    self.messageId = messageId
  }

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct GetMessageResponseModel: Decodable {
  let message: Message

  struct Message: Decodable {
    let messageId: UUID
    let text: String
  }
}
