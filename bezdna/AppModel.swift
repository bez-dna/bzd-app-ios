import SwiftUI

@Observable
final class AppModel {
  var token: String?
  var user: User?

  struct User: Codable {
    let userId: UUID
    let name: String
    let abbr: String
    let color: String
  }
}
