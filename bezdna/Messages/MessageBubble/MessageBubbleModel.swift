import SwiftUI

@Observable
final class MessageBubbleModel {
  let messageId: UUID
  let text: String
  let user: User
  let stream: Stream?
  let topics: [Topic]
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

  struct Topic {
    let topicId: UUID
    let title: String
  }

  struct Permissions {
    let topics: Bool
  }

  init(
    m: GetMessageMessagesResponseModel.Message,
    t: [GetMessageMessagesResponseModel.Topic]
  ) {
    messageId = m.messageId
    text = m.text
    user = User(
      userId: m.user.userId,
      name: m.user.name,
      abbr: m.user.abbr,
      color: m.user.color,
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
    permissions = .init(topics: m.permissions.topics)
    topics = t.map { topic in
        .init(topicId: topic.topicId, title: topic.title)
    }
  }

  init(
    m: GetUserMessagesResponseModel.Message,
    t: [GetUserMessagesResponseModel.Topic]
  ) {
    messageId = m.messageId
    text = m.text
    user = User(
      userId: m.user.userId,
      name: m.user.name,
      abbr: m.user.abbr,
      color: m.user.color,
    )
    stream = nil
    permissions = .init(topics: false)
    topics = []
  }
}
