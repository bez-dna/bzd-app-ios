import SwiftUI

struct MessagesListUser: View {
  private let user: AppModel.User
  private let onClick: () -> Void

  init(user: AppModel.User, onClick: @escaping () -> Void) {
    self.user = user
    self.onClick = onClick
  }

  var body: some View {
    HStack {
      Spacer()

      Button {
        onClick()
      } label: { ZStack {
        Rectangle().fill(.gray).cornerRadius(20)
        Text(user.abbr)
      }.frame(width: 40, height: 40)
      }
    }
  }
}
