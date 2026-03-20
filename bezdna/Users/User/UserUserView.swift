import SwiftUI

struct UserUserView : View {
  @State
  private var showEdit: Bool = false

  @Environment(AppState.self)
  private var state

  private let user: GetUserResponseModel.User
  private let permissions: GetUserResponseModel.Permissions
  private let onUpdate: () -> Void

  init(
    user: GetUserResponseModel.User,
    permissions: GetUserResponseModel.Permissions,
    onUpdate: @escaping () -> Void
  ) {
    self.user = user
    self.permissions = permissions
    self.onUpdate = onUpdate
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


          if permissions.edit {
            Button {
              showEdit.toggle()
            } label: {
              Image(systemName: "ellipsis.circle")
                .font(.system(size: AppSettings.Font.middle))
            }.buttonStyle(.plain)
              .foregroundStyle(.secondary)
              .frame(
                width: AppSettings.Padding.y * 4,
                height: AppSettings.Padding.y * 4
              )
              .sheet(isPresented: $showEdit) {
                NavigationStack {
                  UserEditView(api: state.api, user: user){
                    onUpdate()
                  }.presentationDetents([.medium])
                }
              }
          }

        Spacer()
      }
    }
  }
}

