//
//  File.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 20/02/21.
//

import Foundation

struct Detail: Codable {
  let title: String
  let runtime: Int
  let genres: [Genres]
  let overview: String
  let poster_path: String
  let backdrop_path: String
//  let cast: [Casts]
  
}

struct Genres: Codable {
  let name: String
}


struct Cast:Codable {
  let cast: [Casts]
}

struct Casts: Codable {
  let name: String?
  let profile_path: String?
}



