import SwiftUI

//
// struct UserTopicsListView: View {
//  @Bindable
//  private var service: UserTopicsService
//
//  init(service: UserTopicsService) {
//    self.service = service
//  }
//
//  var body: some View {
//    @Bindable
//    var model = service.model
//
//    VStack(spacing: AppSettings.Padding.y) {
//      ForEach(model.topics, id: \.topicId) { topic in
//        let maybeTopicUser = model.topicsUsers.first(where: { topicUser in
//          topicUser.topicId == topic.topicId
//        })
//
//        HStack(spacing: AppSettings.Padding.y) {
//          if maybeTopicUser == nil {
//            Button {
//              Task {
//                do {
//                  try await service.createTopicUser(topicId: topic.topicId)
//                  try await service.load()
//                } catch {
//                  print(error)
//                }
//              }
//            } label: {
//              Image(systemName: "plus.circle")
//                .font(.system(size: AppSettings.Font.main))
//            }
//          }
//
//          Text(topic.title).lineLimit(1).font(.system(size: AppSettings.Font.main))
//
//          if let topicUser = maybeTopicUser {
//            Button {
//              Task {
//                do {
//                  try await service.deleteTopicUser(topicUserId: topicUser.topicUserId)
//                  try await service.load()
//                } catch {
//                  print(error)
//                }
//              }
//            } label: {
//              Image(systemName: "minus.circle")
//                .font(.system(size: AppSettings.Font.main))
//            }
//          }
//
//          Spacer()
//        }.frame(maxWidth: .infinity)
//      }
//    }
//  }
// }
