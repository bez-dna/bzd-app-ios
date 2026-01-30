import Foundation

struct ApiCodec {
  static let shared = ApiCodec()

  let jsonEncoder: JSONEncoder
  let jsonDecoder: JSONDecoder

  init() {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.keyEncodingStrategy = .convertToSnakeCase

    self.jsonEncoder = jsonEncoder

    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

    self.jsonDecoder = jsonDecoder
  }

  func encode(_ value: Encodable) throws -> Data {
    try jsonEncoder.encode(value)
  }

  func decode<T: Decodable>(_ data: Data) throws -> T {
    try jsonDecoder.decode(T.self, from: data)
  }
}
