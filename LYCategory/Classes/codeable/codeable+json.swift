//
//  codeable+json.swift
//  LYAppKit
//
//  Created by 孙宁宁 on 2022/9/22.
//

import Foundation

extension JSONEncoder {
    
    public static func ly_jsonData<T: Encodable>(_ model: T) -> Data? {
        let jsonEncoder = JSONEncoder()
        if #available(iOS 13.0, *) {
            jsonEncoder.outputFormatting = .withoutEscapingSlashes
        }
        return try? jsonEncoder.encode(model)
    }
    
    public static func ly_jsonString<T: Encodable>(_ model: T) -> String? {
        guard let jsonData = ly_jsonData(model) else { return nil }
        return String(data: jsonData, encoding: .utf8)
    }
}


extension JSONDecoder {
  
    public static func ly_modelFromJSONString<T: Decodable>(_ type: T.Type, jsonString: String) -> T? {
        guard let jsonData = jsonString.data(using: .utf8) else { return nil }
        return ly_modelFromJSONData(type, jsonData: jsonData)
    }
    
    public static func ly_modelFromJSON<T: Decodable>(_ type: T.Type, json: Any) -> T? {
        guard let jsonData = try? JSONSerialization.data(withJSONObject: json) else {return nil}
        return ly_modelFromJSONData(type, jsonData: jsonData)
    }
    
    public static func ly_modelFromJSONData<T: Decodable>(_ type: T.Type, jsonData: Data) -> T? {
        let decoder = JSONDecoder()
        return try? decoder.decode(T.self, from: jsonData)
    }
}
