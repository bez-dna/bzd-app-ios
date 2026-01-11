import Combine
import SwiftUI

@Observable
final class AppState {
  @ObservationIgnored let nav: AppNav = AppNav()
  @ObservationIgnored let auth: AuthStore = AuthStore()

  var isAuth: Bool = false
}
