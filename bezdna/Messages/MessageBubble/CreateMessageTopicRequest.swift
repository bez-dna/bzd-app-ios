import Foundation

struct CreateMessageTopicRequest: ApiRequest {
  typealias ApiResponse = CreateMessageTopicResponseModel

  var method: HTTPMethod {
    .post
  }

  var path: String {
    "/messages/topics"
  }

  var queryItems: [URLQueryItem]? {
    []
  }

  private let model: CreateMessageTopicRequestModel

  init(model: CreateMessageTopicRequestModel) {
    self.model = model
  }

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct CreateMessageTopicRequestModel: Encodable {
  let topicId: UUID
  let messageId: UUID
}

struct CreateMessageTopicResponseModel: Decodable {
  let messageTopic: MessageTopic

  struct MessageTopic: Decodable {
    let messageTopicId: UUID
  }
}
