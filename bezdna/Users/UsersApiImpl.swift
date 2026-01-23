final class UsersApiImpl : UsersApi {
  private let api: ApiClient

  init(with api: ApiClient) {
    self.api = api
  }

  func createContacts(req: CreateContactsRequest) async throws -> CreateContactsResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

  func getUsers(req: GetUsersRequest) async throws -> GetUsersResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }
}
