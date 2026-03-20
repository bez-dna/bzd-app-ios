import SwiftUI

struct UserHeaderView : View {
  private let permissions: GetUserResponseModel.Permissions?
  private let onBackPress: () -> Void
  private let onLogoutPress: () -> Void

  init(
    permissions: GetUserResponseModel.Permissions?,
    onBackPress: @escaping () -> Void,
    onLogoutPress: @escaping () -> Void
  ) {
    self.onBackPress = onBackPress
    self.onLogoutPress = onLogoutPress
    self.permissions = permissions
  }

  var body: some View {
    HStack(spacing: AppSettings.Padding.y) {
      Button {
        onBackPress()
      } label: {
        Image(systemName: "chevron.left")
          .font(.system(size: AppSettings.Font.main, weight: .bold))
      }.buttonStyle(.plain)
        .frame(
          width: AppSettings.Padding.y * 4,
          height: AppSettings.Padding.y * 4
        )

      Spacer()

      if let permissions = permissions {
        if permissions.logout {
          Button {
            onLogoutPress()
          } label: {
            Text(AppI18n.User.logout)
              .font(.system(size: AppSettings.Font.button, weight: .bold))
          }.buttonStyle(.plain)
            .padding(.horizontal, AppSettings.Padding.y)
            .frame(height: AppSettings.Padding.y * 4)
        }
      }
    }
  }
}
