import SwiftUI

struct UserTopicsUsersView: View {
  @State
  private var service: UserTopicsUsersService

  init(api: ApiClient, userId: UUID) {
    let service: UserTopicsUsersService = .init(api: api, userId: userId)

    self.service = service
  }

  var body: some View {
    @Bindable
    var model = service.model

    let size = AppSettings.Padding.y * 6

    VStack(spacing: 0) {
      LazyVGrid(
        columns: [GridItem(.adaptive(minimum: size, maximum: size))],
        spacing: AppSettings.Padding.y,
      ) {
        ForEach(model.topics, id: \.topicId) { topic in
          let title = Text(topic.title)
            .font(.system(size: AppSettings.Padding.y * 3))
            .frame(
              width: size,
              height: size,
            )

          if let topicUser = model.topicsUsers.first(where: { topicUser in
            topicUser.topicId == topic.topicId
          }) {
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
              title
            }.buttonStyle(.plain)
              .background(.gray, in: RoundedRectangle(cornerRadius: size / 2))
          } else {
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
              title
            }.buttonStyle(.plain)
              .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: size / 2))
          }

//          Button {
//
//          } label: {
//            title
//          }.buttonStyle(.plain)
//            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: size / 2))
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
