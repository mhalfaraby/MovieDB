//
//  File.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 20/02/21.
//

import Foundation

struct Detail: Decodable {
  let title: String
  let runtime: Int
  let genres: [Genres]
  let overview: String
  let poster_path: String
//  let cast: [Casts]
  
}

struct Genres: Decodable {
  let name: String
}


struct Cast:Decodable {
  let cast: [Casts]
}

struct Casts: Decodable {
  let name: String?
  let profile_path: String?
}



