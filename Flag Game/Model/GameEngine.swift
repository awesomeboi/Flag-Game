//
//  GameEngine.swift
//  Flag Game
//
//  Created by Volkan Sahin on 9.12.2019.
//  Copyright © 2019 Volkan Sahin. All rights reserved.
//

import Foundation

struct GameEngine {
    
    let fm = FileManager.default
    let path = Bundle.main.resourcePath!
    
    //Asign all files to "items" named constant
    func CreateCountryArray() -> [String]{
        let items = try! self.fm.contentsOfDirectory(atPath: self.path)
        let countries = Country(items: items).items
        return countries
    }
    
}
