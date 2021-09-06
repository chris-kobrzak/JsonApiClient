//
//  Dictionary+stringified.swift
//  File
//
//  Created by Chris Kobrzak on 06/09/2021.
//

import Foundation

extension Dictionary where Key == String, Value == Any {
  var stringified: String? {
    do {
      let data = try JSONSerialization.data(withJSONObject: self, options: .sortedKeys)
      guard let jsonString = String(data: data, encoding: .utf8) else {
        return nil
      }

      return jsonString
    } catch let error {
      print("Error with " + #function + ": " + error.localizedDescription)
      return nil
    }
  }
}
