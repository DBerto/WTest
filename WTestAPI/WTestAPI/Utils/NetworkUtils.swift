//
//  NetworkUtils.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

public class NetworkUtils {
    static var shared: NetworkUtils = .init()
    
    func parseCSV(data: Data) throws ->  Data {
        let dataString: String! = String.init(data: data, encoding: .utf8)

        guard let jsonKeys: [String] = dataString.components(separatedBy: "\n").first?.components(separatedBy: ",") else {
            throw APIError.decodeFail
        }

        var parsedCSV: [[String: String]] = dataString
            .components(separatedBy: "\n")
            .map({
                var result = [String: String]()
                for (index, value) in $0.components(separatedBy: ",").enumerated() {
                    if index < jsonKeys.count {
                        result["\(jsonKeys[index])"] = value
                    }
                }
                return result
            })

        parsedCSV.removeFirst()

        guard let jsonData = try? JSONSerialization.data(withJSONObject: parsedCSV, options: []) else {
            throw APIError.decodeFail
        }

        return jsonData
    }
}
