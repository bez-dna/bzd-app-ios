import SwiftUI

@Observable
final class UsersListModel {
  var isLoading: Bool = false
  var users: [GetUsersResponseModel.User] = []
}
