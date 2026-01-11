import Foundation

enum AuthFlow {
  case join
  case complete(UUID)
}
