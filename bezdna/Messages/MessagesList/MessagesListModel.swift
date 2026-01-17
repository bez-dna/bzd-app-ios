import SwiftUI

@Observable
final class MessagesListModel {
  var messages: [GetUserMessagesResponseModel.Message] = []
}
