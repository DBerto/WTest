//
//  DependencyManager.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation
import Swinject

protocol DependencyManagerProtocol {
    func applyAssemblies()
}

extension DependencyManagerProtocol {
    func applyAssemblies() { }
}

class DependencyManager: DependencyManagerProtocol {
    static let shared = DependencyManager()
    
    let assembler: Assembler
    let container: Container
    
    static var resolver: Resolver {
        return Self.shared.assembler.resolver
    }
    
    private init() {
        self.container = Container()
        self.assembler = Assembler([], container: container)
        applyAssemblies()
    }
}
