import SwiftUI

// Это все нужно переписать, начиная с UI, пока сделано чтобы можно было имя сменить

struct UserEditView: View {
  @Environment(\.dismiss)
  private var dismiss

  @Environment(AppState.self)
  private var state

  @State
  private var service: UserEditService

  private let onSave: () -> Void

  init(api: ApiClient, user: GetUserResponseModel.User, onSave: @escaping () -> Void) {
    let service: UserEditService = .init(api: api, user: user)

    self.service = service
    self.onSave = onSave
  }

  var body: some View {
    @Bindable
    var model = service.model

    Form {
      TextField(AppI18n.User.Edit.name, text: $model.name)
    }.navigationTitle(AppI18n.User.Edit.title)
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button(AppI18n.User.Edit.cancel) {
            dismiss()
          }
        }
        ToolbarItem(placement: .confirmationAction) {
          Button(AppI18n.User.Edit.save) {
            Task {
              try await service.save()

              onSave()
              dismiss()
            }
          }
        }
      }
  }
}

// #Preview {
//  let state = AppState()
//  let user: GetUserResponseModel.User = .init(
//    userId: UUID(),
//    name: "John Doe",
//    abbr: "JD",
//    color: "#ff0000aa"
//  )
//
//  UserEditView(
//    api: state.api,
//    user: user
//    onSave: <#T##() -> Void#>
//  ).environment(state)
// }
