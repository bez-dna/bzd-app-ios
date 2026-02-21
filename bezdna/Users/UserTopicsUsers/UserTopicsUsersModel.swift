import SwiftUI

@Observable
final class UserTopicsUsersModel {
  var topics: [GetUserTopicsResponseModel.Topic] = .init()
  var topicsUsers: [GetUserTopicsResponseModel.TopicUser] = .init()
  var permissions: GetUserTopicsResponseModel.Permissions?
}
