import SwiftUI

struct UsersContactsView: View {
  @State
  private var service: UsersContactsService

  init(state: AppState) {
    service = .init(api: state.api)
  }

  var body: some View {
    let status = service.model.status

    if status == .new {
      UsersContactsNewView(service: service)
    } else if status == .denied {
      UsersContactsDeniedView()
    }
  }
}

struct UsersContactsNewView: View {
  let service: UsersContactsService

  var body: some View {
    Text(AppI18n.Users.Contacts.new)
      .multilineTextAlignment(.center)
      .padding(.top, AppSettings.Padding.y * 4)
      .padding(.bottom, AppSettings.Padding.y * 2)
      .padding(.horizontal, AppSettings.Padding.x * 2)

    Button {
      Task {
        do {
          try await service.sync()
        } catch {
          print(error)
        }
      }
    } label: {
      Text(AppI18n.Users.Contacts.button)
        .colorInvert()
        .font(.system(size: AppSettings.Font.button, weight: .bold))
        .frame(height: 30)
    }
    .buttonStyle(.plain)
    .padding(.horizontal, AppSettings.Padding.x)
    .background(.submit)
    .clipShape(RoundedRectangle(cornerRadius: 15))
  }
}

struct UsersContactsDeniedView: View {
  var body: some View {
    Text(AppI18n.Users.Contacts.denied)
      .multilineTextAlignment(.center)
      .padding(.top, AppSettings.Padding.y * 4)
      .padding(.bottom, AppSettings.Padding.y * 2)
      .padding(.horizontal, AppSettings.Padding.x * 2)
  }
}
