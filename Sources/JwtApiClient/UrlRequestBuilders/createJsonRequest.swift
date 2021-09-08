import Foundation

public func createJsonRequest(_ url: URL) async throws -> URLRequest {
  var request = URLRequest(url: url)

  request.setValue("application/json", forHTTPHeaderField: "Accept")
  request.setValue("application/json", forHTTPHeaderField: "Content-Type")

  return request
}
