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
      } label: {
        Image(systemName: "person.2.circle.fill")
          .font(.system(size: 40))
      }.buttonStyle(.plain)
    }
  }
}
