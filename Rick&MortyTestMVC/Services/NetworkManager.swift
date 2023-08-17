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

  func fetchData(from url: String, completion: @escaping(Result<RickAndMorty, NetworkError>) -> Void) {
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
              let rickAndMorty = try JSONDecoder().decode(RickAndMorty.self, from: data)
              DispatchQueue.main.async {
                  completion(.success(rickAndMorty))
              }
          } catch {
              completion(.failure(.decodingError))
          }
      } .resume()
  }
}
