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
  private var heros: [RickAndMorty.Hero] = []

  // MARK: - Life Cycles Methods

  override func viewDidLoad() {
    super.viewDidLoad()
    setupNavigationBar()
    applyDefaultBehavior()
    collectionView.register(RickAndMortyCollectionViewCell.self,
                            forCellWithReuseIdentifier: RickAndMortyCollectionViewCell.reuseId)
    fetchData(from: Link.rickAndMorty.rawValue)
  }

  // MARK: - Private Methods

  private func setupNavigationBar() {
    let appearance = Appearance()
    title = appearance.navigationBarTitle
    navigationController?.navigationBar.prefersLargeTitles = true
  }

  private func fetchData(from url: String) {
    NetworkManager.shared.fetchData(dataType: RickAndMorty.self, from: url) { [weak self] result in

      switch result {
      case .success(let rickAndMorty):
        self?.rickAndMorty = rickAndMorty
        rickAndMorty.results.forEach { self?.heros.append($0) }
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
    heros.count
  }

  override func collectionView(_ collectionView: UICollectionView,
                               cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RickAndMortyCollectionViewCell.reuseId,
                                                        for: indexPath) as? RickAndMortyCollectionViewCell else {
      return RickAndMortyCollectionViewCell()
    }
    cell.configureCell(with: self.heros[indexPath.item])
    return cell
  }
}

// MARK: - UICollectionViewDelegate

extension MainViewController {
  override func collectionView(_ collectionView: UICollectionView,
                               willDisplay cell: UICollectionViewCell,
                               forItemAt indexPath: IndexPath) {
    if indexPath.item == (heros.count) - 2 {
      fetchData(from: rickAndMorty?.info.next ?? "")
    }
  }

  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let heroDetailVC = HeroDetailsViewController()
    heroDetailVC.hero = heros[indexPath.item]
    show(heroDetailVC, sender: nil)
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
    let heightPerItem = widthPerItem * 1.295
    return CGSize(width: widthPerItem, height: heightPerItem)
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
    let backGroundColor: UIColor = UIColor(red:0.01569, green:0.04706, blue:0.11765, alpha:1.00000)
    let leftInsert: CGFloat = 20
    let rightInsert: CGFloat = 20
    let topInsert: CGFloat = 20
    let bottonInsert: CGFloat = 20
    let numberOfItemsPerRow: CGFloat = 2
    let minimumLineSpacing: CGFloat = 20
    let minimumInterItemSpacing: CGFloat = 20
  }
}
