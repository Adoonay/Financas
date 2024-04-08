//
//  FinancasServiceFirebase.swift
//  Financas
//
//  Created by Adonay on 08/04/24.
//

import UIKit
import FirebaseFirestore

class FinancasServiceFirebase: FinancasServiceProtocol {
    var database: Firestore = Firestore.firestore()

    struct Constant {
        static let categoryKey = "categorias"
        static let entryKey = "lancamentos"
    }

    func addCategory(model: CategoryAddModel, completion: @escaping (Result<Category, ServiceError>) -> Void) {
        let path = database.collection(Constant.categoryKey).document()
        do {
            let category = Category(id: UUID().uuidString, name: model.name, description: model.description)
            try path.setData(from: category)
            completion(.success(category))
        } catch {
            completion(.failure(.badResponse(error)))
        }
    }
    
    func getCategories(completion: @escaping (Result<[Category], ServiceError>) -> Void) {
        let path = database.collection(Constant.categoryKey)
        fetchDocuments(path: path, completion: completion)
    }
    
    func addEntry(model: Entry, completion: @escaping (Result<Void, ServiceError>) -> Void) {
        let path = database.collection(Constant.entryKey).document()
        do {
            try path.setData(from: model)
            completion(.success(()))
        } catch {
            completion(.failure(.badResponse(error)))
        }
    }
    
    func getEntries(completion: @escaping (Result<[Entry], ServiceError>) -> Void) {
        let path = database.collection(Constant.entryKey)
        fetchDocuments(path: path, completion: completion)
    }

    func fetchDocuments<T: Codable>(path: CollectionReference, completion: @escaping (Result<[T], ServiceError>) -> Void) {
        path.getDocuments { query, error in
            if let error = error {
                completion(.failure(.badResponse(error)))
                return
            }

            guard let query = query else {
                completion(.failure(.invalidResponse))
                return
            }

            let documents = query.documents
            do {
                let parsedDocuments = try documents.compactMap({ try $0.data(as: T.self) })
                completion(.success(parsedDocuments))
            } catch {
                completion(.failure(.parseError))
            }
        }
    }
}
