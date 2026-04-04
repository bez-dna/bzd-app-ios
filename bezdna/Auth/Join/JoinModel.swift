import SwiftUI

@Observable
class JoinModel {
  var phone: String = ""
  var verificationId: UUID?
  var code: String = ""
  var name: String = UIDevice.current.name
  var isProcessing: Bool = false
  var error: AppError?

  var isComplete: Bool {
    verificationId != nil
  }
}
