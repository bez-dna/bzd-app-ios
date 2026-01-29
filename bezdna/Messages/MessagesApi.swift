protocol MessagesApi {
  func getFeedMessages(req: GetFeedMessagesRequest) async throws -> GetFeedMessagesResponseModel

  func getMessageMessages(req: GetMessageMessagesRequest) async throws
    -> GetMessageMessagesResponseModel

  func createMessage(req: CreateMessageRequest) async throws -> CreateMessageResponseModel
}
