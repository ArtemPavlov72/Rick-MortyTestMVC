//
//  ImageView.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import UIKit

class ImageView: UIImageView {

  //MARK: - Private Properties

  private var spinnerView: UIActivityIndicatorView?

  //MARK: - Public Methods

  func fetchImage(from url: String) {
    guard let url = URL(string: url) else {
      image = UIImage(named: "no_image")
      return
    }

    if let cachedImage = getCachedImage(from: url) {
      image = cachedImage
      return
    }

    spinnerView = showSpinner(in: self)

    ImageManager.shared.loadImageWithCache(from: url) { data, response in
      self.image = UIImage(data: data)
      self.spinnerView?.stopAnimating()
      self.saveDataToCache(with: data, and: response)
    }
  }
}

// MARK: - Private Methods

private extension ImageView {

  func saveDataToCache(with data: Data, and response: URLResponse) {
    guard let url = response.url else {return}
    let request = URLRequest(url: url)
    let cachedResponse = CachedURLResponse(response: response, data: data)
    URLCache.shared.storeCachedResponse(cachedResponse, for: request)
  }

  func getCachedImage(from url: URL) -> UIImage? {
    let request = URLRequest(url: url)
    if let cachedResponse = URLCache.shared.cachedResponse(for: request) {
      return UIImage(data: cachedResponse.data)
    }
    return nil
  }
}
