import Foundation

struct JoinApiRequest: ApiRequest {
  typealias ApiResponse = JoinResponseModel

  var method: HTTPMethod { .post }
  var path: String { "/auth/join" }
  var queryItems: [URLQueryItem]?

  let model: JoinRequestModel

  func encode() throws -> Data? {
    return try ApiCodec.shared.encode(self.model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    return try ApiCodec.shared.decode(data)
  }
}

struct JoinRequestModel: Encodable {
  let phoneNumber: String
}

struct JoinResponseModel: Decodable {
  let verification: Verification
  let isNew: Bool

  struct Verification: Decodable {
    let verificationId: UUID
  }
}
