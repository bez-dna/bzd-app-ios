import Foundation

struct GetUserRequest: ApiRequest {
  typealias ApiResponse = GetUserResponseModel

  let userId: UUID
  var method: HTTPMethod {
    .get
  }

  var path: String {
    "/users/\(userId)"
  }

  var queryItems: [URLQueryItem]?

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

struct GetUserResponseModel: Decodable {
  let user: User

  struct User: Decodable {
    let userId: UUID
    let name: String
    let abbr: String
    let color: String
  }
}
