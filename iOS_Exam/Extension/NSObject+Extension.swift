//
//  NSObject+Extension.swift
//  iOS_Exam
//
//  Created by Azruddin Shaikh on 09/04/25.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return NSStringFromClass(self).components(separatedBy: ".").last ?? ""
    }
}
