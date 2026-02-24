protocol MessagesApi {
  func getMessage(req: GetMessageRequest) async throws -> GetMessageResponseModel

  func getFeedMessages(req: GetFeedMessagesRequest) async throws -> GetFeedMessagesResponseModel

  func getMessageMessages(req: GetMessageMessagesRequest) async throws -> GetMessageMessagesResponseModel

  func getMessageMessagesTopics(req: GetMessageMessagesTopicsRequest) async throws -> GetMessageMessagesTopicsResponseModel

  func createMessage(req: CreateMessageRequest) async throws -> CreateMessageResponseModel

  func createMessageTopic(req: CreateMessageTopicRequest) async throws -> CreateMessageTopicResponseModel

  func deleteMessageTopic(req: DeleteMessageTopicRequest) async throws -> DeleteMessageTopicResponseModel
}
