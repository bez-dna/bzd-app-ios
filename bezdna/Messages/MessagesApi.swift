protocol MessagesApi {
  func getUserMessages(req: GetUserMessagesRequest) async throws -> GetUserMessagesResponseModel

  func getMessageMessages(req: GetMessageMessagesRequest) async throws
    -> GetMessageMessagesResponseModel

  func createMessage(req: CreateMessageRequest) async throws -> CreateMessageResponseModel
}
