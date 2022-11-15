//
//  putJsonDictionary.swift
//  Generic PUT request handler that accepts a JSON API URL and a
//  data dictionary.
//
//  The dictionary are transferred in the JSON format as part of the
//  HTTP request.
//
//  Created by Chris Kobrzak on 15/11/2022.
//

import Foundation

public func putJsonDictionary(_ url: URL!, _ dictionary: [String: Any]) async throws -> URLResponse {
  var request = try await createJsonBodyRequest(url, dictionary)
  request.setMethod("PUT")

  let (_, response) = try await makeGenericRequest(request)
  return response
}
