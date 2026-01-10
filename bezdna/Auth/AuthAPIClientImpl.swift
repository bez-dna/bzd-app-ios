import Foundation

struct AuthAPIClientImpl: AuthAPIClient {
  private let api: APIClient = .shared

  func join(req: JoinRequest) async throws -> JoinResponseModel {
    let data =  try await api.request(req: req)
    return  try req.decode(d: api.jsonDecoder, data: data)
  }
}
