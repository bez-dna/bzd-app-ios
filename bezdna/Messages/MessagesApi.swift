protocol MessagesApi {
  func getUserMessages(req: GetUserMessagesRequest) async throws -> GetUserMessagesResponseModel

  func getMessageMessages(req: GetMessageMessagesRequest) async throws
    -> GetMessageMessagesResponseModel
}
