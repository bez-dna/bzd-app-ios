import Foundation

enum AppSettings {
  enum API {
    static let scheme = "http"
    static let host = "192.168.1.69"
    static let port: Int? = 3010
    static let path = "/api"
  }

  enum Font {
    static let button: CGFloat = 14
    static let middle: CGFloat = 24
  }

  enum Padding {
    static let y: CGFloat = 8
    static let x: CGFloat = 16
  }
}
