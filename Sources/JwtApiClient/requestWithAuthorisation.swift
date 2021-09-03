//
//  requestWithAuthorisation.swift
//  Generic JSON API client that accepts a URL string and a JWT token
//  and returns a parsed JSON object.
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
public func requestWithAuthorisation<T: Decodable>(_ url: URL, token: String) async throws -> T {
  let request: URLRequest = try await createAuthorisedRequest(url, token: token)
  let (data, _) = try await URLSession.shared.data(for: request)

  let decoder = JSONDecoder()
  return try decoder.decode(T.self, from: data)
}

@available(iOS 15.0.0, *)
public func requestWithAuthorisation<T: Decodable>(_ endpoint: String, token: String) async throws -> T {
  let url = URL(string: endpoint)!

  return try await requestWithAuthorisation(url, token: token)
}
