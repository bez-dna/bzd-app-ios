protocol AuthApi {
  func join(req: JoinApiRequest) async throws -> JoinResponseModel

  func complete(req: CompleteApiRequest) async throws -> CompleteResponseModel

  func me(req: MeApiRequest) async throws -> MeResponseModel
}
