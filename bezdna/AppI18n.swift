import Foundation

enum AppI18n {
  enum Messages {
    enum List {
      static let empty = String(localized: "messages.list.empty")
      static let contacts = String(localized: "messages.list.contacts")
    }
  }

  enum Users {
    enum Contacts {
      static let new = String(localized: "users.contacts.new")
      static let button = String(localized: "users.contacts.button")
      static let denied = String(localized: "users.contacts.denied")
    }
  }
}
