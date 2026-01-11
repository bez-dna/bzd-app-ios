protocol AuthApi {
  func join(req: JoinApiRequest) async throws -> JoinResponseModel

  func complete(req: CompleteApiRequest) async throws -> CompleteResponseModel

}
