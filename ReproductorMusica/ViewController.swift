//
//  ViewController.swift
//  ReproductorMusica
//
//  Created by Oscar Javier Olivos on 18/12/16.
//  Copyright © 2016 Oscar Javier Olivos. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {

    @IBOutlet var btnPlayPause: UIButton!
    @IBOutlet var txtTitulo: UILabel!
    @IBOutlet var imgPortada: UIImageView!
    @IBOutlet var sliderProgreso: UISlider!
    @IBOutlet var sliderVolume: UISlider!
    @IBOutlet var switchSuffle: UISwitch!
    var canciones : Array<Cancion> = []
    var timer : Timer? = nil
    var cancionActual = 0

    
    var player : AVAudioPlayer!
    var i = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let bicicleta = Cancion(titulo: "La Bicicleta - Carlos Vives & Shakira", portada: UIImage(named: "bicicleta.jpg")!, url: Bundle.main.url(forResource: "bicicleta", withExtension: "mp3")!)
        canciones.append(bicicleta)
        
        let mar = Cancion(titulo: "El Mar de sus Ojos - Carlos Vives & ChocQuibTown", portada: UIImage(named: "elmar.jpg")!, url: Bundle.main.url(forResource: "elmar", withExtension: "mp3")!)
        canciones.append(mar)
        
        let notas = Cancion(titulo: "Notas de Amor - Wisin, Carlos Vives ft. Daddy Yankee", portada: UIImage(named: "nota.jpg")!, url: Bundle.main.url(forResource: "notas", withExtension: "mp3")!)
        canciones.append(notas)
        
        let cuando = Cancion(titulo: "Cuando nos Volvamos a encontrar - Carlos Vives ft. Marc Anthony", portada: UIImage(named: "cuando.png")!, url: Bundle.main.url(forResource: "cuando", withExtension: "mp3")!)
        canciones.append(cuando)
        
        
        prepareToPlay(cancion: canciones[0])
        
        
        
        
        player.volume = sliderVolume.value
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBAction func btnPlayClick(_ sender: UIButton) {
        playCancion()
    }
    @IBAction func btnBack() {
        sliderProgreso.value = 0.0
        let cancionIsPlayer = player.isPlaying
        
        if switchSuffle.isOn{
            cancionActual = Int(arc4random_uniform(UInt32(canciones.count)) )
            print(cancionActual)
            prepareToPlay(cancion: canciones[cancionActual])
            if cancionIsPlayer{
                playCancion()
            }
            
        }else{
            if(cancionActual > 0){
                prepareToPlay(cancion: canciones[cancionActual - 1])
                cancionActual = cancionActual - 1
                if cancionIsPlayer{
                    playCancion()
                }
            }else{
                prepareToPlay(cancion: canciones[canciones.count - 1])
                cancionActual = canciones.count - 1
                if cancionIsPlayer{
                    playCancion()
                }
            }
            
        }
    }

    @IBAction func btnNext() {
        sliderProgreso.value = 0.0
        let cancionIsPlayer = player.isPlaying
 
        if switchSuffle.isOn{
            cancionActual = Int(arc4random_uniform(UInt32(canciones.count)) )
            print(cancionActual)
            prepareToPlay(cancion: canciones[cancionActual])
            if cancionIsPlayer{
                playCancion()
            }
            
        }else{
            if(cancionActual < canciones.count - 1){
                prepareToPlay(cancion: canciones[cancionActual + 1])
                cancionActual = cancionActual + 1
                if cancionIsPlayer{
                    playCancion()
                }
            }else{
                prepareToPlay(cancion: canciones[0])
                cancionActual = 0
                if cancionIsPlayer{
                    playCancion()
                }
            }
        
        }
        
        
    }
    @IBAction func btnStop() {
        timer?.invalidate()
        sliderProgreso.value = 0.0
        player.stop()
        player.currentTime = 0.0
        btnPlayPause.setTitle("Play", for: UIControlState.normal)
        
    }
    
    func updateProgressBar()  {
        
        
        
        sliderProgreso.value = Float(player.currentTime)
        
        
    }
    @IBAction func sliderProgresoChange(_ sender: UISlider) {
        
        player.currentTime = TimeInterval(sender.value)
    }
    

    @IBAction func btnVolumechange(_ sender: UISlider) {
        player.volume = sender.value
    
        
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        btnPlayPause.setTitle("Play", for: UIControlState.normal)
        print(flag)
        btnNext()
        playCancion()
        
    }
    func prepareToPlay(cancion : Cancion) {
        
        imgPortada.image = cancion.portada!
        txtTitulo.text = cancion.titulo
        
        do{
            try player = AVAudioPlayer(contentsOf: cancion.url!)
            player.prepareToPlay()
            player.delegate = self
        }catch let error as NSError{
            print(error)
            
        }

        
    }
    
    func playCancion() {

        if !player.isPlaying{
            player.currentTime = TimeInterval(sliderProgreso.value)
            player.play()
            sliderProgreso.maximumValue = Float(player.duration)
            sliderProgreso.minimumValue = 0.0
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(self.updateProgressBar), userInfo: nil, repeats: true)
            
            btnPlayPause.setTitle("Pause", for: UIControlState.normal)
            //print("played")
        }else{
            player.pause()
            btnPlayPause.setTitle("Play", for: UIControlState.normal)
            timer?.invalidate()
        }

    }
    
    
}

