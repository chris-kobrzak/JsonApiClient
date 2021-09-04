//
//  requestAndParseJson.swift
//  File
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation

@available(iOS 15.0, *)
public func requestAndParseJson<T: Decodable>(_ request: URLRequest) async throws -> T {
  let (data, _) = try await URLSession.shared.data(for: request)

  let decoder = JSONDecoder()
  return try decoder.decode(T.self, from: data)
}
