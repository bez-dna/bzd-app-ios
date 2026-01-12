import Foundation
import SwiftUI

enum HTTPHeader: String {
    case authorization = "Authorization"
    case contentType = "Content-Type"
}

class ApiClient {
  private let appModel: AppModel
  private let urlSession: URLSession = .shared

  init(with appModel: AppModel) {
    self.appModel = appModel
  }

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
    urlReq.setValue("application/json", forHTTPHeaderField: HTTPHeader.contentType.rawValue)

    if let token = appModel.token {
      urlReq.setValue("Bearer \(token)", forHTTPHeaderField: HTTPHeader.authorization.rawValue)
    }

    urlReq.httpMethod = req.method.rawValue.uppercased()
    urlReq.httpBody = try req.encode()

    let (data, _) = try await urlSession.data(for: urlReq)

    return data
  }
}
