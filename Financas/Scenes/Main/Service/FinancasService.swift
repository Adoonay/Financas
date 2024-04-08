//
//  FinancasService.swift
//  Financas
//
//  Created by Adonay on 04/04/24.
//

import Foundation

enum ServiceError: Error {
    case invalidRequest
    case invalidResponse
    case badResponse(Error)
    case parseError
}

protocol FinancasServiceProtocol {
    func addCategory(model: CategoryAddModel, completion: @escaping (Result<Category, ServiceError>) -> Void)
    func getCategories(completion: @escaping (Result<[Category], ServiceError>) -> Void)

    func addEntry(model: Entry, completion: @escaping (Result<Void, ServiceError>) -> Void)
    func getEntries(completion: @escaping (Result<[Entry], ServiceError>) -> Void)
}
