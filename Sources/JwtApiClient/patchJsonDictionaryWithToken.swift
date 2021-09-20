//
//  patchJsonDictionaryWithToken.swift
//  Generic PATCH request handler that accepts a JSON API URL, a JWT token and a
//  data dictionary. It can only be used for empty responses.
//
//  The dictionary are transferred in the JSON format as part of the
//  HTTP request.
//
//  Created by Chris Kobrzak on 06/09/2021.
//

import Foundation

public func patchJsonDictionaryWithToken(_ url: URL!, token: String, dictionary: [String: Any]) async throws {
  var request = try await createAuthorisedJsonBodyRequest(url, token: token, dictionary: dictionary)
  request.setMethod("PATCH")

  let (_, _) = try await URLSession.shared.data(for: request)
}
