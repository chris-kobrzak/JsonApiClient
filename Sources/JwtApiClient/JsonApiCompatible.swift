//
//  JwtApiCompatible.swift
//
//  Created by Chris Kobrzak on 05/03/2022.
//

import Foundation

public protocol JsonApiCompatible {
  func post<T: Decodable>(url: URL, dictionary: [String: Any]) async throws -> T

  func post<T: Decodable>(url: URL, dictionary: [String: Any], token: String) async throws -> T

  func get<T: Decodable>(url: URL, token: String) async throws -> T

  // The methods below currently assume the response is empty
  func delete(url: URL, token: String) async throws

  func patch(url: URL, dictionary: [String: Any], token: String) async throws
}
