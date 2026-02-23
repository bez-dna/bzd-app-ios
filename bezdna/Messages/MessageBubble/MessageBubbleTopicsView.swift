import SwiftUI

struct MessageBubbleTopicsView: View {
  private(set) var service: MessageBubbleService

  @State
  private var showTopics = false

  var body: some View {
    let model = service.model

    let placeholder = HStack(spacing: 4) {
      Image(systemName: "heart")
        .font(.system(size: 16, weight: .semibold))
        .frame(height: AppSettings.Padding.y * 4)
        .foregroundStyle(.secondary)

      Text(AppI18n.Message.Bubble.like)
        .font(.system(size: AppSettings.Font.s, weight: .semibold))
        .foregroundStyle(.secondary)
    }

    if model.topics.count > 1 {
      if showTopics {
        HStack(spacing: AppSettings.Padding.y) {
          ForEach(model.topics, id: \.topicId) { topic in
            Button {
              Task {
                do {
                  try await service.createMessageTopic(topicId: topic.topicId)
                } catch {
                  print(error)
                }
              }
            } label: {
              Text(topic.title).font(.system(size: AppSettings.Font.s))
            }.frame(
              width: AppSettings.Padding.y * 4,
              height: AppSettings.Padding.y * 4,
            )
            .buttonStyle(.plain)
            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2))
          }

          Button {
            showTopics = false
          } label: {
            Image(systemName: "xmark")
              .font(.system(size: AppSettings.Font.s))
              .foregroundStyle(.secondary)
          }.frame(
            width: AppSettings.Padding.y * 4,
            height: AppSettings.Padding.y * 4,
          )
          .buttonStyle(.plain)
          .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: AppSettings.Padding.y * 2))
        }
      } else {
        Button {
          showTopics = true
        } label: {
          placeholder
        }.buttonStyle(.plain)
      }
    } else {
      if let topic = model.topics.first {
        Button {
          Task {
            do {
              try await service.createMessageTopic(topicId: topic.topicId)
            } catch {
              print(error)
            }
          }
        } label: {
          placeholder
        }.buttonStyle(.plain)
      } else {
        Button {
          // TODO: нужно добавить хелпер что нужно войти
        } label: {
          placeholder
        }.buttonStyle(.plain)
      }
    }
  }
}
