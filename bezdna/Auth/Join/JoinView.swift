import SwiftUI

struct JoinView: View {
  enum Focus {
    case phone
    case code
  }

  private let authService: AuthService
  let onComplete: () -> Void

  @State
  private var service: JoinService

  @FocusState
  var focused: Focus?

  init(api: ApiClient, authService: AuthService, onComplete: @escaping () -> Void) {
    self.authService = authService
    service = .init(api: api)
    self.onComplete = onComplete
  }

  var body: some View {
    @Bindable
    var model = service.model

    // TODO: после ошибок нужно возвращать курсов в инпут, сейчас он теряется

    VStack(spacing: 0) {
      TextField(AppI18n.Auth.Join.phone, text: $model.phone)
        .keyboardType(.phonePad)
        .frame(height: AppSettings.Padding.y * 6)
        .focused($focused, equals: .phone)
        .padding(.horizontal, AppSettings.Padding.x)
        .background(.input, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 3))
        .foregroundStyle(model.isComplete ? .gray : .primary)
        .padding(.bottom, AppSettings.Padding.y * 2)
        .disabled(model.isComplete || model.isProcessing)

      if !model.isComplete {
        Button {
          guard !model.isProcessing else { return }

          model.isProcessing = true

          Task {
            defer { model.isProcessing = false }

            do {
              try await service.join()
            } catch {
              model.error = AppError(error: AppI18n.Auth.Join.error)
            }
          }
        } label: {
          HStack(spacing: AppSettings.Padding.y) {
            Text(AppI18n.Auth.Join.button)
              .colorInvert()
              .font(.system(size: AppSettings.Font.button, weight: .bold))
              .frame(height: AppSettings.Padding.y * 5)

            if model.isProcessing {
              ProgressView().colorInvert()
            }
          }
        }.alert(item: $model.error) { error in
          Alert(title: Text(error.error))
        }.buttonStyle(.plain)
          .padding(.horizontal, AppSettings.Padding.x)
          .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2.5))
          .disabled(model.isProcessing)
      } else if let verificationId = model.verificationId {
        TextField(AppI18n.Auth.Join.code, text: $model.code)
          .keyboardType(.numberPad)
          .textContentType(.oneTimeCode)
          .frame(height: AppSettings.Padding.y * 6)
          .focused($focused, equals: .code)
          .padding(.horizontal, AppSettings.Padding.x)
          .background(.input, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 3))
          .padding(.bottom, AppSettings.Padding.y * 2)
          .disabled(model.isProcessing)
          .onAppear {
            focused = .code
          }

        Button {
          guard !model.isProcessing else { return }

          model.isProcessing = true

          Task {
            defer { model.isProcessing = false }

            do {
              let res = try await service.complete(verificationId: verificationId)
              try await authService.updateToken(res.jwt)

              onComplete()
            } catch {
              model.error = AppError(error: AppI18n.Auth.Join.error)
            }
          }
        } label: {
          HStack(spacing: AppSettings.Padding.y) {
            Text(AppI18n.Auth.Join.complete)
              .colorInvert()
              .font(.system(size: AppSettings.Font.button, weight: .bold))
              .frame(height: AppSettings.Padding.y * 5)

            if model.isProcessing {
              ProgressView().colorInvert()
            }
          }
        }.alert(item: $model.error) { error in
          Alert(title: Text(error.error))
        }.buttonStyle(.plain)
          .padding(.horizontal, AppSettings.Padding.x)
          .background(.submit, in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2.5))
          .disabled(model.isProcessing)
      }
    }
    .padding(.horizontal, AppSettings.Padding.x * 2)
    .onAppear {
      focused = .phone
    }
  }
}

#Preview {
  let state = AppState()

  JoinView(
    api: AppState().api,
    authService: state.authService,
    onComplete: {},
  )
}

#Preview("JoinView RU") {
  let state = AppState()

  JoinView(
    api: AppState().api,
    authService: state.authService,
    onComplete: {},
  ).environment(\.locale, .init(identifier: "ru"))
}
