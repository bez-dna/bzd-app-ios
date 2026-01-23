protocol UsersApi {
  func createContacts(req: CreateContactsRequest) async throws -> CreateContactsResponseModel
}
