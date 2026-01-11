import Foundation

enum HTTPMethod: String {
  case get
  case post
}

protocol ApiRequest {
  associatedtype ApiResponse

  var method: HTTPMethod { get }
  var path: String { get }

  func encode() throws -> Data?

  func decode(_ data: Data) throws -> ApiResponse
}
