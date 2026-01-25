import Foundation

struct CreateContactsRequest: ApiRequest {
  typealias ApiResponse = CreateContactsResponseModel

  var method: HTTPMethod { .post }
  var path: String { "/contacts" }
  var queryItems: [URLQueryItem]?

  let model: CreateContactsRequestModel

  func encode() throws -> Data? {
    try ApiCodec.shared.encode(model)
  }

  func decode(_ data: Data) throws -> ApiResponse {
    try ApiCodec.shared.decode(data)
  }
}

struct CreateContactsRequestModel: Encodable {
  let contacts: [Contact]

  struct Contact: Encodable {
    let name: String
    let phoneNumber: String
    let deviceContactId: String
  }
}

struct CreateContactsResponseModel: Decodable {}
