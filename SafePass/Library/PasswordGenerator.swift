//
//  PasswordGenerator.swift
//  SafePass
//
//  Created by armin on 10/28/19.
//  Copyright © 2019 shalchian. All rights reserved.
//

import Foundation

public typealias CharactersArray = [Character]
public typealias CharactersHash = [CharactersGroup : CharactersArray]

public class PasswordGenerator {

    private var hash: CharactersHash = [:]

    public static let sharedInstance = PasswordGenerator()

    private init() {
        self.hash = CharactersGroup.hash
    }

    public func generateBasicPassword() -> String {
        return generatePassword(includeNumbers: true, includePunctuation: false, includeSymbols: false, length: 8)
    }

    public func generateComplexPassword() -> String {
        return generatePassword(includeNumbers: true, includePunctuation: true, includeSymbols: true, length: 16)
    }

    private func charactersForGroup(group: CharactersGroup) -> CharactersArray {
        if let characters = hash[group] {
            return characters
        }
        assertionFailure("Characters should always be defined")
        return []
    }

    public func generatePassword(includeNumbers: Bool = true, includePunctuation: Bool = true, includeSymbols: Bool = true, length: Int = 16) -> String {

        var characters: CharactersArray = []
        characters.append(contentsOf: charactersForGroup(group: .Letters))
        if includeNumbers {
            characters.append(contentsOf: charactersForGroup(group: .Numbers))
        }
        if includePunctuation {
            characters.append(contentsOf: charactersForGroup(group: .Punctuation))
        }
        if includeSymbols {
            characters.append(contentsOf: charactersForGroup(group: .Symbols))
        }

        var passwordArray: CharactersArray = []

        while passwordArray.count < length {
            let index = Int(arc4random()) % (characters.count - 1)
            passwordArray.append(characters[index])
        }

        let password = String(passwordArray)

        return password
    }

}
