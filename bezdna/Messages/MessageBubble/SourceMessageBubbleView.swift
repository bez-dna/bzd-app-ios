import SwiftUI

struct SourceMessageBubbleView: View {
  private let model: MessageBubbleModel

  init(model: MessageBubbleModel) {
    self.model = model
  }

  var body: some View {
    let user = model.user

    VStack {
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
    }
  }
}
