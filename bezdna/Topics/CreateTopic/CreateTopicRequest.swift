import Foundation

struct CreateTopicRequest: ApiRequest {
  typealias ApiResponse = CreateTopicResponseModel

  var method: HTTPMethod {
    .post
  }

  var path: String {
    "/topics"
  }

  var queryItems: [URLQueryItem]? {
    []
  }

  let model: CreateTopicRequestModel

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct CreateTopicRequestModel: Encodable {
  let title: String
}

struct CreateTopicResponseModel: Decodable {
  let topic: Topic

  struct Topic: Decodable {
    let topicId: UUID
  }
}
