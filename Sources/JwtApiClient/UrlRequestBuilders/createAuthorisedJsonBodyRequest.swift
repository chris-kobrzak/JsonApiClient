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

func createAuthorisedJsonBodyRequest(_ url: URL, token: String, payload: Any) async throws -> URLRequest {
  let jsonData = try JSONSerialization.data(withJSONObject: payload, options: [])
  let json = String(data: jsonData, encoding: .utf8) ?? "{}"

  var request = URLRequest(url: url)
  request.setJsonBody(json)
  request.addJsonAcceptHeader()
  request.addJsonContentTypeHeader()
  request.addJwtTokenHeader(token)

  return request
}
