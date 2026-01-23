import SwiftUI

struct UsersContactsView : View {
  @State
  private var service: UsersContactsService

  init(state: AppState) {
    service = .init(api: state.api)
  }


  var body: some View {
    Group {
      Text("CONTACTS")

      Button("QQQ") {
        Task {
          do {
            try await service.sync()
          } catch {
            print(error)
          }
        }
      }
    }
  }
}
