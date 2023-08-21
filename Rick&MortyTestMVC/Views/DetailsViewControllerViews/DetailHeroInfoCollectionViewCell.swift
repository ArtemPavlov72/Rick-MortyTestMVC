//
//  DetailHeroInfoCollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 18.08.2023.
//

import UIKit

class DetailHeroInfoCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {

  //MARK: - Static Properties

  static let reuseId: String = "detailHeroInfoCell"

  //MARK: - Private Properties

  private let backgroundColorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    view.layer.cornerRadius = 16
    return view
  }()

  private let speciesLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor(red:0.76863, green:0.78824, blue:0.80784, alpha:1.00000)
    label.text = "Species:"
    return label
  }()

  private let speciesResultLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    return label
  }()

  private lazy var speciesStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.alignment = .fill
    stackView.addArrangedSubview(speciesLabel)
    stackView.addArrangedSubview(speciesResultLabel)
    return stackView
  }()

  private let typeLabel: UILabel = {
    let label = UILabel()
    label.text = "Type:"
    label.textColor = UIColor(red:0.76863, green:0.78824, blue:0.80784, alpha:1.00000)
    return label
  }()

  private let typeResultLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    return label
  }()

  private lazy var typeStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.alignment = .fill
    stackView.addArrangedSubview(typeLabel)
    stackView.addArrangedSubview(typeResultLabel)
    return stackView
  }()

  private let genderLabel: UILabel = {
    let label = UILabel()
    label.text = "Gender:"
    label.textColor = UIColor(red:0.76863, green:0.78824, blue:0.80784, alpha:1.00000)
    return label
  }()

  private let genderResultLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    return label
  }()

  private lazy var genderStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.alignment = .fill
    stackView.addArrangedSubview(genderLabel)
    stackView.addArrangedSubview(genderResultLabel)
    return stackView
  }()

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupElements(backgroundColorView, speciesStackView, typeStackView, genderStackView)
    setupSubViews(backgroundColorView, speciesStackView, typeStackView, genderStackView)
    setupConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func configure(with data: Any) {
    guard let heroData = data as? HeroInfo else { return }
    speciesResultLabel.text = heroData.species
    typeResultLabel.text = heroData.type != "" ? heroData.type :"None"
    genderResultLabel.text = heroData.gender
  }

  // MARK: - Setup Constraints

  private func setupConstraints() {
    NSLayoutConstraint.activate([
      backgroundColorView.topAnchor.constraint(equalTo: self.topAnchor),
      backgroundColorView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
      backgroundColorView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
      backgroundColorView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

      speciesStackView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 16),
      speciesStackView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      speciesStackView.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 16),

      typeStackView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 16),
      typeStackView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      typeStackView.topAnchor.constraint(equalTo: speciesStackView.bottomAnchor, constant: 16),

      genderStackView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 16),
      genderStackView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -16),
      genderStackView.topAnchor.constraint(equalTo: typeStackView.bottomAnchor, constant: 16),
      genderStackView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -16)
    ])
  }
}

