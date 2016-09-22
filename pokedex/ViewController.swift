//
//  ViewController.swift
//  pokedex
//
//  Created by Mohammad Movahednasab on 6/24/1395 AP.
//  Copyright © 1395 Movahed. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var isFiltered = false
    var pokemons = [Pokemon]()
    var pokemonFiltered = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        loadPokemonCSV()
        initMusic()
        searchBar.returnKeyType = UIReturnKeyType.Done
    }

    func initMusic(){
        
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")
        do{
            musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path!)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
    }
    
    func loadPokemonCSV(){
        let url = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")
        do{
            let csv = try CSV(contentsOfURL: url!)
            let rows = csv.rows
            for row in rows{
                let name = row["identifier"]!
                let id = Int(row["id"]!)!
                let poke  = Pokemon(name: name, ID: id)
                pokemons.append(poke)
                
            }
            
        }catch let err as NSError{
            print(err.debugDescription)
        }
        
  
        
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltered == true{
            return pokemonFiltered.count
        }
        return pokemons.count
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell{
            
            if (isFiltered == true){
                cell.configureCell(pokemonFiltered[indexPath.row])
            }else{
                cell.configureCell(pokemons[indexPath.row])
            }
            return cell
            
        }else{
            return UICollectionViewCell()
        }
        
        
        
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text != nil && searchBar.text != "" {
            pokemonFiltered = pokemons.filter({$0.name.rangeOfString(searchBar.text!.lowercaseString) != nil})
            isFiltered = true
            collectionView.reloadData()
          

        }
        else{
            isFiltered = false
            collectionView.reloadData()
            view.endEditing(true)
        }
        
        func searchBarSearchButtonClicked(searchBar: UISearchBar){
            view.endEditing(true)
        }
    }
//
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let poke: Pokemon!
        if isFiltered == true{
            poke = pokemonFiltered[indexPath.row]
        }else{
            poke = pokemons[indexPath.row]
        }
        performSegueWithIdentifier("PokemonDetailVC", sender: poke)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detailVC = segue.destinationViewController as? PokemonDetailVC{
                if let poke = sender as? Pokemon{
                    detailVC.pokemon = poke
                }
                
            }
        }
        
    }

}

