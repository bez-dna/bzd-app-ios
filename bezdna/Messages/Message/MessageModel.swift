import SwiftUI

@Observable
final class MessageModel {
  var isLoading: Loading = .init()
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  var message: MessageBubbleModel.Message?
  var messages: MessageBubbleModel.MessagesStore = .init()

  var topics: [MessageBubbleModel.Topic] = []
  var messagesTopics: [MessageBubbleModel.MessageTopic] = []

  struct Loading {
    var message: Bool = false
    var messages: Bool = false
  }
}
