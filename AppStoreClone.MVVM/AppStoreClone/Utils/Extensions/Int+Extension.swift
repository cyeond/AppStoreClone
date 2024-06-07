//
//  Int+Extension.swift
//  AppStoreClone
//
//  Created by YD on 5/23/24.
//

extension Int {
    func toUnitConvertedString() -> String {
        switch self {
        case 1000..<10000:
            let devided = Float(self)/1000.0
            return String(format: "%.1f", devided) + "천"
        case 10000..<100000:
            let devided = Float(self)/10000.0
            return String(format: "%.1f", devided) + "만"
        case 100000...Int.max:
            let devided = self/10000
            return String(devided) + "만"
        default:
            return String(self)
        }
    }
}
