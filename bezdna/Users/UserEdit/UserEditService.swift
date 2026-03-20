import SwiftUI

@Observable
final class UserEditService {
  var model: UserEditModel

  @ObservationIgnored
  let user: GetUserResponseModel.User

  @ObservationIgnored
  private let api: UsersApi

  init(api: ApiClient, user: GetUserResponseModel.User) {
    self.api = UsersApiImpl(with: api)
    self.user = user
    self.model = .init(u: user)
  }

  func save() async throws {
    let _ = try await api.updateUser(req: .init(model: .init(name: model.name)))
  }
}
