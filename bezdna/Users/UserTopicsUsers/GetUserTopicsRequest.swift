import Foundation

struct GetUserTopicsRequest: ApiRequest {
  typealias ApiResponse = GetUserTopicsResponseModel

  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/users/\(userId)/topics"
  }

  var queryItems: [URLQueryItem]?

  let userId: UUID

  init(userId: UUID) {
    self.userId = userId
  }

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct GetUserTopicsRequestModel: Encodable {
  let userId: UUID
}

struct GetUserTopicsResponseModel: Decodable {
  let topics: [Topic]
  let topicsUsers: [TopicUser]
  let permissions: Permissions

  struct Topic: Decodable {
    let topicId: UUID
    let title: String
  }

  struct TopicUser: Decodable {
    let topicUserId: UUID
    let topicId: UUID
    let userId: UUID
  }

  struct Permissions: Decodable {
    let topicsUsers: Bool
  }
}
