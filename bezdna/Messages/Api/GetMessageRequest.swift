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
  let topics: [Topic]
  let messagesTopics: [MessageTopic]

  struct Message: Decodable {
    let messageId: UUID
    let text: String
    let code: String
    let order: Int64
    let user: User
    let permissions: Permissions

    struct User: Decodable {
      let userId: UUID
      let name: String
      let abbr: String
      let color: String
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
