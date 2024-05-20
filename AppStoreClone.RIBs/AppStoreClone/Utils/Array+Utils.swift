//
//  Array+Utils.swift
//  RIBsPractice
//
//  Created by YD on 5/17/24.
//

import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}
