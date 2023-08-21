//
//  HeroDetailsViewController.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 18.08.2023.
//

import UIKit

class HeroDetailsViewController: UIViewController {

  //MARK: - Public Properties

  var hero: RickAndMorty.Hero?
  var heroInfo: HeroInfo?

  //MARK: - Private Properties

  private var dataSource: UICollectionViewDiffableDataSource<Section, AnyHashable>?
  private var collectionView: UICollectionView!

  // MARK: - Life Cycles Methods
  
  override func viewDidLoad() {
    super.viewDidLoad()

    heroInfo = HeroInfo(species: hero?.species, type: hero?.type, gender: hero?.gender)
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
    collectionView.register(Header.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: Header.reuseId)
    collectionView.register(DetailHeroPhotoCollectionViewCell.self,
                            forCellWithReuseIdentifier: DetailHeroPhotoCollectionViewCell.reuseId)
    collectionView.register(DetailHeroInfoCollectionViewCell.self,
                            forCellWithReuseIdentifier: DetailHeroInfoCollectionViewCell.reuseId)
    collectionView.register(DetailHeroOriginCollectionViewCell.self,
                            forCellWithReuseIdentifier: DetailHeroOriginCollectionViewCell.reuseId)
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
      case .heroInfo:
        return configure(DetailHeroInfoCollectionViewCell.self, with: heroInfo, for: indexPath)
      case .origin:
        return configure(DetailHeroOriginCollectionViewCell.self, with: hero?.origin, for: indexPath)
      }
    }

    dataSource?.supplementaryViewProvider = { collectionView, kind, indexPath in
      guard let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: Header.reuseId, for: indexPath) as? Header else { return Header() }
      guard let item = self.dataSource?.itemIdentifier(for: indexPath) else { return Header() }
      guard let section = self.dataSource?.snapshot().sectionIdentifier(containingItem: item) else { return Header() }
      sectionHeader.title.text = section.rawValue
      return sectionHeader
    }

    dataSource?.apply(generateSnapshot(), animatingDifferences: true)


  }

  private func generateSnapshot() -> NSDiffableDataSourceSnapshot<Section, AnyHashable>  {
    var snapshot = NSDiffableDataSourceSnapshot<Section, AnyHashable>()

    snapshot.appendSections([Section.heroImage])
    snapshot.appendItems([hero], toSection: .heroImage)

    snapshot.appendSections([Section.heroInfo])
    snapshot.appendItems([heroInfo], toSection: .heroInfo)

    snapshot.appendSections([Section.origin])
    snapshot.appendItems([hero?.origin], toSection: .origin)

    return snapshot
  }

  // MARK: - Setup Layout

  private func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
      let section = Section.allCases[sectionIndex]

      switch section {
      case .heroImage:
        return self.createHeroPhotoSection()
      case .heroInfo:
        return self.createHeroInfoSection()
      case .origin:
        return self.createHeroOriginSection()
      }
    }

    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 16
    layout.configuration = config

    return layout
  }

  private func createHeroPhotoSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.35))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

    let layoutSection = NSCollectionLayoutSection(group: group)

    return layoutSection
  }

  private func createHeroInfoSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.15))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

    let layoutSection = NSCollectionLayoutSection(group: group)
    layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 24, bottom: 0, trailing: 24)

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    header.pinToVisibleBounds = true

    layoutSection.boundarySupplementaryItems = [header]

    return layoutSection
  }

  private func createHeroOriginSection() -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                          heightDimension: .fractionalHeight(1))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)

    let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.10))
    let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])

    let layoutSection = NSCollectionLayoutSection(group: group)
    layoutSection.contentInsets = NSDirectionalEdgeInsets.init(top: 0, leading: 24, bottom: 0, trailing: 24)

    let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(30))
    let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
    header.pinToVisibleBounds = true

    layoutSection.boundarySupplementaryItems = [header]

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
    case heroInfo = "Info"
    case origin = "Origin"
  }
}
