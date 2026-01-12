import Combine
import SwiftUI

@Observable
final class AppState {
  let model: AppModel = AppModel()
  let authService: AuthService
  let nav: AppNav = AppNav()
  let api: ApiClient

  // Не очень нравится этот класс после того как сюда приехал ApiClient,
  // но пока не придумал как сделать более канонично, скорее всего текущее решение не самое лучшее

  init() {
    let api = ApiClient(with: self.model)
    let authService = AuthService(self.model, api)

    self.api = api
    self.authService = authService
  }

  func isAuth () -> Bool {
    return model.user != nil
  }
}
