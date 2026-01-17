import SwiftUI

struct UserView: View {
  private let userId: UUID

  init(_ userId: UUID) {
    self.userId = userId
  }

  var body: some View {
    VStack {
      Text("USER \(userId)")
    }
  }
}

#Preview {
  UserView(UUID())
}
