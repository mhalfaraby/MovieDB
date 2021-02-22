//
//  MovieModel.swift
//  MovieDB
//
//  Created by MUHAMMAD ALFARABY on 15/02/21.
//

import Foundation

struct MovieModel: Decodable {
  let results: [Movies]
}

struct Movies: Decodable {
  let backdrop_path: String
  let poster_path: String
  let id: Int
  let title: String
}
