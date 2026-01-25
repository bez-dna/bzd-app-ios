import Foundation

struct GetUsersRequest: ApiRequest {
  typealias ApiResponse = GetUsersResponseModel

  var method: HTTPMethod { .get }
  var path: String { "/users" }
  var queryItems: [URLQueryItem]?

  func encode() throws -> Data? {
    nil
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct GetUsersResponseModel: Decodable {
  let users: [User]

  struct User: Decodable {
    let userId: UUID
    let name: String
    let abbr: String
    let color: String
  }
}
