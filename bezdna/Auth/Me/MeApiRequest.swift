import Foundation

struct MeApiRequest: ApiRequest {
  typealias ApiResponse = MeResponseModel

  var method: HTTPMethod { .get }
  var path: String { "/auth/me" }

  func encode() throws -> Data? {
    return nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    return try ApiCodec.shared.decode(data)
  }
}

struct MeResponseModel: Decodable {
  let user: User?

  struct User: Decodable {
    let userId: UUID
  }
}
