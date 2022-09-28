//
//  String+Regular.swift
//  taboom
//
//  Created by mac on 2020/11/24.
//  Copyright © 2020 df. All rights reserved.
//

import Foundation
import YYCategories

public struct LYRegular {
    let reg: String
    public static let reg_email = LYRegular(reg: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}")
    public static let reg_chinaMobile = LYRegular(reg: "^1\\d{10}$")
    public static let reg_tenDigit = LYRegular(reg: "[0-9]{10}$")
}

extension String {
    public func ly_matches(_ regular: LYRegular) -> Bool {
        return (self as NSString).matchesRegex(regular.reg, options: [])
    }
}


extension String {
    
    /// 取子串
    /// - Parameters:
    ///   - start: 从0开始
    ///   - end: 最大为字符串的长度 减去  start
    /// - Returns: 子串
    public func ly_substring(_ start: Int, _ end: Int = Int.max) -> String? {
        
        guard start >= 0, count > start, end > start else { return nil }
        let realEnd = min(end, count)
        let startIndex = self.index(self.startIndex, offsetBy: start)
        let endIndex = self.index(self.startIndex, offsetBy: realEnd)
        return String(self[startIndex..<endIndex])
        
    }
    
    
    /// "hello world"[0...1] // "he"
    /// "hello world"[0..<1] // "h"
    /// "hello world"[0] // "h"
    /// "hello world"[0...10] // "hello world"
    public subscript(range: Range<Int>) -> String? {
        return ly_substring(range.lowerBound, range.upperBound)
    }
    
    public subscript(index: Int) -> Character? {
        guard index >= 0, index < count else {return nil}
        return self[self.index(self.startIndex, offsetBy: index)]
    }
}

// MARK: - Trim
extension String {
    /// 删除前后空白符（包含空格、Tab、回车、换行符）
    public var ly_trimmed: String {
        return self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
    }
}
