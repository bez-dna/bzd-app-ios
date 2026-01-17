import SwiftUI

@Observable
final class CompleteService {
  var model: CompleteModel = .init()

  @ObservationIgnored
  private let api: AuthApi

  init(_ api: ApiClient) {
    self.api = AuthApiImpl(api)
  }

  func complete(_ verificationId: UUID) async throws -> CompleteResponseModel {
    let req = CompleteApiRequest(
      model: CompleteRequestModel(
        verificationId: verificationId, code: model.code, name: model.name,
      ))

    return try await api.complete(req: req)
  }
}
