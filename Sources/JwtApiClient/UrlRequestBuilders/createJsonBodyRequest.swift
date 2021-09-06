//
//  createJsonBodyRequest.swift
//  Builds a POST request with the provided dictionary encoded as a JSON body.
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
func createJsonBodyRequest(_ url: URL!, _ parameters: [String: Any]) async throws -> URLRequest {
  let escapedParametersJson = parameters.stringified

  var request: URLRequest = try await createJsonRequest(url)
  request.httpMethod = "POST"
  request.httpBody = escapedParametersJson?.data(using: .utf8)

  return request
}
