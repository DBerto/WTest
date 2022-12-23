//
//  PGOutput.swift
//  WTestCommon
//
//  Created by Berto, David Manuel  on 23/12/2022.
//

import Foundation

struct PGOutput {
    let pdfData: Data
    let pdfUrl: URL
    let fileName: String
}

typealias PGCompletion = (PGOutput) -> Void
