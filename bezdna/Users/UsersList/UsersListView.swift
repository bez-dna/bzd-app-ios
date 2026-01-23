import SwiftUI

struct UsersListView : View {
  private var state: AppState

  init(state: AppState) {
    self.state = state
  }

  var body: some View {
    UsersContactsView(state: state)
  }
  
}

#Preview {
  UsersListView(state: AppState())
}
