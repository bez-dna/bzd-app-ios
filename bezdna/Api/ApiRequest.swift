import Foundation

enum HTTPMethod: String {
  case get
  case post
  case delete
}

protocol ApiRequest {
  associatedtype ApiResponse

  var method: HTTPMethod { get }
  var path: String { get }
  var queryItems: [URLQueryItem]? { get }

  func encode() throws -> Data?

  func decode(_ data: Data) throws -> ApiResponse
}
