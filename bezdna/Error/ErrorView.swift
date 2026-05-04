import SwiftUI

struct ErrorView : View {
  let error: AppError

  var body: some View {
    ContentUnavailableView {
      Label(error.error, systemImage: "xmark")
    }.padding(.vertical, AppSettings.Padding.y * 4)
  }
}

#Preview {
  ErrorView(error: AppError(error: AppI18n.error))
}

