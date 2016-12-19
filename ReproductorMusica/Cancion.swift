//
//  Cancion.swift
//  ReproductorMusica
//
//  Created by Oscar Javier Olivos on 18/12/16.
//  Copyright © 2016 Oscar Javier Olivos. All rights reserved.
//

import UIKit
class Cancion {
    var titulo: String=""
    var portada :UIImage? = nil
    var url : URL? = nil
    
    init(titulo : String, portada : UIImage, url: URL) {
        
        self.titulo = titulo
        self.portada = portada
        self.url = url
    }
}
