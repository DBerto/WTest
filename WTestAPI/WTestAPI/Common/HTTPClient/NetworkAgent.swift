//
//  NetworkAgent.swift
//  WTestAPI
//
//  Created by Berto, David Manuel  on 04/01/2023.
//

import Foundation
import WTestCommon

public class NetworkAgent {
    private (set) var session: URLSession
    private (set) var cache: URLCache
    private (set) var monitor: NetworkMonitorProtocol
    
    public init(session: URLSession = .defaultSession,
                cache: URLCache = .shared,
                monitor: NetworkMonitorProtocol = NetworkMonitor()) {
        self.session = session
        self.cache = cache
        self.monitor = monitor
    }
}
