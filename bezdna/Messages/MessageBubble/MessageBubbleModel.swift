import SwiftUI

struct MessageBubbleModel {
  let messageId: UUID
  let text: String
  let user: User
  let stream: Stream?

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

  init(m: GetMessageMessagesResponseModel.Message) {
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
  }

  init(m: GetUserMessagesResponseModel.Message) {
    messageId = m.messageId
    text = m.text
    user = User(
      userId: m.user.userId,
      name: m.user.name,
      abbr: m.user.abbr,
      color: m.user.color,
    )
    stream = nil
  }
}
