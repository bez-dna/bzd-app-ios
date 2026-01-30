import SwiftUI

struct JoinView: View {
  let onComplete: (UUID) -> Void

  @State
  private var service: JoinService

  init(api: ApiClient, onComplete: @escaping (UUID) -> Void) {
    let service = JoinService(api)

    self.service = service
    self.onComplete = onComplete
  }

  var body: some View {
    TextField("PHONE", text: $service.model.phoneNumber).keyboardType(.phonePad)

    Button("ENTER") {
      Task {
        let model = try await service.join()

        onComplete(model.verification.verificationId)
      }
    }
  }
}

//#Preview {
//  JoinView(AppState()) { verificationId in print(verificationId) }
//}
