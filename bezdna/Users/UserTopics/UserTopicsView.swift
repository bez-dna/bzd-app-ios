import SwiftUI

struct UserTopicsView: View {
  @State
  private var service: UserTopicsService

  @State
  private var showTopics: Bool = false

  init(api: ApiClient, userId: UUID) {
    let service: UserTopicsService = .init(api: api, userId: userId)

    self.service = service
  }

  var body: some View {
    @Bindable
    var model = service.model

    VStack(spacing: 0) {
      Button {
        withAnimation {
          showTopics.toggle()
        }
      } label: {
        HStack(spacing: AppSettings.Padding.y / 2) {
          Text(AppI18n.User.Topics.title)
            .font(.system(size: AppSettings.Font.main, weight: .bold))

          Image(systemName: "chevron.down.circle")
            .font(.system(size: AppSettings.Font.main))

          Text(AppI18n.User.Topics.button)
            .font(.system(size: AppSettings.Font.s))
            .padding(.leading, AppSettings.Padding.y)
        }
      }
      .buttonStyle(.plain)
      .padding(.horizontal, AppSettings.Padding.y)
      .frame(height: 30)
      .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))

      if showTopics {
        Text(AppI18n.User.Topics.desc)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.system(size: AppSettings.Font.main, weight: .medium))
          .padding(.bottom, AppSettings.Padding.y)
          .padding(.top, AppSettings.Padding.y * 2)

        Text(AppI18n.User.Topics.segments)
          .frame(maxWidth: .infinity, alignment: .leading)
          .font(.system(size: AppSettings.Font.s))
          .padding(.bottom, AppSettings.Padding.y)

        UserTopicsListView(service: service)
      }
    }
    .padding(.horizontal, AppSettings.Padding.x)
    .task {
      do {
        try await service.load()
      } catch {
        print(error)
      }
    }
  }
}

struct UserTopicsListView: View {
  @Bindable
  private var service: UserTopicsService

  init(service: UserTopicsService) {
    self.service = service
  }

  var body: some View {
    @Bindable
    var model = service.model

    VStack(spacing: AppSettings.Padding.y) {
      ForEach(model.topics, id: \.topicId) { topic in
        let maybeTopicUser = model.topicsUsers.first(where: { topicUser in
          topicUser.topicId == topic.topicId
        })

        HStack(spacing: AppSettings.Padding.y) {
          if maybeTopicUser == nil {
            Button {
              Task {
                do {
                  try await service.createTopicUser(topicId: topic.topicId)
                  try await service.load()
                } catch {
                  print(error)
                }
              }
            } label: {
              Image(systemName: "plus.circle")
                .font(.system(size: AppSettings.Font.main))
            }
          }

          Text(topic.title).lineLimit(1).font(.system(size: AppSettings.Font.main))

          if let topicUser = maybeTopicUser {
            Button {
              Task {
                do {
                  try await service.deleteTopicUser(topicUserId: topicUser.topicUserId)
                  try await service.load()
                } catch {
                  print(error)
                }
              }
            } label: {
              Image(systemName: "minus.circle")
                .font(.system(size: AppSettings.Font.main))
            }
          }

          Spacer()
        }.frame(maxWidth: .infinity)
      }
    }
  }
}
