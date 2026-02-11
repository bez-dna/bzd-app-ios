import SwiftUI

@Observable
final class CreateTopicService {
  var model: CreateTopicModel = .init()

  @ObservationIgnored
  private let api: TopicsApi

  init(api: ApiClient) {
    self.api = TopicsApiImpl(api)
  }

  func save() async throws -> CreateTopicResponseModel {
    let res = try await api.createTopic(
      req: .init(
        model: .init(title: model.title)
      )
    )

    model = .init()

    return res
  }
}
