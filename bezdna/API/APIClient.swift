import Foundation

class APIClient {
  private let urlSession: URLSession = .shared
  let jsonEncoder: JSONEncoder
  let jsonDecoder: JSONDecoder
  static let shared = APIClient()

  init() {
    let jsonEncoder = JSONEncoder()
    jsonEncoder.keyEncodingStrategy = .convertToSnakeCase

    self.jsonEncoder = jsonEncoder

    let jsonDecoder = JSONDecoder()
    jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase

    self.jsonDecoder = jsonDecoder
  }

  func request(req: any APIRequest) async throws -> Data {
    guard var urlComp = URLComponents(string: "http://localhost:3010") else {
      throw URLError(.badURL)
    }

    urlComp.path = "/api" + req.path

    guard let url = urlComp.url else {
      throw URLError(.badURL)
    }

    var urlReq = URLRequest(url: url)
    urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlReq.httpMethod = req.method.rawValue
    urlReq.httpBody = try req.encode(e: self.jsonEncoder)

    let (data, _) = try await urlSession.data(for: urlReq)

    return data
  }
}
