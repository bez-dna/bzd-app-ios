import Foundation

class GetMessageTopicsRequest: ApiRequest {
  typealias ApiResponse = GetMessageTopicsResponseModel

  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/messages/\(messageId)/topics"
  }

  var queryItems: [URLQueryItem]?

  private let messageId: UUID

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

struct GetMessageTopicsResponseModel: Decodable {
  let topics: [Topic]
  let messagesTopics: [MessageTopic]

  struct Topic: Decodable {
    let topicId: UUID
    let title: String
  }

  struct MessageTopic: Decodable {
    let messageTopicId: UUID
    let messageId: UUID
    let topicId: UUID
  }
}
