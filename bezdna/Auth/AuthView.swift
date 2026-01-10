import SwiftUI

struct AuthView: View {
  @State private var store = AuthStore.shared

  var body: some View {
    JoinView()
  }
}

#Preview {
  AuthView().environment(AppState())
}
