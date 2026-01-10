import Foundation

enum HTTPMethod: String {
  case GET
  case POST
  case PUT
  case DELETE
  case PATCH
}

protocol APIRequest {
  associatedtype APIResponse

  var method: HTTPMethod { get }
  var path: String { get }

  func encode(e: JSONEncoder) throws -> Data?

  func decode(d: JSONDecoder, data: Data) throws -> APIResponse
}
