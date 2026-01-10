import Combine
import SwiftUI

@Observable
final class AppState {
  @ObservationIgnored let nav: AppNav = AppNav()

  var isAuth: Bool = false
}
