import SwiftUI

@Observable
final class MessageModel {
  var isLoading: Loading = .init()
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  var message: GetMessageResponseModel.Message?
  var messages: MessagesStore = .init()

  struct Loading {
    var message: Bool = false
    var messages: Bool = false
  }

  struct MessagesStore {
    var messages: [UUID: GetMessageMessagesResponseModel.Message] = [:]
    var messageIds: [UUID] = []

    func append(_ batchMessages: [GetMessageMessagesResponseModel.Message]) -> Self {
      var newMessages = messages
      var newMessageIds = messageIds

      for message in batchMessages {
        guard newMessages[message.messageId] == nil else { continue }

        newMessages[message.messageId] = message
        newMessageIds.append(message.messageId)
      }

      return Self(messages: newMessages, messageIds: newMessageIds)
    }
  }
}
