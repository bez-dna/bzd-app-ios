enum APIError: Error {
  case unauthorized
  case serverError(statusCode: Int)
  case decodingError
}
