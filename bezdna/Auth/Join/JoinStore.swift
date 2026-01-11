import SwiftUI

@Observable
final class JoinStore {
  var phoneNumber: String = "79991112233"
  @ObservationIgnored let api: AuthApi

  init(api: AuthApi = AuthApiImpl()) {
    self.api = api
  }

  func join() async throws {
    let req = JoinApiRequest(model: JoinRequestModel(phoneNumber: self.phoneNumber))

    let res = try await api.join(req: req)

    print(res.verification.verificationId)
  }
}
