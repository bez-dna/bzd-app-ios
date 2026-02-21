import Foundation

struct CreateTopicUserRequest: ApiRequest {
  typealias ApiResponse = CreateTopicUserResponseModel

  var method: HTTPMethod {
    .post
  }

  var path: String {
    "/users/topics"
  }

  var queryItems: [URLQueryItem]? {
    []
  }

  private let model: CreateTopicUserRequestModel

  init(model: CreateTopicUserRequestModel) {
    self.model = model
  }

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct CreateTopicUserRequestModel: Encodable {
  let topicId: UUID
}

struct CreateTopicUserResponseModel: Decodable {
  let topicUser: TopicUser

  struct TopicUser: Decodable {
    let topicUserId: UUID
  }
}
