import SwiftUI

@Observable
final class JoinService {
  var model: JoinModel = JoinModel()

  @ObservationIgnored
  private let api: AuthApi

  init(_ api: ApiClient) {
    self.api = AuthApiImpl(api)
  }

  func join() async throws -> JoinResponseModel {
    let req = JoinApiRequest(model: JoinRequestModel(phoneNumber: model.phoneNumber))

    return try await api.join(req: req)
  }
}
