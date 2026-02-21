protocol TopicsApi {
  func getTopics(req: GetTopicsRequest) async throws -> GetTopicsResponseModel

  func createTopic(req: CreateTopicRequest) async throws -> CreateTopicResponseModel
}
