import SwiftUI

@Observable
final class UserEditModel {
  var name: String

  init(u: GetUserResponseModel.User) {
    name = u.name
  }
}
