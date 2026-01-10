import SwiftUI

struct AuthView: View {
  var body: some View {
    VStack {
      Text("AUTH")
    }
  }
}

struct ColorDetail: View {
  var color: Color
  var text: String

  var body: some View {
    VStack {
      Text(text)
      color
    }
  }
}

#Preview {
  AuthView()
}
