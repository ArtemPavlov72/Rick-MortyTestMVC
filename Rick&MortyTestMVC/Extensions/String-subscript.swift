//
//  String-subscript.swift
//  Rick&MortyTestMVC
//
//  Created by Artem Pavlov on 21.08.2023.
//

import Foundation

extension String {
    public subscript(_ index: Int) -> Character {
        self[self.index(self.startIndex, offsetBy: index)]
    }
}
