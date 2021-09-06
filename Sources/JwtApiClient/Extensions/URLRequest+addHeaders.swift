//
//  URLRequest.swift
//
//  Created by Chris Kobrzak on 06/09/2021.
//

import Foundation

extension URLRequest {
  mutating func addJsonAcceptHeader()  {
    self.setValue("application/json", forHTTPHeaderField: "Accept")
  }

  mutating func addJsonContentTypeHeader() {
    self.setValue("application/json", forHTTPHeaderField: "Content-Type")
  }

  mutating func addJwtTokenHeader(_ token: String) {
    self.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
  }

  mutating func setMethod(_ httpMethod: String) {
    self.httpMethod = httpMethod
  }

  mutating func setJsonBody(_ json: String) {
    self.httpBody = json.data(using: .utf8)
  }
}
