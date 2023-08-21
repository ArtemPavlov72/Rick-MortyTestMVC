//
//  DetailHeroOriginCollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 21.08.2023.
//

import UIKit

class DetailHeroOriginCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {

  //MARK: - Static Properties

  static let reuseId: String = "originHeroInfoCell"

  //MARK: - Private Properties

  private let backgroundColorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    view.layer.cornerRadius = 16
    return view
  }()

  private let imageBackgroundColorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.09804, green:0.10980, blue:0.16471, alpha:1.00000)
    view.layer.cornerRadius = 10
    return view
  }()

  private let imageView: UIImageView = {
    let image = UIImageView()
    image.layer.cornerRadius = 10
    return image
  }()

  private let locationLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .bold))
    label.textColor = .white
    return label
  }()

  private let planetLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor(red:0.27843, green:0.77647, blue:0.04314, alpha:1.00000)
    return label
  }()

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupElements(backgroundColorView, imageBackgroundColorView, imageView, locationLabel, planetLabel)
    setupSubViews(backgroundColorView, imageBackgroundColorView, imageView, locationLabel, planetLabel)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with data: Any) {
    guard let locationData = data as? RickAndMorty.Hero.Location else { return }

    fetchData(from: locationData.url ?? "")
  }

  // MARK: - Fetch Data

  private func fetchData(from url: String) {
    NetworkManager.shared.fetchData(dataType: LocationType.self, from: url) { [weak self] result in

      switch result {
      case .success(let location):
        self?.imageView.image = UIImage(named: "locationImage")
        self?.locationLabel.text = location.name
        self?.planetLabel.text = location.type
      case .failure(let error):
        self?.imageView.image = UIImage(named: "locationImage")
        self?.locationLabel.text = "No info =("
        self?.planetLabel.text = "No info =("
        print(error)
      }
    }
  }

  // MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      imageBackgroundColorView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 8),
      imageBackgroundColorView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 8),
      imageBackgroundColorView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -8),
      imageBackgroundColorView.widthAnchor.constraint(equalToConstant: 64),
      imageBackgroundColorView.heightAnchor.constraint(equalToConstant: 64),

      imageView.centerXAnchor.constraint(equalTo: imageBackgroundColorView.centerXAnchor),
      imageView.centerYAnchor.constraint(equalTo: imageBackgroundColorView.centerYAnchor),
      imageView.widthAnchor.constraint(equalToConstant: 24),
      imageView.heightAnchor.constraint(equalToConstant: 24),

      locationLabel.leadingAnchor.constraint(equalTo: imageBackgroundColorView.trailingAnchor, constant: 16),
      locationLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      locationLabel.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 8),

      planetLabel.leadingAnchor.constraint(equalTo: imageBackgroundColorView.trailingAnchor, constant: 16),
      planetLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      planetLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 16),
      planetLabel.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -16)
    ])
  }
}
