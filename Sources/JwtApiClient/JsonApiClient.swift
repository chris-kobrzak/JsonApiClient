//
//  JsonApiClient.swift
//
//  Created by Chris Kobrzak on 05/03/2022.
//

import Foundation

public class JsonApiClient: JsonApiCompatible {
  public init() {}

  public func post<T>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T where T : Decodable {
    try await postJsonDictionary(url, dictionary)
  }

  public func post<T>(_ url: URL!, dictionary: [String : Any], token: String) async throws -> T where T : Decodable {
    try await postJsonDictionaryWithToken(url, token: token, dictionary: dictionary)
  }

  public func get<T>(_ url: URL, token: String) async throws -> T where T : Decodable {
    try await getJsonWithToken(url, token: token)
  }

  public func delete(_ url: URL, token: String) async throws {
    try await deleteWithToken(url, token: token)
  }

  public func patch(_ url: URL!, dictionary: [String : Any], token: String) async throws {
    try await patchJsonDictionaryWithToken(url, token: token, dictionary: dictionary)
  }
}
