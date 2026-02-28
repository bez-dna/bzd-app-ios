import SwiftUI

@Observable
final class UserModel {
  var isLoading: Loading = .init()
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false

  var user: GetUserResponseModel.User?
  var permissions: GetUserResponseModel.Permissions?
  var messages: MessageBubbleModel.MessagesStore = .init()

  var topics: [MessageBubbleModel.Topic] = []
  var messagesTopics: [MessageBubbleModel.MessageTopic] = []

  struct Loading {
    var user: Bool = false
    var messages: Bool = false
  }
}
