class TopicsApiImpl: TopicsApi {
  private let api: ApiClient

  init(_ api: ApiClient) {
    self.api = api
  }

  func createTopic(req: CreateTopicRequest) async throws -> CreateTopicResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }
}
