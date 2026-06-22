import SwiftUI

struct UsersListBubbleView: View {
  private let user: GetUsersResponseModel.User
  private let onPress: (_ userId: UUID) -> Void

  init(_ user: GetUsersResponseModel.User, _ onPress: @escaping (_ userId: UUID) -> Void) {
    self.user = user
    self.onPress = onPress
  }

  var body: some View {
    Button {
      onPress(user.userId)
    } label: {
      HStack(spacing: AppSettings.Padding.y) {
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(20)
          Text(user.abbr).font(.system(size: 14, weight: .bold))
        }.frame(width: 40, height: 40)

        Text(user.name).lineLimit(1).font(.system(size: 16, weight: .medium))

        Spacer()
      }
    }.buttonStyle(.plain)
  }
}
