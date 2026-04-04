import Foundation

struct MeApiRequest: ApiRequest {
  typealias ApiResponse = MeResponseModel

  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/auth/me"
  }

  var queryItems: [URLQueryItem]?

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct MeResponseModel: Decodable {
  let user: User?

  struct User: Decodable {
    let userId: UUID
    let name: String
    let abbr: String
    let color: String
  }
}
