//
//  DetailHeroEpisodeCollectionViewCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 21.08.2023.
//

import UIKit

class DetailHeroEpisodeCollectionViewCell: UICollectionViewCell, SelfConfiguringCell {
  
  //MARK: - Static Properties
  
  static let reuseId: String = "episodeHeroInfoCell"
  
  //MARK: - Private Properties
  
  private let backgroundColorView: UIView = {
    let view = UIView()
    view.backgroundColor = UIColor(red:0.14902, green:0.16471, blue:0.21961, alpha:1.00000)
    view.layer.cornerRadius = 16
    return view
  }()
  
  private let episodeNameLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .bold))
    label.textColor = .white
    return label
  }()
  
  private let episodeInfoLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 13, weight: .regular))
    label.textColor = UIColor(red:0.27843, green:0.77647, blue:0.04314, alpha:1.00000)
    return label
  }()
  
  private let episodeDateLabel: UILabel = {
    let label = UILabel()
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 12, weight: .regular))
    label.textColor = UIColor(red:0.57647, green:0.59608, blue:0.61176, alpha:1.00000)
    return label
  }()
  
  private lazy var horisontalStackView: UIStackView = {
    let stackView = UIStackView()
    stackView.axis = NSLayoutConstraint.Axis.horizontal
    stackView.alignment = .fill
    stackView.addArrangedSubview(episodeInfoLabel)
    stackView.addArrangedSubview(episodeDateLabel)
    return stackView
  }()
  
  //MARK: - Init
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupElements(backgroundColorView, episodeNameLabel, horisontalStackView)
    setupSubViews(backgroundColorView, episodeNameLabel, horisontalStackView)
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with data: Any) {
    guard let episodeURL = data as? String else { return }
    fetchData(from: episodeURL )
  }
  
  // MARK: - Fetch Data
  
  private func fetchData(from url: String) {
    NetworkManager.shared.fetchData(dataType: Episode.self, from: url) { [weak self] result in
      
      switch result {
      case .success(let episode):
        self?.episodeNameLabel.text = episode.name
        self?.episodeInfoLabel.text = episode.episode
        self?.episodeDateLabel.text = episode.air_date
      case .failure(let error):
        self?.episodeNameLabel.text = "No info =("
        self?.episodeInfoLabel.text = "No info =("
        self?.episodeDateLabel.text = "No info =("
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
      
      episodeNameLabel.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 8),
      episodeNameLabel.topAnchor.constraint(equalTo: backgroundColorView.topAnchor, constant: 10),
      episodeNameLabel.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -8),
      
      horisontalStackView.leadingAnchor.constraint(equalTo: backgroundColorView.leadingAnchor, constant: 8),
      horisontalStackView.bottomAnchor.constraint(equalTo: backgroundColorView.bottomAnchor, constant: -10),
      horisontalStackView.trailingAnchor.constraint(equalTo: backgroundColorView.trailingAnchor, constant: -8)
    ])
  }
}
