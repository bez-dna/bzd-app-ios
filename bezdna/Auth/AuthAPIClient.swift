protocol AuthAPIClient {
  func join(req: JoinRequest) async throws -> JoinResponseModel
}
