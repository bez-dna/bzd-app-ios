import Foundation

struct DeleteTopicUserRequest: ApiRequest {
  typealias ApiResponse = DeleteTopicUserResponseModel

  var method: HTTPMethod {
    .delete
  }

  var path: String {
    "/users/topics"
  }

  var queryItems: [URLQueryItem]? {
    []
  }

  private let model: DeleteTopicUserRequestModel

  init(model: DeleteTopicUserRequestModel) {
    self.model = model
  }

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct DeleteTopicUserRequestModel: Encodable {
  let topicUserId: UUID
}

struct DeleteTopicUserResponseModel: Decodable {}
