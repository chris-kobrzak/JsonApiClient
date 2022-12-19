import Foundation

//
//  patchJsonDictionary.swift
//  Generic PATCH request handler that accepts a JSON API URL and a
//  data dictionary. It can only be used for empty responses.
//
//  The dictionary are transferred in the JSON format as part of the
//  HTTP request.
//
//  Created by Chris Kobrzak on 26/11/2022.
//

import Foundation

func patchJsonDictionary(_ url: URL!, _ dictionary: [String: Any]) async throws -> URLResponse {
  var request = try await createJsonBodyRequest(url, dictionary)
  request.setMethod("PATCH")

  let (_, response) = try await makeGenericRequest(request)
  return response
}
