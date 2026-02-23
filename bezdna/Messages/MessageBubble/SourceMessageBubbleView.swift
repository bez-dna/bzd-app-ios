import SwiftUI

struct SourceMessageBubbleView: View {
  @State
  private var service: MessageBubbleService

//  @Environment(AppState.self)
//  private var state

  init(
    api: ApiClient,
    model: MessageBubbleModel,
  ) {
    let service: MessageBubbleService = .init(api: api, model: model)

    self.service = service
  }

  var body: some View {
    let model = service.model
    let user = model.user

    VStack(spacing: 0) {
      HStack(alignment: .top, spacing: 0) {
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(20)
          Text(user.abbr).font(.system(size: AppSettings.Font.s, weight: .bold))
        }
        .frame(width: 40, height: 40)
        .padding(.trailing, AppSettings.Padding.y)

        VStack(alignment: .leading, spacing: 0) {
          Text(user.name)
            .lineLimit(1)
            .font(.system(size: AppSettings.Font.s, weight: .bold))
            .padding(.bottom, 2)

          Text(model.text)
            .font(.system(size: AppSettings.Font.main))
        }

        Spacer()
      }

      HStack(spacing: 0) {
        MessageBubbleTopicsView(service: service)

//          Button {
//            showTopics.toggle()
//          } label: {
//            HStack(spacing: 4) {
//              Image(systemName: "tag")
//                .font(.system(size: 16, weight: .semibold))
//                .frame(height: 40)
//                .foregroundStyle(.secondary)
//
//              Text(AppI18n.Message.Bubble.topics)
//                .font(.system(size: AppSettings.Font.s, weight: .semibold))
//                .foregroundStyle(.secondary)
//            }
//          }.buttonStyle(.plain)
//            .sheet(isPresented: $showTopics) {
//              MessageTopicsView(api: state.api, messageId: model.messageId)
//                .presentationDetents([.medium, .large])
//            }
        Spacer()
      }.padding(.leading, 40 + AppSettings.Padding.y)
    }
  }
}
