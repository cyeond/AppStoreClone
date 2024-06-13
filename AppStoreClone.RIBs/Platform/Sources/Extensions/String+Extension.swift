//
//  String+Extension.swift
//  AppStoreClone
//
//  Created by YD on 5/22/24.
//

import Foundation

public extension String {
    func timePassed() -> Self? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        if let date = dateFormatter.date(from: self) {
            let seconds = Int(date.timeIntervalSinceNow*(-1.0))
            switch seconds/86400 {
            case 0..<1:
                return String(seconds/3600) + "시간 전"
            case 1..<7:
                return String(seconds/86400) + "일 전"
            case 7..<30:
                return String(seconds/(86400*7)) + "주 전"
            case 30..<365:
                return String(seconds/(86400*30)) + "달 전"
            case 365...Int.max:
                return String(seconds/(86400*365)) + "년 전"
            default:
                break
            }
        }
        return nil
    }
}
