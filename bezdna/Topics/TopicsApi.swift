protocol TopicsApi {
  func createTopic(req: CreateTopicRequest) async throws -> CreateTopicResponseModel
}
