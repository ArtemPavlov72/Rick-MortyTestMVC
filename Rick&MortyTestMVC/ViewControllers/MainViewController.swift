//
//  MainViewController.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 17.08.2023.
//

import UIKit

class MainViewController: UICollectionViewController {

  // MARK: - Private Properties

  private var rickAndMorty: RickAndMorty?
  private let cellID = "cell"

  // MARK: - Life Cycles Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    applyDefaultBehavior()
    collectionView.register(RickAndMortyCollectionViewCell.self, forCellWithReuseIdentifier: cellID)
    fetchData()
  }

  // MARK: - Private Methods

  private func setupNavigationBar() {
    let appearance = Appearance()
    title = appearance.navigationBarTitle
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  private func fetchData() {
    NetworkManager.shared.fetchData(from: Link.rickAndMorty.rawValue) { [weak self] result in
      switch result {
      case .success(let rickAndMorty):
        self?.rickAndMorty = rickAndMorty
        self?.collectionView.reloadData()
      case .failure(let error):
        print(error)
      }
    }
  }

  private func applyDefaultBehavior() {
    let appearance = Appearance()
    collectionView.backgroundColor = appearance.backGroundColor
  }
}

// MARK: - UICollectionViewDataSource
extension MainViewController {

  override func collectionView(_ collectionView: UICollectionView,
                               numberOfItemsInSection section: Int) -> Int {
    rickAndMorty?.results.count ?? 0
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as? RickAndMortyCollectionViewCell else {
      return RickAndMortyCollectionViewCell()
    }

    if let hero = rickAndMorty?.results[indexPath.item] {
      cell.configureCell(with: hero)
    }

    return cell
  }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      sizeForItemAt indexPath: IndexPath) -> CGSize {
    let appearance = Appearance()
    let paddingWidth = 20 * (appearance.numberOfItemsPerRow + 1)
    let avaibleWidth = collectionView.frame.width - paddingWidth
    let widthPerItem = avaibleWidth / appearance.numberOfItemsPerRow
    return CGSize(width: widthPerItem, height: widthPerItem)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      insetForSectionAt section: Int) -> UIEdgeInsets {
    let appearance = Appearance()
    return UIEdgeInsets(top: appearance.topInsert,
                        left: appearance.leftInsert,
                        bottom: appearance.bottonInsert,
                        right: appearance.rightInsert)
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumLineSpacingForSectionAt section: Int) -> CGFloat {
    let appearance = Appearance()
    return appearance.minimumLineSpacing
  }

  func collectionView(_ collectionView: UICollectionView,
                      layout collectionViewLayout: UICollectionViewLayout,
                      minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
    let appearance = Appearance()
    return appearance.minimumInterItemSpacing
  }
}

// MARK: - Appearance

private extension MainViewController {
  struct Appearance {
    let navigationBarTitle = "Characters"
    let backGroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)

    let leftInsert: CGFloat = 20
    let rightInsert: CGFloat = 20
    let topInsert: CGFloat = 20
    let bottonInsert: CGFloat = 20
    let numberOfItemsPerRow: CGFloat = 2
    let minimumLineSpacing: CGFloat = 20
    let minimumInterItemSpacing: CGFloat = 20
  }
}
