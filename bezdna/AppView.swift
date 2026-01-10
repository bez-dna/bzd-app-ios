import SwiftUI

struct AppView : View {
    @Environment(AppNav.self) var nav
    
    var body: some View {
        switch nav.flow {
        case .auth:
            AuthView()
            
        case .messages:
            MessagesView()
            
        case .users:
            UsersView()
        }
    }
}

#Preview {
    AppView().environment(AppNav())
}
