import Foundation

class GetMessageMessagesTopicsRequest: ApiRequest {
  typealias ApiResponse = GetMessageMessagesTopicsResponseModel

  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/messages/\(messageId)/messages-topics"
  }

  var queryItems: [URLQueryItem]?

  let messageId: UUID

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

struct GetMessageMessagesTopicsResponseModel: Decodable {
  let topics: [Topic]
  let messagesTopics: [MessageTopic]

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
