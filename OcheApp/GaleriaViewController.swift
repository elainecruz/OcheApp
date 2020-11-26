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

    let contentView = UIHostingController(rootView: GaleriaView())
    override func viewDidLoad() {
        super.viewDidLoad()

        
        addChild(contentView)
        view.addSubview(contentView.view)
        setUpConstraints()
        // Do any additional setup after loading the view.
    }

    func setUpConstraints(){
        contentView.view.translatesAutoresizingMaskIntoConstraints = false
        contentView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contentView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        contentView.view.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        contentView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
}

