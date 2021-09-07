//
//  deleteWithToken.swift
//  Generic DELETE request handler that accepts a JSON API URL and a
//  JWT token and returns a parsed JSON object.
//
//  Please note, it might be challenging to use this handler to work with
//  DELETE requests that do not return any data due to the Generics type
//  returned.
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
public func deleteWithToken<T: Decodable>(_ url: URL, token: String) async throws -> T {
  var request: URLRequest = try await createAuthorisedRequest(url, token: token)
  request.setMethod("DELETE")

  return try await requestJson(request)
}
