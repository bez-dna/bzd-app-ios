protocol MessagesApi {
  func get_user_messages(req: GetUserMessagesRequest) async throws -> GetUserMessagesResponseModel

  func get_message_messages(req: GetMessageMessagesRequest) async throws
    -> GetMessageMessagesResponseModel
}
