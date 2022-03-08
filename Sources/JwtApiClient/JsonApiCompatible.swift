//
//  JwtApiCompatible.swift
//
//  Created by Chris Kobrzak on 05/03/2022.
//

import Foundation

public protocol JsonApiCompatible {
  func post<T: Decodable>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T

  func post<T: Decodable>(_ url: URL!, token: String, dictionary: [String: Any]) async throws -> T

  func get<T: Decodable>(_ url: URL, token: String) async throws -> T

  // The methods below currently assume the response is empty
  func delete(_ url: URL, token: String) async throws

  func patch(_ url: URL!, token: String, dictionary: [String: Any]) async throws
}
