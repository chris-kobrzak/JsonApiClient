//
//  postJsonDictionary.swift
//  Generic POST request handler that accepts a JSON API URL and a
//  data dictionary and returns a parsed JSON object. This can be
//  used e.g. for submitting credentials to obtain JWT tokens.
//
//  The dictionary are transferred in the JSON format as part of the
//  HTTP request.
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
public func postJsonDictionary<T: Decodable>(_ url: URL!, _ dictionary: [String: Any]) async throws -> T {
  let request = try await createJsonBodyRequest(url, dictionary)
  return try await requestJson(request)
}
