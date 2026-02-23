import SwiftUI

struct MessageBubbleTopicsView : View {
  @Bindable
  private(set) var service: MessageBubbleService

  @State
  private var showTopics = true

//  init(service: MessageBubbleService) {
//    self.service = service
//  }

  var body: some View {
    @Bindable
    var model = service.model

    let placeholder = HStack(spacing: 4) {
      Image(systemName: "heart")
        .font(.system(size: 16, weight: .semibold))
        .frame(height: AppSettings.Padding.y * 4)
        .foregroundStyle(.secondary)

      Text(AppI18n.Message.Bubble.like)
        .font(.system(size: AppSettings.Font.s, weight: .semibold))
        .foregroundStyle(.secondary)
    }.background(.red)

    if model.topics.count > 1 {
      if showTopics {
        HStack(spacing: AppSettings.Padding.y) {
          ForEach(model.topics, id: \.topicId) { topic in
            Button {
            } label: {
              Text(topic.title).font(.system(size: AppSettings.Font.s))
            }.frame(
              width: AppSettings.Padding.y * 4,
              height: AppSettings.Padding.y * 4
            ).background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2))
          }.buttonStyle(.plain)

        }
      } else {
        Button {
          showTopics = true
        } label: {
          placeholder
        }.buttonStyle(.plain)
      }
    } else {
      Button {
//        onPress(model.messageId)
      } label: {
        placeholder
      }.buttonStyle(.plain)
    }
  }
}
