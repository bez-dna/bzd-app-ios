import SwiftUI

@Observable
final class MessageTopicsModel {
  var topics: [GetMessageTopicsResponseModel.Topic] = .init()
  var messagesTopics: [GetMessageTopicsResponseModel.MessageTopic] = .init()
}
