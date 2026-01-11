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
    let data = try self.jsonEncoder.encode(value)

    return data
  }

  func decode<T>(_ data: Data) throws -> T where T: Decodable {
    let value = try self.jsonDecoder.decode(T.self, from: data)

    return value
  }
}
