//
//  createAuthorisedJsonBodyRequest.swift
//  Returns a URLRequest with the JWT Authorization and JSON Accept HTTP headers
//
//  Created by Chris Kobrzak on 03/09/2021.
//
import Foundation

func createAuthorisedJsonBodyRequest(_ url: URL, token: String, dictionary: [String: Any]) async throws -> URLRequest {
  let dictionaryJson = dictionary.stringified!

  var request = URLRequest(url: url)
  request.setJsonBody(dictionaryJson)
  request.addJsonAcceptHeader()
  request.addJsonContentTypeHeader()
  request.addJwtTokenHeader(token)

  return request
}
