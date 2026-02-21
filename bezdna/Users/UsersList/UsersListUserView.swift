import SwiftUI

struct UsersListUserView: View {
  private let user: AppModel.User
  private let onPress: (_ userId: UUID) -> Void

  init(user: AppModel.User, onPress: @escaping (_ userId: UUID) -> Void) {
    self.user = user
    self.onPress = onPress
  }

  var body: some View {
    Button {
      onPress(user.userId)
    } label: {
      HStack {
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(25)
          Text(user.abbr).font(.system(size: AppSettings.Font.s, weight: .bold))
        }.frame(width: 50, height: 50)

        VStack(alignment: .leading) {
          Text(user.name).lineLimit(1).font(.system(size: AppSettings.Font.main, weight: .bold))

          Text(AppI18n.Users.List.me)
            .lineLimit(1)
            .font(.system(size: AppSettings.Font.s))
            .foregroundStyle(.secondary)
        }

        Spacer()
      }
    }.buttonStyle(.plain)
  }
}

// Button {
//  onLogout()
// } label: {
//  Text(AppI18n.Users.List.logout)
//    .colorInvert()
//    .font(.system(size: AppSettings.Font.button, weight: .bold))
//    .frame(height: 30)
// }
// .buttonStyle(.plain)
// .padding(.horizontal, AppSettings.Padding.x)
// .background(.submit)
// .clipShape(RoundedRectangle(cornerRadius: 15))
