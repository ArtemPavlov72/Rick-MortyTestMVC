//
//  SelfConfiguringCell.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 18.08.2023.
//

import Foundation

protocol SelfConfiguringCell {
    static var reuseId: String { get }
    func configure(with data: Any)
}
