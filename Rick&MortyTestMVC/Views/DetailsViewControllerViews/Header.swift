//
//  Header.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 21.08.2023.
//

import UIKit

class Header: UICollectionReusableView {

  static let reuseId: String = "headerSectionId"

  let title: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.font = UIFontMetrics.default.scaledFont(for: UIFont.systemFont(ofSize: 17, weight: .bold))
    return label
  }()

  //MARK: - Init

  override init(frame: CGRect) {
    super.init(frame: frame)
    setupConstraints()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("Stop trying to make storyboards happen.")
  }

  // MARK: - Setup Constraints

  private func setupConstraints() {
    title.translatesAutoresizingMaskIntoConstraints = false
    addSubview(title)

    NSLayoutConstraint.activate([
      title.leadingAnchor.constraint(equalTo: leadingAnchor),
      title.topAnchor.constraint(equalTo: topAnchor),
      title.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
    ])
  }
}
