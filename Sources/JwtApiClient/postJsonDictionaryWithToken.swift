//
//  postJsonDictionaryWithToken.swift
//  Generic POST request handler that accepts a JSON API URL, a JWT token and a
//  data dictionary and returns a parsed JSON object.
//
//  The dictionary are transferred in the JSON format as part of the
//  HTTP request.
//
//  Created by Chris Kobrzak on 06/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
public func postJsonDictionaryWithToken<T: Decodable>(_ url: URL!, token: String, dictionary: [String: Any]) async throws -> T {
  var request = try await createAuthorisedJsonBodyRequest(url, token: token, dictionary: dictionary)
  request.setMethod("POST")

  return try await requestJson(request)
}
