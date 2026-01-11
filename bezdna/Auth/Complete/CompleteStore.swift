import SwiftUI

@Observable
final class CompleteStore {
  var model: CompleteModel = CompleteModel()

  @ObservationIgnored let api: AuthApi

  init(api: AuthApi = AuthApiImpl()) {
    self.api = api
  }

  func complete(_ verificationId: UUID) async throws -> CompleteResponseModel {
    let req = CompleteApiRequest(
      model: CompleteRequestModel(verificationId: verificationId, code: model.code, name: model.name))

    return try await api.complete(req: req)
  }
}
