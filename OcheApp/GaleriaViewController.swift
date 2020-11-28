//
//  GaleriaViewController.swift
//  OcheApp
//
//  Created by Elaine  Cruz on 25/10/20.
//

import Foundation
import UIKit
import SwiftUI

class GaleriaViewController: UIViewController {

    var obras = [Obra]()
    
    //let contentView = UIHostingController(rootView: GaleriaView(obrasAchadas: obras))
    override func viewDidLoad() {
        super.viewDidLoad()

        let contentView = UIHostingController(rootView: GaleriaView(obrasAchadas: obras))
        addChild(contentView)
        view.addSubview(contentView.view)
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }

       
}

