import SwiftUI

struct MessageBubbleView: View {
  private let model: MessageBubbleModel
  private let onPress: (UUID) -> Void

  @State
  private var showStream: Bool = false

  init(model: MessageBubbleModel, onPress: @escaping (UUID) -> Void) {
    self.model = model
    self.onPress = onPress
  }

  var body: some View {
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
        Button {
          onPress(model.messageId)
        } label: {
          HStack(spacing: 4) {
            Image(systemName: "message")
              .font(.system(size: 16, weight: .semibold))
              .frame(height: 40)
              .foregroundStyle(.secondary)

            let reply = if let stream = model.stream {
              AppI18n.Message.Bubble.replies(stream.messagesCount)
            } else {
              AppI18n.Message.Bubble.reply
            }
            Text(reply)
              .font(.system(size: AppSettings.Font.s, weight: .semibold))
              .foregroundStyle(.secondary)

//            Image(systemName: "chevron.forward.circle")
//              .font(.system(size: 16))
//              .frame(height: 40)
//              .foregroundStyle(.secondary)
          }
        }.buttonStyle(.plain)

        Spacer()

        if let stream = model.stream {
          Button {
            withAnimation {
              showStream.toggle()
            }
          } label: {
            HStack(spacing: 4) {
              MessageBubbleUsersView(users: stream.users)

              Image(systemName: "chevron.down.circle")
                .font(.system(size: 16))
                .foregroundStyle(.secondary)
            }
            .padding(.horizontal, AppSettings.Padding.y)
            .frame(height: 30)
            .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
          }.buttonStyle(.plain)
        }
      }.padding(.leading, 40 + AppSettings.Padding.y)

      if let stream = model.stream {
        if showStream {
          HStack(spacing: 0) {
            Text(stream.text)
              .font(.system(size: AppSettings.Font.main))

            Spacer()
          }.padding(.leading, 40 + AppSettings.Padding.y)
        }
      }
    }
  }
}

struct MessageBubbleUsersView: View {
  private let users: [MessageBubbleModel.User]

  init(users: [MessageBubbleModel.User]) {
    self.users = users
  }

  var body: some View {
    let visible = if users.count > 5 {
      users.dropFirst().prefix(3)
    } else {
      users.dropFirst()
    }

    let restCount = users.count - 1 - visible.count

    HStack(spacing: -8) {
      if let user = users.first {
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(10)
          Text(user.abbr).font(.system(size: 10, weight: .medium))
        }.frame(width: 20, height: 20)
      }

      ForEach(visible, id: \.userId) { user in
        ZStack {
          Rectangle().fill(Color(hex: user.color)).cornerRadius(10)
          Text(user.abbr).font(.system(size: 10, weight: .medium))
        }.frame(width: 20, height: 20)
          .overlay(alignment: .trailing) {
            Circle()
              .frame(width: 24, height: 24)
              .offset(x: 20 * -0.5)
              .blendMode(.destinationOut)
          }
          .compositingGroup()
      }

      if restCount > 0 {
        Text("+\(restCount)")
          .font(.system(size: AppSettings.Font.s, weight: .bold))
          .padding(.leading, 12)
      }
    }
  }
}

#Preview {
  Group {
    MessageBubbleView(model: stub_message(usersCount: 1, messagesCount: 0), onPress: { _ in })
    MessageBubbleView(model: stub_message(usersCount: 4, messagesCount: 1), onPress: { _ in })
    MessageBubbleView(model: stub_message(usersCount: 2, messagesCount: 7), onPress: { _ in })
    MessageBubbleView(model: stub_message(usersCount: 5, messagesCount: 10), onPress: { _ in })
    MessageBubbleView(model: stub_message(usersCount: 20, messagesCount: 12), onPress: { _ in })
  }.padding(.horizontal, AppSettings.Padding.x)

  Spacer()
}

func stub_message(usersCount: Int, messagesCount: Int64) -> MessageBubbleModel {
  let users = [
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "AB",
      color: "#4dba2c4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "CD",
      color: "#8e4ece4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "EF",
      color: "#2ad3ed4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "GH",
      color: "#7c37dd4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "PO",
      color: "#d085fc4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "PO",
      color: "#d085fc4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "PO",
      color: "#d085fc4c",
    ),
    GetMessageMessagesResponseModel.Message.User(
      userId: UUID(),
      name: "John Doe",
      abbr: "PO",
      color: "#d085fc4c",
    ),
  ].prefix(usersCount)

  let stream: GetMessageMessagesResponseModel.Message.Stream? = if messagesCount > 0 {
    .init(
      streamId: UUID(),
      messageId: UUID(),
      text: "Suspendisse sed mi nec purus pulvinar bibendum nec et ante. Duis varius viverra nunc, eu ultricies eros semper non. Sed quis suscipit odio, scelerisque euismod sem.",
      messagesCount: messagesCount,
      users: Array(users),
    )
  } else {
    nil
  }

  return MessageBubbleModel(
    m: GetMessageMessagesResponseModel.Message(
      messageId: UUID(),
      text: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut consequat eget orci ultrices aliquam. Duis maximus tristique elit vulputate tincidunt\nSecond line\nLast row",
      user: GetMessageMessagesResponseModel.Message.User(
        userId: UUID(),
        name: "John Doe",
        abbr: "JD",
        color: "#ccf9ff4c",
      ),
      stream: stream,
    ),
  )
}
