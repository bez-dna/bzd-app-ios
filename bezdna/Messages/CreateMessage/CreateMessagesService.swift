import SwiftUI

@Observable
final class CreateMessageService {
  var model: CreateMessageModel = .init()

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(with api: ApiClient) {
    self.api = MessagesApiImpl(api)
  }

  func save() async throws -> CreateMessageResponseModel {
    let req: CreateMessageRequest = .init(
      model: .init(text: model.text, code: model.code.uuidString),
    )

    let res = try await api.createMessage(req: req)

    model = .init()

    return res
  }
}
