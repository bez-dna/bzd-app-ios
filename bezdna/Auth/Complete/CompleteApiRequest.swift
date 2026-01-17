import Foundation

struct CompleteApiRequest: ApiRequest {
  typealias ApiResponse = CompleteResponseModel

  var method: HTTPMethod { .post }
  var path: String { "/auth/complete" }
  var queryItems: [URLQueryItem]?

  let model: CompleteRequestModel

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct CompleteRequestModel: Encodable {
  let verificationId: UUID
  let code: String
  let name: String?
}

struct CompleteResponseModel: Decodable {
  let jwt: String
}
