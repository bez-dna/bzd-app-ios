import SwiftUI

struct UsersListHeaderView : View {
  private let onPress: () -> Void

  init(onPress: @escaping () -> Void) {
    self.onPress = onPress
  }

  var body: some View {
    HStack(spacing: 0) {
      UsersListHeaderMessagesView {
        onPress()
      }

      Spacer()
    }
  }
}


struct UsersListHeaderMessagesView: View {
  private let onPress: () -> Void

  init(onPress: @escaping () -> Void) {
    self.onPress = onPress
  }

  var body: some View {
    HStack(spacing: 0) {
      Button {
        onPress()
      } label: {
        HStack(spacing: AppSettings.Padding.y / 2) {
          Image(systemName: "chevron.left")
            .font(.system(size: AppSettings.Font.main, weight: .bold))
            .frame(height: AppSettings.Padding.y * 4)

          Text("BZD")
            .font(.system(size: AppSettings.Font.button, weight: .bold))
            .lineLimit(1)
        }
      }.buttonStyle(.plain)
        .padding(.horizontal, AppSettings.Padding.y)
        .frame(height: AppSettings.Padding.y * 4)
      Spacer()
    }
  }
}
