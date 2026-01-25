protocol UsersApi {
  func createContacts(req: CreateContactsRequest) async throws -> CreateContactsResponseModel

  func getUsers(req: GetUsersRequest) async throws -> GetUsersResponseModel
}
