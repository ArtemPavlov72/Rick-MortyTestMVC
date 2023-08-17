//
//  RickAndMortyCollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import UIKit

class RickAndMortyCollectionViewCell: UICollectionViewCell {

  // MARK: - Public Properties
  let imageView: ImageView = {
    let image = ImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 15
    return image
  }()

  // MARK: - Cell Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupItem()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configure
  func configureCell(with hero: RickAndMorty.Hero) {
    imageView.fetchImage(from: hero.image)
  }

  // MARK: - Private Methods
  private func setupItem() {
    addSubview(imageView)
    imageView.constraintsFill(to: self)
  }
}

// MARK: - Setup Constraints
extension UIView {
  func constraintsFill(to view: UIView) {
    translatesAutoresizingMaskIntoConstraints = false

    NSLayoutConstraint.activate([
      topAnchor.constraint(equalTo: view.topAnchor),
      leadingAnchor.constraint(equalTo: view.leadingAnchor),
      bottomAnchor.constraint(equalTo: view.bottomAnchor),
      trailingAnchor.constraint(equalTo: view.trailingAnchor)
    ])
  }
}
