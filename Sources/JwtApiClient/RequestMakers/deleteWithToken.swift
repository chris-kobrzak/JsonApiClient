//
//  deleteWithToken.swift
//  Generic DELETE request handler that accepts a JSON API URL and a JWT token.
//  It can only be used for empty responses.
//
//  Created by Chris Kobrzak on 07/09/2021.
//

import Foundation

func deleteWithToken(_ url: URL, token: String) async throws {
  var request: URLRequest = try await createAuthorisedRequest(url, token: token)
  request.setMethod("DELETE")

  let (_, _) = try await makeGenericRequest(request)
}
