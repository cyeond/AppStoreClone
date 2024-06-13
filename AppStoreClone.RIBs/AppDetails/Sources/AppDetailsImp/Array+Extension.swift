//
//  Array+Extension.swift
//
//
//  Created by YD on 6/12/24.
//
import Foundation

extension Array {
  subscript(safe index: Int) -> Element? {
    return indices ~= index ? self[index] : nil
  }
}
