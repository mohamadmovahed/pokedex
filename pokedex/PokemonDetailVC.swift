//
//  PokemonDetailVC.swift
//  pokedex
//
//  Created by Mohammad Movahednasab on 6/26/1395 AP.
//  Copyright © 1395 Movahed. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {

    var pokemon: Pokemon!
    
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var pokeImg: UIImageView!
    @IBOutlet weak var pokeDescLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenseLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var podexIDLbl: UILabel!
    @IBOutlet weak var baseAttackLbl: UILabel!
    @IBOutlet weak var evolLbl: UILabel!
    @IBOutlet weak var preImg: UIImageView!
    @IBOutlet weak var nextImg: UIImageView!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokeImg.image = UIImage(named: "\(pokemon.pokemonID)")
        preImg.image = UIImage(named: "\(pokemon.pokemonID)")
        pokemon.downloadPokemonDetails {
            print("Hi IAm HERE")
            self.updateUI()
        }
        // Do any additional setup after loading the view.
    }

    func updateUI(){
        nameLbl.text = pokemon.name
        pokeDescLbl.text = pokemon.description
        typeLbl.text = pokemon.type
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        podexIDLbl.text = "\(pokemon.pokemonID)"
        baseAttackLbl.text = pokemon.attack
        evolLbl.text = pokemon.nextEvolName
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func onBackPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
