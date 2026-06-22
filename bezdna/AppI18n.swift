import SwiftUI

typealias L10nKey = LocalizedStringKey

enum AppI18n {
  static let error: L10nKey = "error"

  enum Auth {
    enum Join {
      static let phone: L10nKey = "auth.join.phone"
      static let code: L10nKey = "auth.join.code"
      static let button: L10nKey = "auth.join.button"
      static let complete: L10nKey = "auth.join.complete"
      static let error: L10nKey = "error"
    }
  }

  enum Messages {
    enum List {
      static let empty: L10nKey = "messages.list.empty"
      static let contacts: L10nKey = "messages.list.contacts"
    }

    enum Auth {
      static let title: L10nKey = "messages.auth.title"
      static let desc: L10nKey = "messages.auth.desc"
      static let button: L10nKey = "messages.auth.button"
    }
  }

  enum Message {
    enum Bubble {
      static let topics: L10nKey = "message.bubble.topics"
      static let like: L10nKey = "message.bubble.like"
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

    enum Edit {
      static let title: L10nKey = "user.edit.title"
      static let name: L10nKey = "user.edit.name"
      static let cancel: L10nKey = "user.edit.cancel"
      static let save: L10nKey = "user.edit.save"
    }

    static let logout: L10nKey = "user.logout"
    static let edit: L10nKey = "user.edit"
  }

  enum Users {
    enum Contacts {
      static let empty: L10nKey = "users.contacts.empty"
      static let new: L10nKey = "users.contacts.new"
      static let button: L10nKey = "users.contacts.button"
      static let denied: L10nKey = "users.contacts.denied"
//      static let new = String(localized: "users.contacts.new")
//      static let button = String(localized: "users.contacts.button")
//      static let denied = String(localized: "users.contacts.denied")
    }

    enum List {
      ///      static let empty = String(localized: "users.list.empty")
      static let me: L10nKey = "users.list.me"
    }
  }

  enum Topics {
    enum Create {
      static let placeholder: L10nKey = "topics.create.placeholder"
      static let button: L10nKey = "topics.create.button"
    }
  }
}
