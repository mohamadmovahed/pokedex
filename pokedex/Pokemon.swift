//
//  Pokemon.swift
//  pokedex
//
//  Created by Mohammad Movahednasab on 6/24/1395 AP.
//  Copyright © 1395 Movahed. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon{
    private var _name: String!
    private var _pokemonID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolName: String!
    private var _nextEvolID: String!
    private var _nextEvolLvl: String!
    private var _pokemonURL: String!
    
    
    
    init(name: String, ID: Int)
    {
        _name = name
        _pokemonID = ID
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokemonID)/"
    }
    
    var name: String{
        return _name
    }
    
    var pokemonID: Int{
    return _pokemonID
    }

    var description: String{
        return _description
    }
    
    var type: String{
        return _type
    }
    
    var defense: String{
        return _defense
    }
    
    var height: String{
        return _height
    }
    
    var weight: String{
        return _weight
    }
    
    var attack: String{
        return _attack
    }

    var nextEvolName: String{
        return _nextEvolName
    }
    
    var nextEvolID: String{
        return _nextEvolID
    }
    
    var nextEvolLvl: String{
        return _nextEvolLvl
    }
    
    
    func downloadPokemonDetails(completed: ()->()){
        
        let url = NSURL(string: _pokemonURL)!
        
        Alamofire.request(.GET, url).responseJSON{response in
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                    print(weight)
                }
                
                if let height = dict["height"] as? String{
                    self._height = height
                }
                if let attack = dict["attack"] as? Int{
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int{
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String,String>]{
                    self._type = ""
                    for type in types{
                        if type["name"] != nil && type["name"] != ""{
                        self._type =  "\(self._type)/\(type["name"]!)"
                        }
                    }
                }
                
                
                if let dsc = dict["descriptions"] as? [Dictionary<String,String>] where dsc.count > 0{
                    if let dscURL = dsc[0]["resource_uri"]{
                    let nsurl = NSURL(string: "\(URL_BASE)\(dscURL)")!
                    Alamofire.request(.GET, nsurl).responseJSON{response in
                        if let dscDict = response.result.value as? Dictionary<String,AnyObject>{
                            if let description = dscDict["description"] as? String{
                                self._description = description
                            }
                            
                        }
                        completed()
                    }
                    }
                }else{
                    self._description = ""
                }
                
                
                if let evol = dict["evolutions"] as? [Dictionary<String,AnyObject>] where evol.count > 0{
                    if let evolName = evol[0]["to"] as? String{
                                self._nextEvolName = evolName
                        }
                    if let uri = evol[0]["resource_uri"] as? String{
                        let newStr  = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon/", withString: "")
                        let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                        self._nextEvolID = num
                    }
                    if let lvl = evol[0]["level"] as? Int{
                        self._nextEvolLvl = "\(lvl)"
                    }
                    }
                
                
                }
                
                
                print(self._weight)
                print(self._attack)
                print(self._height)
                print(self._defense)
                print(self._type)
            
            
                
                
            }
        }
    }
    

