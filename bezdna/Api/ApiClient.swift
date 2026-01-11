import Foundation

class ApiClient {
  private let urlSession: URLSession = .shared

  static let shared = ApiClient()

  func request(req: any ApiRequest) async throws -> Data {
    var urlComp = URLComponents()

    urlComp.scheme = AppSettings.API.scheme
    urlComp.host = AppSettings.API.host
    urlComp.port = AppSettings.API.port

    urlComp.path = "/api" + req.path

    guard let url = urlComp.url else {
      throw URLError(.badURL)
    }

    var urlReq = URLRequest(url: url)
    urlReq.setValue("application/json", forHTTPHeaderField: "Content-Type")
    urlReq.httpMethod = req.method.rawValue.uppercased()
    urlReq.httpBody = try req.encode()

    let (data, _) = try await urlSession.data(for: urlReq)

    return data
  }
}
