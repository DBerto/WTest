//
//  PostalCodeResponse.swift
//  WTestAPI
//
//  Created by David Berto on 21/09/2021.
//

import Foundation

public struct PostalCodeResponse: ModelDtoProtocol {
    public let nomeLocalidade: String?
    public let numCodPostal: String?
    public let extCodPostal: String?
    public let desigPostal: String?
    
    public init(nomeLocalidade: String,
                numCodPostal: String,
                extCodPostal: String,
                desigPostal: String) {
        self.nomeLocalidade = nomeLocalidade
        self.numCodPostal = numCodPostal
        self.extCodPostal = extCodPostal
        self.desigPostal = desigPostal
    }
    
    enum CodingKeys: String, CodingKey {
        case nomeLocalidade = "nome_localidade"
        case numCodPostal = "num_cod_postal"
        case extCodPostal = "ext_cod_postal"
        case desigPostal = "desig_postal"
    }
}
