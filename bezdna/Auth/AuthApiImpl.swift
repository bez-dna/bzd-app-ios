struct AuthApiImpl: AuthApi {
  private let api: ApiClient = .shared

  func join(req: JoinApiRequest) async throws -> JoinResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

  func complete(req: CompleteApiRequest) async throws -> CompleteResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }
}
