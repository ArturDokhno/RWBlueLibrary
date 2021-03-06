//
//  PersistencyManager.swift
//  RWBlueLibrary
//
//  Created by Артур Дохно on 20.12.2021.
//  Copyright © 2021 Razeware LLC. All rights reserved.
//

import UIKit

final class PersistencyManager {
  
  private var albums = [Album]()
  
  init() {
    let savedURL = documents.appendingPathComponent(Filenames.Albums)
    var data = try? Data(contentsOf: savedURL)
    if data == nil, let bundleURL = Bundle.main.url(forResource: Filenames.Albums, withExtension: nil) {
      data = try? Data(contentsOf: bundleURL)
    }

    if let albumData = data,
      let decodedAlbums = try? JSONDecoder().decode([Album].self, from: albumData) {
      albums = decodedAlbums
      saveAlbums()
    }
  }

  func getAlbums() -> [Album] {
    return albums
  }
  
  func addAlbum(_ album: Album, at index: Int) {
    if albums.count >= index {
      albums.insert(album, at: index)
    } else {
      albums.append(album)
    }
  }
  
  func deleteAlbum(at index: Int) {
    albums.remove(at: index)
  }
  
  private var cache: URL {
    return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)[0]
  }
  
  func saveImage(_ image: UIImage, filename: String) {
    let url = cache.appendingPathComponent(filename)
    guard let data = image.pngData() else {
      return
    }
    try? data.write(to: url)
  }

  func getImage(with filename: String) -> UIImage? {
    let url = cache.appendingPathComponent(filename)
    guard let data = try? Data(contentsOf: url) else {
      return nil
    }
    return UIImage(data: data)
  }
  
  private var documents: URL {
    return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
  }

  private enum Filenames {
    static let Albums = "albums.json"
  }

  func saveAlbums() {
    let url = documents.appendingPathComponent(Filenames.Albums)
    let encoder = JSONEncoder()
    guard let encodedData = try? encoder.encode(albums) else {
      return
    }
    try? encodedData.write(to: url)
  }
  
}
