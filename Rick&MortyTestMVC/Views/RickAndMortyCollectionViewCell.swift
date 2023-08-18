//
//  RickAndMortyCollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import UIKit

class RickAndMortyCollectionViewCell: UICollectionViewCell {

  // MARK: - Public Properties

  static let reuseId = "rickAndMortyCell"

  // MARK: - Private Properties

  private let heroName: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = .white
    label.numberOfLines = 2
    label.adjustsFontSizeToFitWidth = true
    return label
  }()

  private let backgroundColorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    view.layer.cornerRadius = 16
    return view
  }()

  private let imageView: ImageView = {
    let image = ImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 10
    return image
  }()

  // MARK: - Cell Init
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupElements(backgroundColorView, imageView, heroName)
    setupSubViews(backgroundColorView, imageView, heroName)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  // MARK: - Configure
  func configureCell(with hero: RickAndMorty.Hero) {
    imageView.fetchImage(from: hero.image)
    heroName.text = hero.name
  }

  // MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      imageView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 8),
      imageView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 8),
      imageView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -8),
      imageView.heightAnchor.constraint(equalTo: backgroundColorView.heightAnchor, multiplier: 0.705),

      heroName.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 8),
      heroName.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -8),
      heroName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 8),
      heroName.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -8)
    ])
  }
}
