//
//  NetworkAgent.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation

public class NetworkAgent {
    private (set) var session: URLSession
    
    public init(session: URLSession = .defaultSession) {
        self.session = session
    }
}
