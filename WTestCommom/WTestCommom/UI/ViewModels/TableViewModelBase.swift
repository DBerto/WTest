//
//  TableViewModelBase.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

open class TableViewModelBase {

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
}

public class ViewModelSection {
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
}

public class FieldViewModel { }
