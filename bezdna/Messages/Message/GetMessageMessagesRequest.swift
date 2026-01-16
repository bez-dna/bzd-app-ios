import Foundation

class GetMessageMessagesRequest: ApiRequest {
  typealias ApiResponse = GetMessageMessagesResponseModel

  let messageId: UUID
  let model: GetMessageMessagesRequestModel
  var method: HTTPMethod { .get }
  var path: String { "/messages/\(messageId)/messages" }
  var queryItems: [URLQueryItem]?


  init(_ messageId: UUID, _ model: GetMessageMessagesRequestModel) {
    self.messageId = messageId
    self.model = model

    if let cursorMessageId = model.cursorMessageId {
      self.queryItems = [URLQueryItem(name: "cursor_message_id", value: cursorMessageId.uuidString) ]
    }

  }

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    return try ApiCodec.shared.decode(data)
  }
}

struct GetMessageMessagesRequestModel: Encodable {
  let cursorMessageId: UUID?
}

struct GetMessageMessagesResponseModel: Decodable {
  let messages: [Message]
  let cursorMessageId: UUID?

  struct Message: Decodable {
    let messageId: UUID
    let text: String
  }
}
