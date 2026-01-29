class MessagesApiImpl: MessagesApi {
  private let api: ApiClient

  init(_ api: ApiClient) {
    self.api = api
  }

  func getFeedMessages(req: GetFeedMessagesRequest) async throws -> GetFeedMessagesResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

  func getMessageMessages(req: GetMessageMessagesRequest) async throws
    -> GetMessageMessagesResponseModel
  {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

  func createMessage(req: CreateMessageRequest) async throws -> CreateMessageResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }
}
