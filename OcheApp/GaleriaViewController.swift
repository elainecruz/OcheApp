//
//  GaleriaViewController.swift
//  OcheApp
//
//  Created by Elaine  Cruz on 25/10/20.
//

import Foundation
import UIKit

class GaleriaViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return obrasAchadas.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let minhaCelula = obrasCollectionView.dequeueReusableCell(withReuseIdentifier: "id", for: indexPath)
        minhaCelula.backgroundView = UIImageView(image: UIImage(named: obras[indexPath.row].imagemPath))
        
        return minhaCelula
    }
    
    
    var obrasCollectionView:UICollectionView!
    var obras = [Obra(imagemPath: "0072430cx069-06.png", nome: "Jardim do Palácio do Catete - chafariz com escultura", artista: "Marc Ferrez", ano: " Aproximadamente 1885/1995", instituição: "Instituto Moreira Sales")]
    var obrasAchadas:[Obra] = []
    
    override func loadView(){
        

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        var layoutForCollectionView: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layoutForCollectionView.sectionInset = UIEdgeInsets(top: 32, left: 20, bottom: 20, right: 20)
        layoutForCollectionView.itemSize = CGSize(width: 60, height: 60)
        layoutForCollectionView.scrollDirection = .horizontal
        obrasCollectionView = UICollectionView(frame: CGRect(x: 20, y: 50, width: 200, height: 200), collectionViewLayout: layoutForCollectionView)
    
        obrasCollectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "id")
        obrasCollectionView.backgroundColor = .clear
        obrasCollectionView.dataSource = self
        obrasCollectionView.delegate = self
        
        self.view.addSubview(obrasCollectionView)
    }


}


public class Obra{
    public var imagemPath: String
    public var nome: String
    public var artista: String
    public var ano: String
    public var instituição: String
    
    public init(imagemPath: String, nome: String, artista: String, ano: String, instituição: String){
        self.imagemPath = imagemPath
        self.nome = nome
        self.artista = artista
        self.ano = ano
        self.instituição = instituição
    }
}
