import SwiftUI

@Observable
final class MessagesListModel {
  var isInit: Bool = false
  var isLoading: Bool = false
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false
  var messages: MessagesStore = .init()

  var messagesList: [GetUserMessagesResponseModel.Message] {
    messages.messageIds.compactMap { messageId in
      messages.messages[messageId]
    }
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

// Тут и в аналогичных местах нужно убрать модель сетевых респонзов
// Сделать или маппер или юзать в клиентах модели отсюда
