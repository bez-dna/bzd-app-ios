import SwiftUI

@Observable
final class UserEditModel {
  var name: String

  init(u: GetUserResponseModel.User) {
    self.name = u.name
  }
}
