import SwiftUI

@Observable
final class UsersListModel {
  var isInit: Bool = false
  var isLoading: Bool = false
  var users: [GetUsersResponseModel.User] = []
}
