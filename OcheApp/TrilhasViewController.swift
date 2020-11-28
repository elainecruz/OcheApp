//
//  TrilhasViewController.swift
//  OcheApp
//
//  Created by Elaine  Cruz on 25/10/20.
//

import Foundation
import UIKit
import CoreLocation
import UserNotifications



class TrilhasViewController: UIViewController, CLLocationManagerDelegate, UNUserNotificationCenterDelegate {

    let locationManager:CLLocationManager = CLLocationManager()
    let notificationCenter = UNUserNotificationCenter.current()
    let aux = true
    @IBOutlet weak var PopUpBackground: UIImageView!
    @IBOutlet weak var closePopUPButton: UIButton!
    @IBOutlet weak var popUpSaveButton: UIButton!
    @IBOutlet var popUpObra: UIImageView!
    @IBOutlet weak var exclusivoBckgrnd: UIImageView!
    @IBOutlet weak var btmNo: UIButton!
    @IBOutlet weak var btmAdicionar: UIButton!
    //var popUp = UIView()
    @IBOutlet weak var openExclusivo: UIButton!
    
    @IBOutlet weak var botaoAdd: UIButton!
    @IBOutlet weak var btmAdd: UIButton!
    var obras = [Obra]()
    var adicionada = [false,false]
    
    @IBAction func openExclusivo(_ sender: Any) {
       
        print("OLHAAA")
        
        //btmAdd.isHidden = false
        //print(btmAdd.isHidden)
        btmNo.isHidden = false
        botaoAdd.isHidden = false
        exclusivoBckgrnd.isHidden = false
    }

    @IBAction func closeExclusivoPopUp(_ sender: Any) {
        exclusivoBckgrnd.isHidden = true
        botaoAdd.isHidden = true
        btmNo.isHidden = true
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert]) {
            (granted, error) in
            if granted {
                print("yes")
            } else {
                print("No")
            }
        }
        
        notificationCenter.delegate = self
        
        
        locationManager.delegate = self
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        
        locationManager.distanceFilter = 100
        
        let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(-22.925798, -43.1745), radius: 500, identifier: "MF01")
        let geoFenceRegion2:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake( -22.906928, -43.177865999999995), radius: 500, identifier: "MF02")
    
        
        locationManager.startMonitoring(for: geoFenceRegion)
        sendNotification(region: geoFenceRegion, identifier: "MF01")
        locationManager.startMonitoring(for: geoFenceRegion2)
        sendNotification(region: geoFenceRegion, identifier: "MF02")

        
//        locationManager.stopUpdatingLocation()
        
        
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        for currentLocation in locations{
            print("\(index): \(currentLocation)")
            // "0: [locations]"
            
        }
    }
    
    
    
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        print("Entered: \(region.identifier)")
       // postLocalNotifications(eventTitle: "Entered: \(region.identifier)")
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.scheduleNotification(notificationType: "Local Notification")
//
    
        if(region.identifier == "MF01" && !adicionada[0]){
            //popUpObra = UIImageView(image: UIImage(named:"0072430cx069-6"))
            obras.append(Obra(imagemPath: "0072430cx069-6", nome: "Jardim do Palácio do Catete - chafariz com escultura", artista: "Marc Ferrez", ano: " Aproximadamente 1885/1995", instituição: "Instituto Moreira Sales"))
            adicionada[0] = true
        }
        
        if(region.identifier == "MF02" && !adicionada[1]){
            //popUpObra = UIImageView(image: UIImage(named:"0072430cx058-9"))
            obras.append(Obra(imagemPath: "0072430cx058-9", nome: "Vista do Largo da Carioca com o convento de Santo Antônio ao fundo", artista: "Marc Ferrez", ano: " Aproximadamente 1885", instituição: "Instituto Moreira Sales"))
            adicionada[1] = true
        }

        OpenPopUp()
        
    }
    
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("Exited: \(region.identifier)")
       // postLocalNotifications(eventTitle: "Exited: \(region.identifier)")
        sendNotification(region: region as! CLCircularRegion, identifier: region.identifier)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func sendNotification(region: CLCircularRegion,identifier: String  ) {
        // 1
        let content = UNMutableNotificationContent()
        content.title = "Opa!"
        content.subtitle = "Parece que você está perto de uma nova obra."
        content.body = "Clique para saber mais."
        
        // 3
        let trigger = UNLocationNotificationTrigger(region: region, repeats:false)
        
        //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        // 4
        //notificationCenter.add(request, withCompletionHandler: nil)
        UNUserNotificationCenter.current().add(request) {(error) in
            if let error = error {
                print("error: \(error)")
            } else {
                print("Scheduled Notification")
            }

        }
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        completionHandler([.alert, .sound])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {

        if response.notification.request.identifier == "Local Notification" {
            print("Handling notifications with the Local Notification Identifier")
        }

        completionHandler()
    }
    
    func OpenPopUp(){
        print("oppUPUP")
        PopUpBackground.isHidden = false
        closePopUPButton.isHidden = false
        popUpSaveButton.isHidden = false
        popUpObra.isHidden = false
    }
    
    
    @IBAction func ClosePopUp(_ sender: Any) {
        PopUpBackground.isHidden = true
        closePopUPButton.isHidden = true
        popUpSaveButton.isHidden = true
        popUpObra.isHidden = true
    }
    
    
    override func prepare (for segue: UIStoryboardSegue, sender:Any?) {
        if segue.identifier == "galeriaSegue" {
            let vcGaleria = segue.destination as? GaleriaViewController
            vcGaleria?.obras = obras
            print(obras)
        }
    }


}

