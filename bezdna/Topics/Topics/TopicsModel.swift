import SwiftUI

@Observable
final class TopicsModel {
  typealias Topic = GetTopicsResponseModel.Topic
  typealias Emoji = GetTopicsResponseModel.Emoji
  typealias Permissions = GetTopicsResponseModel.Permissions

  var topics: [Topic] = .init()
  var emojis: [Emoji] = .init()
  var permissions: Permissions?
}
