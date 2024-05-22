//
//  SoundViewController.swift
//  SoundBoard
//
//  Created by Oliver Correa Cabana on 21/05/24.
//

import UIKit
import AVFoundation

class SoundViewController: UIViewController {

    @IBOutlet weak var grabarButton: UIButton!
    @IBOutlet weak var reproducirButton: UIButton!
    @IBOutlet weak var nombreTexField: UITextField!
    @IBOutlet weak var agregarButton: UIButton!
    
    var grabarAudio:AVAudioRecorder?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configurarGrabacion()

        // Do any additional setup after loading the view.
    }
    
    func configurarGrabacion(){
        do{
            //Creando sesion de audio
            let session = AVAudioSession.sharedInstance()
            try session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: [])
            try session.overrideOutputAudioPort(.speaker)
            try session.setActive(true)
            
            //Creando direccion para el archivo de audio
            let basePath:String = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let pathComponents = [basePath, "audio.m4a"]
            let audioURL = NSURL.fileURL(withPathComponents: pathComponents)!
            
            //Impresion de ruta donde se guardan los archivos
            print("**********************")
            print(audioURL)
            print("**********************")
            
            //Crear opciones para el grabador de audio
            var settings:[String:AnyObject] = [:]
            settings[AVFormatIDKey] = Int(kAudioFormatMPEG4AAC) as AnyObject?
            settings[AVSampleRateKey] = 44100.0 as AnyObject?
            settings[AVNumberOfChannelsKey] = 2 as AnyObject?
                        
            // Crear el objeto de grabación de audio
            grabarAudio = try AVAudioRecorder(url: audioURL, settings: settings)
            grabarAudio!.prepareToRecord()
        } catch let error as NSError {
            print(error)
        }
    }
    
    @IBAction func grabarTapped(_ sender: Any) {
        if grabarAudio!.isRecording{
            //Detener la grabacion
            grabarAudio?.stop()
            //Cambiar texto del boton grabar
            grabarButton.setTitle("GRABAR", for: .normal)
        }else{
            //Empezar a grabar
            grabarAudio?.record()
            //Cambiar el texto del boton grabar a detener
            grabarButton.setTitle("DETENER", for: .normal)
        }
    }
    @IBAction func reproducirTapped(_ sender: Any) {
    }
    @IBAction func agregarTapped(_ sender: Any) {
    }
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
