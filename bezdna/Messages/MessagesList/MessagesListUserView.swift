import SwiftUI

struct MessagesListUserView: View {
  private let user: AppModel.User
  private let onPress: () -> Void

  init(user: AppModel.User, onPress: @escaping () -> Void) {
    self.user = user
    self.onPress = onPress
  }

  var body: some View {
    HStack {
      Spacer()

      Button {
        onPress()
      } label: {
        Image(systemName: "person.2.circle.fill")
          .font(.system(size: 40))
      }.buttonStyle(.plain)
    }
  }
}
