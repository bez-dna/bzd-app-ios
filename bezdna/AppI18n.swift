import SwiftUI

typealias L10nKey = LocalizedStringKey

enum AppI18n {
  enum Messages {
    enum List {
      static let empty = String(localized: "messages.list.empty")
      static let contacts = String(localized: "messages.list.contacts")
    }
  }

  enum Message {
    enum Bubble {
      static let topics: L10nKey = "message.bubble.topics"
      static let reply: String = .init(localized: "message.bubble.reply")
      static func replies(_ count: Int64) -> String {
        String(
          format: String(localized: "message.bubble.replies"),
          count,
        )
      }
    }

    enum Topics {
      static let create: L10nKey = "message.topics.create"
      static let delete: L10nKey = "message.topics.delete"
    }
  }

  enum User {
    enum Topics {
      static let title: L10nKey = "user.topics.title"
      static let button: L10nKey = "user.topics.button"
      static let desc: L10nKey = "user.topics.desc"
      static let segments: L10nKey = "user.topics.segments"
    }
  }

  enum Users {
    enum Contacts {
      static let new = String(localized: "users.contacts.new")
      static let button = String(localized: "users.contacts.button")
      static let denied = String(localized: "users.contacts.denied")
    }

    enum List {
      static let empty = String(localized: "users.list.empty")
      static let me = String(localized: "users.list.me")
      static let logout = String(localized: "users.list.logout")
    }
  }

  enum Topics {
    enum Create {
      static let placeholder: L10nKey = "topics.create.placeholder"
      static let button: L10nKey = "topics.create.button"
    }
  }
}
