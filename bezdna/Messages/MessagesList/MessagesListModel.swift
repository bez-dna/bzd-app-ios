import SwiftUI

@Observable
final class MessagesListModel {
  var isInit: Bool = false
  var isLoading: Bool = false
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  var messages: MessageBubbleModel.MessagesStore = .init()

  var topics: [MessageBubbleModel.Topic] = []
  var messagesTopics: [MessageBubbleModel.MessageTopic] = []
}
