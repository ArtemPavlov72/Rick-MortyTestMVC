//
//  DetailHeroPhotoCollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 18.08.2023.
//

import UIKit

class DetailHeroPhotoCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {

  //MARK: - Static Properties

  static let reuseId: String = "detailHeroPhotoCell"

  //MARK: - Private Properties

  private let heroImage: ImageView = {
    let image = ImageView()
    image.contentMode = .scaleAspectFill
    image.clipsToBounds = true
    image.layer.cornerRadius = 16
    return image
  }()

  private let heroNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.textColor = .white
    label.textAlignment = .center
    label.font = .boldSystemFont(ofSize: 22)
    return label
  }()

  private let heroStatusLabel: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.textColor = UIColor(red:0.27843, green:0.77647, blue:0.04314, alpha:1.00000)
    label.font = .systemFont(ofSize: 16)
    return label
  }()

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupElements(heroImage, heroNameLabel, heroStatusLabel)
    setupSubViews(heroImage, heroNameLabel, heroStatusLabel)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with data: Any) {
    guard let heroData = data as? RickAndMorty.Hero else { return }
    heroImage.fetchImage(from: heroData.image)
    heroNameLabel.text = heroData.name
    heroStatusLabel.text = heroData.status
  }

  // MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      heroImage.heightAnchor.constraint(equalToConstant: self.bounds.width * 0.45),
      heroImage.widthAnchor.constraint(equalToConstant: self.bounds.width * 0.45),
      heroImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),

      heroNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      heroNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      heroNameLabel.topAnchor.constraint(equalTo: heroImage.bottomAnchor, constant: 32),

      heroStatusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8),
      heroStatusLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8),
      heroStatusLabel.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor, constant: 16)
    ])
  }
}
