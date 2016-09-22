//
//  PokeCellCollectionViewCell.swift
//  pokedex
//
//  Created by Mohammad Movahednasab on 6/25/1395 AP.
//  Copyright © 1395 Movahed. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeNameLbl: UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5
    }
    
    func configureCell(pokemon: Pokemon){
        pokeImg.image = UIImage(named: "\(pokemon.pokemonID)")
        pokeNameLbl.text = pokemon.name.capitalizedString
    }
    
}
