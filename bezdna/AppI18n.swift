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
      static let reply: String = String(localized: "message.bubble.reply")
      static func replies(_ count: Int64) -> String {
        String(
          format: String(localized: "message.bubble.replies"),
          count
        )
      }
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
}
