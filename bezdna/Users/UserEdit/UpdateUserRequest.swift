import Foundation

struct UpdateUserRequest: ApiRequest {
  typealias ApiResponse = UpdateUserResponseModel

  let model: UpdateUserRequestModel
  var method: HTTPMethod {
    .patch
  }

  var path: String {
    "/users"
  }

  var queryItems: [URLQueryItem]?

  init(model: UpdateUserRequestModel) {
    self.model = model
  }

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct UpdateUserRequestModel: Encodable {
  let name: String
}

struct UpdateUserResponseModel: Decodable {}
