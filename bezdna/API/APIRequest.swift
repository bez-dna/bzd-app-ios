import Foundation

enum HTTPMethod: String {
  case get
  case post
}

protocol APIRequest {
  associatedtype APIResponse

  var method: HTTPMethod { get }
  var path: String { get }

  func encode(e: JSONEncoder) throws -> Data?

  func decode(d: JSONDecoder, data: Data) throws -> APIResponse
}
