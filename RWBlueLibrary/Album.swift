//
//  Album.swift
//  RWBlueLibrary
//
//  Created by Артур Дохно on 20.12.2021.
//  Copyright © 2021 Razeware LLC. All rights reserved.
//

import Foundation

struct Album: Codable {
  let title : String
  let artist : String
  let genre : String
  let coverUrl : String
  let year : String
}

extension Album: CustomStringConvertible {
  var description: String {
    return "title: \(title)" +
      " artist: \(artist)" +
      " genre: \(genre)" +
      " coverUrl: \(coverUrl)" +
    " year: \(year)"
  }
}

typealias AlbumData = (title: String, value: String)

extension Album {
  var tableRepresentation: [AlbumData] {
    return [
      ("Artist", artist),
      ("Album", title),
      ("Genre", genre),
      ("Year", year)
    ]
  }
}

