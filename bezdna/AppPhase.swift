enum AppPhase {
  case idle
  case loading
  case loaded
  case failed(AppError)
}
