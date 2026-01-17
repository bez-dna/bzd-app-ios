import SwiftUI

@Observable
final class MessagesListModel {
  var messages: [GetUserMessagesResponseModel.Message] = []
  var cursorMessageId: UUID?
  var lastCursorMessageId: Bool = false
}

// Тут и в аналогичных местах нужно убрать модель сетевых респонзов
// Сделать или маппер или юзать в клиентах модели отсюда
