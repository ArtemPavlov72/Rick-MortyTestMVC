//
//  UICollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import UIKit

extension UICollectionViewCell {
  func setupElements(_ subViews: UIView...) {
    subViews.forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }
  }

  func setupSubViews(_ subViews: UIView...) {
    subViews.forEach {
      self.addSubview($0)
    }
  }
}
