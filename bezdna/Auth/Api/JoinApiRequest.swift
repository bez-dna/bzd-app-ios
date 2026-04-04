import Foundation

struct JoinApiRequest: ApiRequest {
  typealias ApiResponse = JoinResponseModel

  var method: HTTPMethod {
    .post
  }

  var path: String {
    "/auth/join"
  }

  var queryItems: [URLQueryItem]?

  let model: JoinRequestModel

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct JoinRequestModel: Encodable {
  let phone: String
}

struct JoinResponseModel: Decodable {
  let verification: Verification

  struct Verification: Decodable {
    let verificationId: UUID
  }
}
