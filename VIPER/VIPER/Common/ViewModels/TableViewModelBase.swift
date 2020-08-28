//
//  TableViewModelBase.swift
//  VIPER
//
//  Created by David Manuel da Costa Berto on 28/08/2020.
//  Copyright © 2020 David Manuel da Costa Berto. All rights reserved.
//

import Foundation

class TableViewModelBase {
    var sections: [ViewModelSection]!
    
    func numberOfSections() -> Int {
        return sections.count
    }
    
    func numberOfRows(in section: Int) -> Int {
        return sections[section].numberOfItems()
    }
    
    func item(for indexPath: IndexPath) -> Field {
        return sections[indexPath.section].item(for: indexPath.row)
    }
}

class ViewModelSection {
    var fields: [Field]
    var title: String
    
    init(fields: [Field], title: String = "") {
        self.fields = fields
        self.title = title
    }
    
    func numberOfItems() -> Int {
        return fields.count
    }
    
    func item(for rowId: Int) -> Field {
        return fields[rowId]
    }
}

protocol Field {
    
}
