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
    case parseError
}

protocol FinancasServiceProtocol {
    func addCategory(model: CategoryAddModel, completion: @escaping (Result<Category, ServiceError>) -> Void)
    func getCategories(completion: @escaping (Result<[Category], ServiceError>) -> Void)

    func addEntry(model: Entry, completion: @escaping (Result<Void, ServiceError>) -> Void)
    func getEntries(completion: @escaping (Result<[Entry], ServiceError>) -> Void)
}

class FinancasServiceUserDefaults: FinancasServiceProtocol {
    var userDefaults: UserDefaults {
        return .standard
    }

    struct Constant {
        static let categoryKey = "categories"
        static let entryKey = "entries"
    }

    func addCategory(model: CategoryAddModel, completion: @escaping (Result<Category, ServiceError>) -> Void) {
        var categories: [Category] = userDefaults.object(key: Constant.categoryKey, [Category].self) ?? []
        let category = Category(id: UUID().uuidString, name: model.name, description: model.description)
        categories.append(category)
        userDefaults.save(categories, forKey: Constant.categoryKey)

        completion(.success(category))
    }

    func addEntry(model: Entry, completion: @escaping (Result<Void, ServiceError>) -> Void) {
        var entries: [Entry] = userDefaults.object(key: Constant.entryKey, [Entry].self) ?? []
        entries.append(model)
        userDefaults.save(entries, forKey: Constant.entryKey)

        completion(.success(()))
    }

    func getCategories(completion: @escaping (Result<[Category], ServiceError>) -> Void) {
        let categories: [Category] = userDefaults.object(key: Constant.categoryKey, [Category].self) ?? []
        completion(.success(categories))
    }

    func getEntries(completion: @escaping (Result<[Entry], ServiceError>) -> Void) {
        let entries: [Entry] = userDefaults.object(key: Constant.entryKey, [Entry].self) ?? []
        completion(.success(entries))
    }
}

extension UserDefaults {
    func save<T: Encodable>(_ object: T, forKey key: String) {
        if let data = try? JSONEncoder().encode(object) {
            set(data, forKey: key)
        }
    }

    func object<T: Decodable>(key: String, _ type: T.Type) -> T? {
        if let data = data(forKey: key) {
            return try? JSONDecoder().decode(T.self, from: data)
        }

        return nil
    }
}
