import SwiftUI

@Observable
final class JoinService {
  var model: JoinModel = .init()

  @ObservationIgnored
  private let api: AuthApi

  init(api: ApiClient) {
    self.api = AuthApiImpl(api)
  }

  func join() async throws {
    let res = try await api.join(req: .init(model: .init(phone: model.phone)))

    model.verificationId = res.verification.verificationId
  }

  func complete(verificationId: UUID) async throws -> CompleteResponseModel {
    try await api.complete(req: .init(model: .init(verificationId: verificationId, code: model.code, name: model.name)))
  }
}
