import Foundation

struct JoinRequest: APIRequest {
  typealias APIResponse = JoinResponseModel

  var method: HTTPMethod { .POST }
  var path: String { "/auth/join" }

  let model: JoinRequestModel

  func encode(e: JSONEncoder) throws -> Data? {
    let data = try e.encode(self.model)

    return data
  }

  func decode(d: JSONDecoder, data: Data) throws -> APIResponse {
    return try d.decode(JoinResponseModel.self, from: data)
  }
}

struct JoinRequestModel: Encodable {
  let phoneNumber: String
}

struct JoinResponseModel: Decodable {
  let verification: Verification

  struct Verification: Decodable {
    let verificationId: String
  }
}
