import Combine
import SwiftUI

@Observable
final class AppNav {
  var flow: AppFlow = .main
  var main: NavigationPath = .init()
}
