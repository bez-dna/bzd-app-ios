import SwiftUI

@Observable
final class UserModel {
  var isLoading: Loading = .init()
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  var user: GetUserResponseModel.User?
  var messages: MessagesStore = .init()

  struct Loading {
    var user: Bool = false
    var messages: Bool = false
  }

  struct MessagesStore {
    var messages: [UUID: GetUserMessagesResponseModel.Message] = [:]
    var messageIds: [UUID] = []

    func append(_ batchMessages: [GetUserMessagesResponseModel.Message]) -> Self {
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
