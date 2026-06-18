import SwiftUI

@Observable
final class MessagesListModel {
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  var messages: MessageBubbleModel.MessagesStore = .init()

  var topics: [MessageBubbleModel.Topic] = []
  var messagesTopics: [MessageBubbleModel.MessageTopic] = []

  var isEmpty: Bool {
    messages.messages.isEmpty && lastCursorMessageId
  }
}
