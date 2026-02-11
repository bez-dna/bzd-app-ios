import SwiftUI

struct CreateTopicView : View {
  @State
  private var service: CreateTopicService

  private let onCreate: (UUID) -> Void

  init(api: ApiClient, onCreate: @escaping (UUID) -> Void) {
    service = .init(api: api)
    self.onCreate = onCreate
  }

  var body: some View {
    HStack(spacing: AppSettings.Padding.x) {
      TextField(AppI18n.Topics.Create.placeholder, text: $service.model.title)
        .keyboardType(.default)
        .padding(.horizontal, AppSettings.Padding.y * 2)
        .frame(height: 30)
//        .textFieldStyle(.plain)
        .font(.system(size: AppSettings.Font.main))
        .background(RoundedRectangle(cornerRadius: 15).fill(.input))


      Button{
        Task {
          let model = try await service.save()

          onCreate(model.topic.topicId)
        }
      } label: {
        Text(AppI18n.Topics.Create.button)
          .colorInvert()
          .font(.system(size: AppSettings.Font.button, weight: .bold))
          .frame(height: 30)
      }
      .buttonStyle(.plain)
      .padding(.horizontal, AppSettings.Padding.x)
//      .background(.submit)
      .background(RoundedRectangle(cornerRadius: 15).fill(.submit))
//      .clipShape(RoundedRectangle(cornerRadius: 15))
    }
  }
}

#Preview {
  let state = AppState()

  CreateTopicView(api:state.api) {topicId in}
}
