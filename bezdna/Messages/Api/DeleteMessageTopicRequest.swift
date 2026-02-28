import Foundation

struct DeleteMessageTopicRequest: ApiRequest {
  typealias ApiResponse = DeleteMessageTopicResponseModel

  var method: HTTPMethod {
    .delete
  }

  var path: String {
    "/messages/messages-topics"
  }

  var queryItems: [URLQueryItem]? {
    []
  }

  private let model: DeleteMessageTopicRequestModel

  init(model: DeleteMessageTopicRequestModel) {
    self.model = model
  }

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct DeleteMessageTopicRequestModel: Encodable {
  let messageTopicId: UUID
}

struct DeleteMessageTopicResponseModel: Decodable {}
