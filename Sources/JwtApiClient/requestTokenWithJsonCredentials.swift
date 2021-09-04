//
//  requestTokenWithJsonCredentials.swift
//  Generic JSON API client that accepts a URL string and a
//  credentials object intended to be POSTed in the JSON format.
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
public func requestTokenWithJsonCredentials<T: Decodable>(_ url: URL!, _ credentials: [String: String]) async throws -> T {
  let request = try await createJsonBodyRequest(url, credentials)

  let (data, _) = try await URLSession.shared.data(for: request)

  let decoder = JSONDecoder()
  return try decoder.decode(T.self, from: data)
}
