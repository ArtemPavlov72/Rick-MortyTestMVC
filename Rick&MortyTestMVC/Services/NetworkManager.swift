//
//  NetworkManager.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {

    static let shared = NetworkManager()

    private init() {}

  func fetchData<T: Decodable>(dataType: T.Type, from url: String, completion: @escaping(Result<T, NetworkError>) -> Void) {
      guard let url = URL(string: url) else {
          completion(.failure(.invalidURL))
          return
      }

      URLSession.shared.dataTask(with: url) { data, _, error in
          guard let data = data else {
              completion(.failure(.noData))
              print(error?.localizedDescription ?? "no description")
              return
          }

          do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
              let type = try decoder.decode(T.self, from: data)
              DispatchQueue.main.async {
                  completion(.success(type))
              }
          } catch {
              completion(.failure(.decodingError))
          }
      } .resume()
  }
}
