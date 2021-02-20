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
  let casts: [Casts]
  
}

struct Genres: Decodable {
  let name: String
}

struct Casts: Decodable {
  let name: String
}
