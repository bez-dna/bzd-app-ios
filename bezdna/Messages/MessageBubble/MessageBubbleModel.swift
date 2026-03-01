import SwiftUI

@Observable
final class MessageBubbleModel {
  var message: Message
  var topics: [Topic]
  var messagesTopics: [MessageTopic]

  struct Message {
    let messageId: UUID
    let text: String
    let code: String
    let order: Int64
    let user: User
    let stream: Stream?
    let permissions: Permissions

    struct Stream {
      let streamId: UUID
      let messageId: UUID
      let text: String
      let messagesCount: Int64
      let users: [User]
    }

    struct User {
      let userId: UUID
      let name: String
      let abbr: String
      let color: String
    }

    struct Permissions {
      let message: Bool
      let topics: Bool
    }

    init(from m: GetMessageMessagesResponseModel.Message) {
      let u = m.user

      messageId = m.messageId
      text = m.text
      code = m.code
      order = m.order
      user = User(
        userId: u.userId,
        name: u.name,
        abbr: u.abbr,
        color: u.color,
      )
      stream = if let s = m.stream {
        Stream(
          streamId: s.streamId,
          messageId: s.messageId,
          text: s.text,
          messagesCount: s.messagesCount,
          users: s.users.map { u in
            User(
              userId: u.userId,
              name: u.name,
              abbr: u.abbr,
              color: u.color,
            )
          },
        )
      } else {
        nil
      }
      permissions = .init(
        message: m.permissions.message,
        topics: m.permissions.topics,
      )
    }

    init(from m: GetFeedMessagesResponseModel.Message) {
      let u = m.user

      messageId = m.messageId
      text = m.text
      code = m.code
      order = m.order
      user = User(
        userId: u.userId,
        name: u.name,
        abbr: u.abbr,
        color: u.color,
      )
      stream = if let s = m.stream {
        Stream(
          streamId: s.streamId,
          messageId: s.messageId,
          text: s.text,
          messagesCount: s.messagesCount,
          users: s.users.map { u in
            User(
              userId: u.userId,
              name: u.name,
              abbr: u.abbr,
              color: u.color,
            )
          },
        )
      } else {
        nil
      }
      permissions = .init(
        message: m.permissions.message,
        topics: m.permissions.topics,
      )
    }

    init(from m: GetMessageResponseModel.Message) {
      let u = m.user

      messageId = m.messageId
      text = m.text
      code = m.code
      order = m.order
      user = User(
        userId: u.userId,
        name: u.name,
        abbr: u.abbr,
        color: u.color,
      )
      stream = nil
      permissions = .init(
        message: m.permissions.message,
        topics: m.permissions.topics,
      )
    }

    init(from m: GetUserMessagesResponseModel.Message) {
      let u = m.user

      messageId = m.messageId
      text = m.text
      code = m.code
      order = m.order
      user = User(
        userId: u.userId,
        name: u.name,
        abbr: u.abbr,
        color: u.color,
      )
      stream = nil
      permissions = .init(
        message: m.permissions.message,
        topics: m.permissions.topics,
      )
    }
  }

  struct Topic {
    let topicId: UUID
    let title: String

    init(from t: GetMessageMessagesResponseModel.Topic) {
      topicId = t.topicId
      title = t.title
    }

    init(from t: GetUserMessagesResponseModel.Topic) {
      topicId = t.topicId
      title = t.title
    }

    init(from t: GetMessageResponseModel.Topic) {
      topicId = t.topicId
      title = t.title
    }

    init(from t: GetFeedMessagesResponseModel.Topic) {
      topicId = t.topicId
      title = t.title
    }
  }

  struct MessageTopic {
    let messageTopicId: UUID
    let topicId: UUID
    let messageId: UUID

    init(from mt: GetMessageMessagesResponseModel.MessageTopic) {
      messageTopicId = mt.messageTopicId
      topicId = mt.topicId
      messageId = mt.messageId
    }

    init(from mt: GetFeedMessagesResponseModel.MessageTopic) {
      messageTopicId = mt.messageTopicId
      topicId = mt.topicId
      messageId = mt.messageId
    }

    init(from mt: GetMessageResponseModel.MessageTopic) {
      messageTopicId = mt.messageTopicId
      topicId = mt.topicId
      messageId = mt.messageId
    }
  }

  struct MessagesStore {
    var messages: [UUID: Message] = [:]
    var messageIds: [UUID] = []

    func append(_ batchMessages: [Message]) -> Self {
      var newMessages = messages
      var newMessageIds = messageIds

      for message in batchMessages {
        guard newMessages[message.messageId] == nil else { continue }

        // всегда сразу добавляем новый элемент
        newMessages[message.messageId] = message

        guard let lastMessageId = newMessageIds.last,
              let lastMessage = newMessages[lastMessageId]
        else {
          newMessageIds.append(message.messageId)
          continue
        }

        if message.order >= lastMessage.order {
          newMessageIds.append(message.messageId)
          continue
        }

        guard let firstMessageId = newMessageIds.first,
              let firstMessage = newMessages[firstMessageId]
        else {
          newMessageIds.append(message.messageId)
          continue
        }

        if message.order <= firstMessage.order {
          newMessageIds.insert(message.messageId, at: 0)
          continue
        }

        var index = newMessageIds.count - 1
        while index >= 0 {
          let currentMessageId = newMessageIds[index]
          if let currentMessage = newMessages[currentMessageId], currentMessage.order <= message.order {
            break
          }
          index -= 1
        }

        newMessageIds.insert(message.messageId, at: index + 1)
      }

      return Self(messages: newMessages, messageIds: newMessageIds)
    }
  }

  var hasMessageTopic: Bool {
    messagesTopics.contains { messageTopic in
      messageTopic.messageId == message.messageId
    }
  }

  init(message: Message, topics: [Topic], messagesTopics: [MessageTopic]) {
    self.message = message
    self.topics = topics
    self.messagesTopics = messagesTopics
  }
}
