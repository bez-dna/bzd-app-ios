class MessagesApiImpl: MessagesApi {
  private let api: ApiClient

  init(_ api: ApiClient) {
    self.api = api
  }

  func get_user_messages(req: GetUserMessagesRequest) async throws -> GetUserMessagesResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

  func get_message_messages(req: GetMessageMessagesRequest) async throws
    -> GetMessageMessagesResponseModel
  {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }
}
