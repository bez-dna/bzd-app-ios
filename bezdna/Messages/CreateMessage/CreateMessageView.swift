import SwiftUI

struct CreateMessageView: View {
  @State
  private var service: CreateMessageService

  private let onCreate: (UUID) -> Void

  init(_ state: AppState, _ messageId: UUID?, _ onCreate: @escaping (UUID) -> Void) {
    service = .init(api: state.api, messageId: messageId)
    self.onCreate = onCreate
  }

  var body: some View {
    @Bindable
    var model = service.model

    ZStack(alignment: .bottomTrailing) {
      TextEditor(text: $model.text)
        .scrollContentBackground(.hidden)
        .background(.input)
        .cornerRadius(19)
        .contentMargins(.horizontal, 8, for: .automatic)
        .frame(minHeight: 38)

      Button {
        Task {
          do {
            let res = try await service.save()

            onCreate(res.message.messageId)
          } catch {
            print(error)
          }
        }
      } label: {
        Image(systemName: "arrow.right.circle.fill")
          .font(.system(size: 30))
          .foregroundStyle(.submit)
      }
      .padding(2)
    }
  }
}

#Preview {
  CreateMessageView(AppState(), UUID()) { messageId in print(messageId) }
}
