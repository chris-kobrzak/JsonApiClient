//
//  JsonApiClient.swift
//
//  Created by Chris Kobrzak on 05/03/2022.
//

import Foundation

public class JsonApiClient: JsonApiCompatible {
  public init() {}

  public func post(url: URL, dictionary: [String : Any]) async throws -> URLResponse {
    return try await postJsonDictionary(url, dictionary)
  }

  public func post<T>(url: URL, dictionary: [String: Any]) async throws -> T where T : Decodable {
    try await postJsonDictionary(url, dictionary)
  }

  public func post<T>(url: URL, dictionary: [String : Any], token: String) async throws -> T where T : Decodable {
    try await postJsonDictionaryWithToken(url, token: token, dictionary: dictionary)
  }

  public func get<T>(url: URL, token: String) async throws -> T where T : Decodable {
    try await getJsonWithToken(url, token: token)
  }

  public func delete(url: URL, token: String) async throws {
    try await deleteWithToken(url, token: token)
  }

  public func patch(url: URL, dictionary: [String : Any], token: String) async throws {
    try await patchJsonDictionaryWithToken(url, token: token, dictionary: dictionary)
  }
}
