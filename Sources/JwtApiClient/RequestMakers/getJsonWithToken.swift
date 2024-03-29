//
//  getJsonWithToken.swift
//  Generic GET request handler that accepts a JSON API URL and a
//  JWT token and returns a parsed JSON object.
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation

func getJsonWithToken<T: Decodable>(_ url: URL, token: String) async throws -> T {
  let request: URLRequest = try await createAuthorisedRequest(url, token: token)
  return try await requestJson(request)
}

@available(*, deprecated, message: "Use getJsonWithToken(URL, String) instead")
func getJsonWithToken<T: Decodable>(_ endpoint: String, token: String) async throws -> T {
  let url = URL(string: endpoint)!

  return try await getJsonWithToken(url, token: token)
}
