import SwiftUI

struct MessagesListView: View {
  private var state: AppState
  private let service: MessagesListService

  @State
  private var model: MessagesListModel

  @Bindable
  private var nav: AppNav

  init(_ state: AppState) {
    let model = MessagesListModel()

    self.state = state
    nav = state.nav
    service = MessagesListService(state.api, model)
    self.model = model
  }

  var body: some View {
    VStack {
      if state.isAuth() {
        List(model.messages, id: \.messageId) { message in
          Button(message.text) {
            nav.main.append(MainRoute.message(messageId: message.messageId))
          }
        }
      } else {
        Button("AUTH PLEASE") {
          nav.flow = .auth
        }
      }

    }.task {
      do {
        try await service.load()
      } catch {
        print(error)
      }
    }
  }
}

#Preview {
  MessagesListView(AppState())
}
