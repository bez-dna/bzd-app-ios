import SwiftUI

struct UserUserView: View {
  @Environment(AppState.self)
  private var state

  private let user: GetUserResponseModel.User

  init(
    user: GetUserResponseModel.User,
  ) {
    self.user = user
  }

  var body: some View {
    VStack(spacing: 0) {
      ZStack {
        Rectangle().fill(Color(hex: user.color)).cornerRadius(30)
        Text(user.abbr).font(.system(size: AppSettings.Font.main, weight: .bold))
      }.frame(width: 60, height: 60)

      HStack(alignment: .top) {
        // Не уверен что два Spacer() по краям это тру путь, надо перепроверить
        Spacer()

        Text(user.name).lineLimit(2)
          .font(.system(size: AppSettings.Font.middle, weight: .bold))
          .multilineTextAlignment(.center)

        Spacer()
      }
    }
  }
}
