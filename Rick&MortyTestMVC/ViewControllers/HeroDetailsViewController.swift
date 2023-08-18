//
//  HeroDetailsViewController.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 18.08.2023.
//

import UIKit

class HeroDetailsViewController: UIViewController {

  //MARK: - Private Properties

  var hero: RickAndMorty.Hero?
  private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
  private var collectionView: UICollectionView!

  override func viewDidLoad() {
    super.viewDidLoad()
    setupCollectionView()
    applyDefaultBehavior()
    createDataSource()
  }

  // MARK: - Private Methods

  private func applyDefaultBehavior() {
    let appearance = Appearance()
    collectionView.backgroundColor = appearance.backGroundColor
  }

  private func setupCollectionView() {
    collectionView = UICollectionView(frame: view.bounds,
                                      collectionViewLayout: createCompositionalLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    view.addSubview(collectionView)
    collectionView.register(DetailHeroPhotoCollectionViewCell.self,
                            forCellWithReuseIdentifier: DetailHeroPhotoCollectionViewCell.reuseId)
  }

  // MARK: - Manage the Data

  private func configure<T: SelfConfiguringCell>(_ cellType: T.Type, with data: AnyHashable, for indexPath: IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseId, for: indexPath) as? T else {
      fatalError("Unable to dequeue \(cellType)")
    }
    cell.configure(with: data)
    return cell
  }

  private func createDataSource() {
    dataSource = UICollectionViewDiffableDataSource<Section, AnyHashable>(collectionView: collectionView) { [self]
      collectionView, indexPath, _ in

      let sections = Section.allCases[indexPath.section]

      switch sections {
      case .heroImage:
        return configure(DetailHeroPhotoCollectionViewCell.self, with: hero, for: indexPath)
      }
    }
    dataSource?.apply(generateSnapshot(), animatingDifferences: true)
  }

  private func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable>  {
    var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

    snapshot.appendSections([Section.heroImage])
    snapshot.appendItems([hero], toSection: .heroImage)

    return snapshot
  }

  // MARK: - Setup Layout

  private func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      let section = Section.allCases[sectionIndex]

      switch section {
      case .heroImage:
        return self.createHeroPhotoSection()
      }
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 8
    layout.configuration = config
//    layout.register(RoundedBackgroundView.self, forDecorationViewOfKind: RoundedBackgroundView.reuseId)

    return layout
  }

  private func createHeroPhotoSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.45))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

    let layoutSection = NSCollectionLayoutSection(group: group)
    layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 0)

    return layoutSection
  }

}

// MARK: - Appearance

private extension HeroDetailsViewController {
  struct Appearance {
    let backGroundColor: UIColor = UIColor(red:0.01569, green:0.04706, blue:0.11765, alpha:1.00000)
  }
}

// MARK: - Section

private extension HeroDetailsViewController {
  enum Section: String, Hashable, CaseIterable {
    case heroImage
  }
}
