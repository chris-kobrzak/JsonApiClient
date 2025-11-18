//
//  putJsonDictionaryWithToken.swift
//  Generic PUT request handler that accepts a JSON API URL, a JWT token and a
//  data dictionary.
//
//  The dictionary are transferred in the JSON format as part of the
//  HTTP request.
//
//  Created by Chris Kobrzak on 18/11/2025.
//

import Foundation

func putJsonDictionaryWithToken(_ url: URL!, token: String, dictionary: [String: Any]) async throws {
  var request = try await createAuthorisedJsonBodyRequest(url, token: token, dictionary: dictionary)
  request.setMethod("PUT")

  let _ = try await makeGenericRequest(request)
}

func putJsonDictionaryWithToken(_ url: URL!, token: String, dictionaries: [[String: Any]]) async throws {
  var request = try await createAuthorisedJsonBodyRequest(url, token: token, payload: dictionaries)
  request.setMethod("PUT")

  let _ = try await makeGenericRequest(request)
}
