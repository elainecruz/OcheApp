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
    @IBOutlet weak var popUpObra: UIImageView!
    //var popUp = UIView()
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
        
        //let geoFenceRegion:CLCircularRegion = CLCircularRegion(center: CLLocationCoordinate2DMake(43.61871, -116.214607), radius: 100, identifier: "Boise")

        
        locationManager.startMonitoring(for: geoFenceRegion)
        sendNotification(region: geoFenceRegion, identifier: "MF01")

        
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
//        if(region.identifier == "MF01"){
//            popUpObra = UIImageView(image: UIImage(named:"0072430cx069-6"))
//        }

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
    


}

