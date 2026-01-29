/*
 чёт во всех имплементациях получились методы 1 в 1, надо будет по драить это
 */

final class UsersApiImpl: UsersApi {
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

  func getUser(req: GetUserRequest) async throws -> GetUserResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

  func getUserMessages(req: GetUserMessagesRequest) async throws -> GetUserMessagesResponseModel {
    let data = try await api.request(req: req)
    return try req.decode(data)
  }

}
