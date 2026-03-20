import SwiftUI

struct MessagesListUserView: View {
  private let user: AppModel.User
  private let onPress: () -> Void

  init(user: AppModel.User, onPress: @escaping () -> Void) {
    self.user = user
    self.onPress = onPress
  }

  var body: some View {
    HStack(spacing: 0) {
      Spacer()

      Button {
        onPress()
      } label: {
        HStack(spacing: 0) {
          Image(systemName: "person.fill")
            .font(.system(size: AppSettings.Padding.y * 2))
            .colorInvert()
            .frame(height: AppSettings.Padding.y * 4)

          Text(user.name).colorInvert().font(.system(size: AppSettings.Font.button, weight: .bold))
            .lineLimit(1)
            .frame(maxWidth: 120)
        }
      }.buttonStyle(.plain)
        .padding(.leading, AppSettings.Padding.y)
        .padding(.trailing, AppSettings.Padding.x)
        .frame(height: AppSettings.Padding.y * 4)
        .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2))
    }
  }
}
