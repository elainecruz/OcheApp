

//
//  GaleriaView.swift
//  OcheApp
//
//  Created by Elaine  Cruz on 24/11/20.
//

import SwiftUI

struct GaleriaView: View {
    var obras = [Obra]()
    
    init(obrasAchadas: [Obra]){
        obras = obrasAchadas
    }
    
    var body: some View {
        VStack {
            ZStack {
                Image("circles")
                    .resizable()
                    .frame(width: 450, height: 70, alignment: .top)
                    .offset(x: 0, y: -64)
                
                Image("galeriaTitle")
                    .resizable()
                    .frame(width: 200, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    .offset(x: 0, y: 35)
            }
            
            ScrollView{
                LazyVGrid(columns: [GridItem(), GridItem()], alignment: .center, spacing: 10){
                    ForEach (obras){ obra in
                        VStack (alignment:.center){
                            Image(obra.imagemPath)
                                .resizable()
                                .frame(width: 120, height: 100, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            Text(obra.nome)
                                .multilineTextAlignment(.center)
                                .frame(width: 130)
                                .font(.system(size: 15))
                            
                            
                            
                        }.padding()
                        
                        
                    }
                    
                    
                }
            }
            .padding()
        }
        .background(Color("Bege"))
        
    }
}

//struct GaleriaView_Previews: PreviewProvider {
//    static var previews: some View {
//        GaleriaView(obrasAchadas: obras)
//            .previewDevice("iPhone 11")
//    }
//}



public class Obra: Identifiable{
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
