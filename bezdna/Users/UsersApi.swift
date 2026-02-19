protocol UsersApi {
  func createContacts(req: CreateContactsRequest) async throws -> CreateContactsResponseModel

  func getUsers(req: GetUsersRequest) async throws -> GetUsersResponseModel

  func getUser(req: GetUserRequest) async throws -> GetUserResponseModel

  func getUserMessages(req: GetUserMessagesRequest) async throws -> GetUserMessagesResponseModel

  func getUserTopics(req: GetUserTopicsRequest) async throws -> GetUserTopicsResponseModel

  func createTopicUser(req: CreateTopicUserRequest) async throws -> CreateTopicUserResponseModel

  func deleteTopicUser(req: DeleteTopicUserRequest) async throws -> DeleteTopicUserResponseModel
}
