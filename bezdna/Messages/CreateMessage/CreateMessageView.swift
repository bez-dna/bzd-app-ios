import SwiftUI

struct CreateMessageView : View {
  @State private var text = ""

  var body: some View {
    ZStack(alignment: .bottomTrailing) {
      TextEditor(text: $text)
        .scrollContentBackground(.hidden)
        .background(.input)
        .cornerRadius(19)
        .contentMargins(.horizontal, 8, for: .automatic)
        .frame(minHeight: 38)

      Button {
        print("send:", text)
      } label: {
        Image(systemName: "arrow.right.circle.fill")
          .font(.system(size: 30))
          .foregroundStyle(.submit)
      }
      .padding(2)
    }
  }
}

//struct MessageTextView: UIViewRepresentable {
//  @Binding
//  private var text: String
//
//  func makeUIView(context: Context) -> UITextView {
//    return UITextView()
//  }
//
//  func updateUIView(_ uiView: UIViewType, context: Context) {
//    uiView.text = text
//  }
//}

#Preview {
  CreateMessageView()
}
