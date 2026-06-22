import Combine
import SwiftUI

@Observable
final class AppNav {
  var path: NavigationPath = .init()
}

extension UINavigationController {
  override open func viewDidLoad() {
    super.viewDidLoad()
    interactivePopGestureRecognizer?.delegate = nil
  }
}
