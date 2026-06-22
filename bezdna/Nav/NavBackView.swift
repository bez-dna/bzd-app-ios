import SwiftUI

struct NavBackView: View {
  @Bindable
  private(set) var nav: AppNav

  var body: some View {
    if #available(iOS 26.0, *) {
      Button {
        nav.path.removeLast()
      } label: {
        NavBackButtonView(nav: nav)
      }
    } else {
      Button {
        nav.path.removeLast()
      } label: {
        NavBackButtonView(nav: nav)
      }.buttonStyle(.plain)
        .padding(.horizontal, 12)
        .frame(
          height: 40,
        ).background(.red, in: RoundedRectangle(cornerRadius: 20))
    }
  }
}

struct NavBackButtonView: View {
  @Bindable
  private(set) var nav: AppNav

  var body: some View {
    HStack(spacing: AppSettings.Padding.y) {
      Image(systemName: "chevron.left")
        .font(.system(size: AppSettings.Font.main, weight: .bold))

      Text("\(nav.path.count)")
    }
  }
}
