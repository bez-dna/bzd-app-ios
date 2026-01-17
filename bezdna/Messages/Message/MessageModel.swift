import SwiftUI

@Observable
final class MessageModel {
  let messageId: UUID
  var messages: [GetMessageMessagesResponseModel.Message] = []
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  init(_ messageId: UUID) {
    self.messageId = messageId
  }
}
