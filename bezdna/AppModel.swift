
import SwiftUI

@Observable
class AppModel {
  var token: String? = nil
  var user: User? = nil

  struct User: Codable {
    let userId: UUID
    let name: String
    let abbr: String
    let color: String
  }
}
