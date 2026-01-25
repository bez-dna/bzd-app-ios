import SwiftUI

@Observable
final class MessageModel {
  var messages: [GetMessageMessagesResponseModel.Message] = []
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false
}
