//
//  TableViewModelBase.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

open class TableViewModelBase: Hashable {
    public init() { }
    
    public var sections: [ViewModelSection]!
    
    public func numberOfSections() -> Int {
        return sections.count
    }
    
    public func numberOfRows(in section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    public func item(for indexPath: IndexPath) -> FieldViewModel {
        return sections[indexPath.section].item(for: indexPath.row)
    }
    public static func == (lhs: TableViewModelBase,
                           rhs: TableViewModelBase) -> Bool {
        lhs.sections == rhs.sections
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(sections)
    }
}

public class ViewModelSection: Hashable {
    public var fields: [FieldViewModel]
    public var title: String
    
    public init(fields: [FieldViewModel], title: String = "") {
        self.fields = fields
        self.title = title
    }
    
    public func numberOfItems() -> Int {
        return fields.count
    }
    
    public func item(for rowId: Int) -> FieldViewModel {
        return fields[rowId]
    }
    
    public static func == (lhs: ViewModelSection,
                           rhs: ViewModelSection) -> Bool {
        lhs.fields == rhs.fields &&
        lhs.title == rhs.title
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(fields)
        hasher.combine(title)
    }
}

public class FieldViewModel: Hashable {
    public static func == (lhs: FieldViewModel,
                           rhs: FieldViewModel) -> Bool { true }
    
    public func hash(into hasher: inout Hasher) { }
}
