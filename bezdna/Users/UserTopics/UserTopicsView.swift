import SwiftUI

struct UserTopicsView : View {
  var body: some View {
    VStack {
      Text("TOPICS USERS")
    }
    .frame(maxWidth: .infinity)
    .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
    .padding(.horizontal, AppSettings.Padding.x)
    .padding(.bottom, AppSettings.Padding.y * 2)
  }
}

