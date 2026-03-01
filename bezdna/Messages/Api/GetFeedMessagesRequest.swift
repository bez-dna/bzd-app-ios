import Foundation

class GetFeedMessagesRequest: ApiRequest {
  typealias ApiResponse = GetFeedMessagesResponseModel

  let model: GetFeedMessagesRequestModel
  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/messages"
  }

  var queryItems: [URLQueryItem]?

  init(_ model: GetFeedMessagesRequestModel) {
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

struct GetFeedMessagesRequestModel: Encodable {
  let cursorMessageId: UUID?
}

struct GetFeedMessagesResponseModel: Decodable {
  let messages: [Message]
  let topics: [Topic]
  let messagesTopics: [MessageTopic]
  let cursorMessageId: UUID?

  struct Message: Decodable {
    let messageId: UUID
    let text: String
    let code: String
    let order: Int64
    let user: User
    let stream: Stream?
    let permissions: Permissions

    struct User: Decodable {
      let userId: UUID
      let name: String
      let abbr: String
      let color: String
    }

    struct Stream: Decodable {
      let streamId: UUID
      let messageId: UUID
      let text: String
      let messagesCount: Int64
      let users: [User]
    }

    struct Permissions: Decodable {
      let message: Bool
      let topics: Bool
    }
  }

  struct Topic: Decodable {
    let topicId: UUID
    let title: String
  }

  struct MessageTopic: Decodable {
    let messageTopicId: UUID
    let topicId: UUID
    let messageId: UUID
  }
}
