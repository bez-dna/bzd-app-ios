import Foundation

struct CreateMessageRequest: ApiRequest {
  typealias ApiResponse = CreateMessageResponseModel

  var method: HTTPMethod { .post }
  var path: String { "/messages" }
  var queryItems: [URLQueryItem]? { [] }
  let model: CreateMessageRequestModel

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct CreateMessageRequestModel: Encodable {
  let text: String
  let code: String
  let messageId: UUID?
}

struct CreateMessageResponseModel: Decodable {
  let message: Message

  struct Message: Decodable {
    let messageId: UUID
  }
}
