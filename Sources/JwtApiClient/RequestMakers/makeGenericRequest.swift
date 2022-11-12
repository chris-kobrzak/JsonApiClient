//
//  makeGenericRequest.swift
//  
//
//  Created by Chris Kobrzak on 12/11/2022.
//

import Foundation

func makeGenericRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
  return try await URLSession.shared.data(for: request)
}
