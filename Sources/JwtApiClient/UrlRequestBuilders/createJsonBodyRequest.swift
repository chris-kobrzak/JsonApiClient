//
//  createJsonBodyRequest.swift
//  Builds a POST request with the provided dictionary encoded as a JSON body.
//
//  Created by Chris Kobrzak on 04/09/2021.
//

import Foundation

func createJsonBodyRequest(_ url: URL!, _ dictionary: [String: Any]) async throws -> URLRequest {
  let dictionaryJson = dictionary.stringified!

  var request = URLRequest(url: url)

  request.addJsonAcceptHeader()
  request.addJsonContentTypeHeader()
  request.setJsonBody(dictionaryJson)

  return request
}
