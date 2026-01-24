import SwiftUI

@Observable
final class MessagesListModel {
  var isInit: Bool = false
  var isLoading: Bool = false
  var messages: [GetUserMessagesResponseModel.Message] = []
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false
}

// Тут и в аналогичных местах нужно убрать модель сетевых респонзов
// Сделать или маппер или юзать в клиентах модели отсюда
