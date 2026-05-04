import SwiftUI

struct UsersContactsView: View {
  let onComplete: () -> Void

  @State
  private var service: UsersContactsService

  init(api: ApiClient, onComplete: @escaping () -> Void) {
    service = .init(api: api)
    self.onComplete = onComplete
  }

  var body: some View {
    @Bindable
    var model = service.model

    Group {
      switch model.status {
      case .new:
        UsersContactsNewView(service: service) {
          onComplete()
        }
      case .denied:
        UsersContactsDeniedView()
      case .authorized:
        UsersContactsEmptyView().task {
          await Task.detached(priority: .userInitiated) {
            await service.sync()
          }.value
        }
      }
    }
    .padding(.horizontal, AppSettings.Padding.x * 2)
    .padding(.top, AppSettings.Padding.y * 4)
    .padding(.bottom, AppSettings.Padding.y * 2)
  }
}

struct UsersContactsNewView: View {
  let onComplete: () -> Void
  let service: UsersContactsService

  init(service: UsersContactsService, onComplete: @escaping () -> Void) {
    self.service = service
    self.onComplete = onComplete
  }

  var body: some View {
    @Bindable
    var model = service.model

    VStack(spacing: AppSettings.Padding.y * 2) {
      Text(AppI18n.Users.Contacts.new)
        .font(.system(size: AppSettings.Font.main))
        .multilineTextAlignment(.center)

      Button {
        Task {
          await service.create()

          onComplete()
        }
      } label: {
        Text(AppI18n.Users.Contacts.button)
          .colorInvert()
          .font(.system(size: AppSettings.Font.button, weight: .bold))
          .frame(height: AppSettings.Padding.y * 5)
      }.alert(item: $model.error) { error in
        Alert(title: Text(error.error))
      }.buttonStyle(.plain)
        .padding(.horizontal, AppSettings.Padding.x)
        .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2.5))
    }
  }
}

struct UsersContactsEmptyView: View {
  var body: some View {
    Text(AppI18n.Users.Contacts.empty)
      .font(.system(size: AppSettings.Font.main))
      .multilineTextAlignment(.center)
  }
}

struct UsersContactsDeniedView: View {
  @Environment(\.openURL) var openURL

  var body: some View {
    VStack(spacing: AppSettings.Padding.y * 2) {
      Text(AppI18n.Users.Contacts.denied)
        .font(.system(size: AppSettings.Font.main))
        .multilineTextAlignment(.center)

      Button {
        if let url = URL(string: UIApplication.openSettingsURLString) {
          openURL(url)
        }
      } label: {
        Text(AppI18n.Users.Contacts.button)
          .colorInvert()
          .font(.system(size: AppSettings.Font.button, weight: .bold))
          .frame(height: AppSettings.Padding.y * 5)
      }
      .buttonStyle(.plain)
      .padding(.horizontal, AppSettings.Padding.x)
      .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2.5))
    }
  }
}
