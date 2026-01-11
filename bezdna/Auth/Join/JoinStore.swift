import SwiftUI

@Observable
final class JoinStore {
  var model: JoinModel = JoinModel()

  @ObservationIgnored let api: AuthApi

  init(api: AuthApi = AuthApiImpl()) {
    self.api = api
  }

  func join() async throws -> JoinResponseModel {
    let req = JoinApiRequest(model: JoinRequestModel(phoneNumber: model.phoneNumber))

    return try await api.join(req: req)
  }
}
