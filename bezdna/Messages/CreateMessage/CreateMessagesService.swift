import SwiftUI

@Observable
final class CreateMessageService {
  var model: CreateMessageModel = .init()

  @ObservationIgnored
  private let messageId: UUID?

  @ObservationIgnored
  private let api: MessagesApiImpl

  init(api: ApiClient, messageId: UUID?) {
    self.api = MessagesApiImpl(api)
    self.messageId = messageId
  }

  func save() async throws -> CreateMessageResponseModel {
    let req: CreateMessageRequest = .init(
      model: .init(text: model.text, code: model.code.uuidString, messageId: messageId),
    )

    let res = try await api.createMessage(req: req)

    model = .init()

    return res
  }
}
