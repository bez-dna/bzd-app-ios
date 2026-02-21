import SwiftUI

struct TopicsView : View {
  @State
  private var showEmojis = false

  @State
  private var service: TopicsService  

  init(api: ApiClient) {
    let service: TopicsService = .init(api: api)

    self.service = service
  }

  var body: some View {
    @Bindable
    var model = service.model

    let size = AppSettings.Padding.y * 6

    VStack(spacing: 0) {
      LazyVGrid(
        columns: [GridItem(.adaptive(minimum: size, maximum: size))],
        spacing: AppSettings.Padding.y
      ) {
        ForEach(model.topics, id: \.self.topicId) { topic in
          Button {

          } label: {
            Text(topic.title)
              .font(.system(size: AppSettings.Padding.y * 3))
              .frame(
                width: size,
                height: size,
              )
          }.buttonStyle(.plain)
            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: size / 2))
        }

        if let permissions = model.permissions {
          if permissions.topics {
            Button {
              showEmojis = true
            } label: {
              Image(systemName: "plus")
                .font(.system(size: AppSettings.Font.button, weight: .bold))
                .foregroundStyle(.secondary)
                .frame(
                  width: size,
                  height: size,
                )
            }.sheet(isPresented: $showEmojis) {
              TopicsEmojisView(emojis: model.emojis) { title in
                Task {
                  do {
                    try await service.createTopic(title: title)
                    try await service.load()
                  } catch {
                    print(error)
                  }
                }
              }.presentationDetents([.medium])
                .padding(.horizontal, AppSettings.Padding.x)
            }
            .buttonStyle(.plain)
            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: size / 2))
          }
        }
      }
    }.task {
      do {
        try await service.load()
      } catch {
        print(error)
      }
    }
  }
}

struct TopicsEmojisView : View {
  @Environment(\.dismiss)
  private var dismiss

  private var emojis: [TopicsModel.Emoji]
  private let onCreate: (String) -> Void

  init(emojis: [TopicsModel.Emoji], onCreate: @escaping (String) -> Void) {
    self.emojis = emojis
    self.onCreate = onCreate
  }

  var body: some View {
    LazyVGrid(columns: [GridItem(.adaptive(minimum: AppSettings.Padding.y * 8))], spacing: AppSettings.Padding.y) {
      ForEach(emojis, id: \.self.code) { emoji in
        Button {
          onCreate(emoji.title)
          dismiss()
        } label: {
          Text(emoji.title)
            .font(.system(size: AppSettings.Padding.y * 6))
        }
      }
    }
  }
}

#Preview {
  let state = AppState()

  TopicsView(api: state.api)
}
