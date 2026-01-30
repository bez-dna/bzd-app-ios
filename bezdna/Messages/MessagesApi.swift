protocol MessagesApi {
  func getMessage(req: GetMessageRequest) async throws -> GetMessageResponseModel

  func getFeedMessages(req: GetFeedMessagesRequest) async throws -> GetFeedMessagesResponseModel

  func getMessageMessages(req: GetMessageMessagesRequest) async throws -> GetMessageMessagesResponseModel

  func createMessage(req: CreateMessageRequest) async throws -> CreateMessageResponseModel
}
