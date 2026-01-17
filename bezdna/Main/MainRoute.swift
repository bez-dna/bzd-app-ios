import SwiftUI

enum MainRoute: Hashable {
  case message(messageId: UUID)
  case users
  case user(userId: UUID)
}
