import SwiftUI

@Observable
final class CreateMessageModel {
  var text: String = ""
  var code: UUID = .init()
  var isSaving: Bool = false
}
