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

  func get<T: Decodable>(_ endpoint: String, token: String) async throws -> T

  // The methods below currently assume the response is empty
  func delete(_ url: URL, token: String) async throws

  func patch(_ url: URL!, token: String, dictionary: [String: Any]) async throws
}

public extension JsonApiCompatible {
  func post<T>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T where T : Decodable {
    try await postJsonDictionary(url, dictionary)
  }

  func post<T>(_ url: URL!, token: String, dictionary: [String : Any]) async throws -> T where T : Decodable {
    try await postJsonDictionaryWithToken(url, token: token, dictionary: dictionary)
  }

  func get<T>(_ url: URL, token: String) async throws -> T where T : Decodable {
    try await getJsonWithToken(url, token: token)
  }

  func get<T>(_ endpoint: String, token: String) async throws -> T where T : Decodable {
    try await getJsonWithToken(endpoint, token: token)
  }

  func delete(_ url: URL, token: String) async throws {
    try await deleteWithToken(url, token: token)
  }

  func patch(_ url: URL!, token: String, dictionary: [String : Any]) async throws {
    try await patchJsonDictionaryWithToken(url, token: token, dictionary: dictionary)
  }
}
