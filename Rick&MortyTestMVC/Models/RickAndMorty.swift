//
//  RickAndMorty.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import Foundation

struct RickAndMorty: Decodable {
  let info: Info
  let results: [Hero]
  
  struct Info: Decodable {
    let pages: Int
    let next: String?
    let prev: String?
  }
  
  struct Hero: Decodable, Hashable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String?
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    
    struct Location: Decodable, Hashable {
      let name: String
      let url: String?
    }
  }
}

struct LocationType: Decodable, Hashable {
  let name: String
  let type: String
}

struct Episode: Decodable, Hashable {
  let name: String?
  let airDate: String?
  let episode: String?
}

struct EpisodeURL: Hashable {
  let episode: [String]
}

struct HeroInfo: Hashable {
  let species: String?
  let type: String?
  let gender: String?
}
