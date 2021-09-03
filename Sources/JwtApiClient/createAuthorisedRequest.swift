//
//  createAuthorisedRequest.swift
//  Returns a URLRequest with the JWT Authorization and JSON Accept HTTP headers
//
//  Created by Chris Kobrzak on 03/09/2021.
//

import Foundation

@available(iOS 15.0.0, *)
public func createAuthorisedRequest(_ url: URL, token: String) async throws -> URLRequest {
  var request = URLRequest(url: url)

  request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  request.setValue("application/json", forHTTPHeaderField: "Accept")

  return request
}