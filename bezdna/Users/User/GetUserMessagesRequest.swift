import Foundation

struct GetUserMessagesRequest: ApiRequest {
  typealias ApiResponse = GetUserMessagesResponseModel

  let userId: UUID
  let model: GetUserMessagesRequestModel
  var method: HTTPMethod { .get }
  var path: String { "/users/\(userId)/messages" }
  var queryItems: [URLQueryItem]?

  init(userId: UUID, model: GetUserMessagesRequestModel) {
    self.userId = userId
    self.model = model

    if let cursorMessageId = model.cursorMessageId {
      queryItems = [URLQueryItem(name: "cursor_message_id", value: cursorMessageId.uuidString)]
    }
  }

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct GetUserMessagesRequestModel: Encodable {
  let cursorMessageId: UUID?
}

struct GetUserMessagesResponseModel: Decodable {
  let messages: [Message]
  let cursorMessageId: UUID?

  struct Message: Decodable {
    let messageId: UUID
    let text: String
    let user: User

    struct User: Decodable {
      let userId: UUID
      let name: String
      let abbr: String
      let color: String
    }
  }
}
