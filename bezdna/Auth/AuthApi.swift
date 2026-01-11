protocol AuthApi {
  func join(req: JoinApiRequest) async throws -> JoinResponseModel
}
