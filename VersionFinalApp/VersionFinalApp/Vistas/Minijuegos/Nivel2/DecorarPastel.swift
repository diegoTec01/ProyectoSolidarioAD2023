//
//  DecorarPastel.swift
//  VersionFinalApp
//
//  Created by Alejandro Lizarraga Vizcarra on 08/10/23.
//

import SwiftUI
import Subsonic

struct DecorarPastel: View {
    
    @State var offset: CGSize = .zero
    @State private var image1Position = CGPoint(x: 100, y: 100)
    @State private var image2Position = CGPoint(x: 250, y: 100)
    @State private var pastelImage = "Pastel/pastel_vacio"
    @State private var ladrillosImage = "Fondos/Pastel"
    @State private var betunAzul = "Pastel/betun_azul"
    @State private var betunes = ""
    @State private var velas = ""
    @State private var perlas = ""
    @State private var chispas = ""
    @State private var imagenes = ""
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
    @State private var mostrarComunicaciones = false
    
    @State var cakeBox = CGRect.zero
    
    @State var dragAmountBetunAzul = CGSize.zero
    @State var dragAmountBetunRosa = CGSize.zero
    @State var dragAmountBetunNaranja = CGSize.zero
    @State var dragAmountChispas = CGSize.zero
    @State var dragAmountPerlas = CGSize.zero
    @State var dragAmountVelas = CGSize.zero
    @State var dragAmountBlanco = CGSize.zero
    
    
    
    var body: some View {
        VStack(){
            
            Spacer()
            
            HStack {
                Button(action: {
                    play(sound: "Sonidos/Minijuegos/go-back.wav")
                    dismiss()
                }) {
                    Image(systemName: "arrowshape.backward.fill")
                        .font(.title)
                        .foregroundColor(.black)
                        .padding(10)
                        .background(Color.white)
                        .clipShape(Rectangle())
                        .cornerRadius(20)
                }
                .padding(.leading, 40)
                
                Spacer()
                
                VStack(){
                    GeometryReader { geo in
                        Text("Nivel 2")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                            .cornerRadius(20)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255)))
                            .position(CGPoint(x: geo.size.width/2, y: 2 * geo.size.height/7))
                        
                        Spacer()
                        
                        
                        Text("Decora el pastel")
                            .foregroundColor(Color.white)
                            .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                            .bold()
                            .cornerRadius(20)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: 0.295, green: 0.31, blue: 0.441)))
                            .position(CGPoint(x: geo.size.width/2, y: 6 * geo.size.height/7))
                    }
                }
                .frame(height:170)
                .padding(.trailing, 90)
                //.background(Color.red)
                
                Spacer()
                Spacer()
                Spacer()
            }
            
            GeometryReader { geo in
                HStack {
                    GeometryReader { geo2 in
                        ZStack{
                            Image(ladrillosImage)
                                .resizable()
                                .frame(width:geo2.size.width*1,height:geo2.size.height*1.0)
                                .scaledToFill()
                            
                            GeometryReader { geo3 in
                                Image(pastelImage)
                                    .resizable()
                                    .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                    .scaledToFill()
                                    .offset(x: 20, y: 45)
                                    .overlay {
                                        Color.clear
                                            .onAppear{
                                                cakeBox = geo3.frame(in: .global)
                                            }
                                    }
                                
                            }
                            .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                            
                            
                            
                            Image(betunes)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(velas)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(perlas)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                            
                            Image(chispas)
                                .resizable()
                                .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                .scaledToFill()
                                .offset(x: 20, y: 45)
                        }
                    }
                    .padding()
                    
                    VStack(){
                        GeometryReader { geo2 in
                            //Aqui va lo relacionando con arrastrar y soltar
                            Image("Pastel/betun_azul")
                                .resizable()
                                .offset(dragAmountBetunAzul)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBetunAzul = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + 100 + dragAmountBetunAzul.height)) {
                                                DispatchQueue.main.async {
                                                    betunes = "Pastel/pastel_azul"
                                                    play(sound: "Sonidos/Minijuegos/vetunazo-1.wav")
                                                }
                                            }
                                            self.dragAmountBetunAzul = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 70))
                            
                            Image("Pastel/betun_rosa")
                                .resizable()
                                .offset(dragAmountBetunRosa)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBetunRosa = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + 70 + dragAmountBetunRosa.height)) {
                                                DispatchQueue.main.async {
                                                    betunes = "Pastel/pastel_rosa"
                                                    play(sound: "Sonidos/Minijuegos/vetunazo-1.wav")
                                                }
                                            }
                                            self.dragAmountBetunRosa = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 70))
                            
                            Image("Pastel/betun_naranja")
                                .resizable()
                                .offset(dragAmountBetunNaranja)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBetunNaranja = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + 220 + dragAmountBetunNaranja.height)) {
                                                DispatchQueue.main.async {
                                                    betunes = "Pastel/pastel_naranja"
                                                    play(sound: "Sonidos/Minijuegos/vetunazo-1.wav")
                                                }
                                            }
                                            self.dragAmountBetunNaranja = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 220))
                            
                            Image("Pastel/logo_chispas")
                                .resizable()
                                .offset(dragAmountChispas)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountChispas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountChispas.width, y: (geo2.frame(in: .global).minY) + 370 + dragAmountChispas.height)) {
                                                DispatchQueue.main.async {
                                                    chispas = "Pastel/chispas"
                                                }
                                            }
                                            self.dragAmountChispas = .zero
                                        }
                                )
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 370))
                            Image("Pastel/logo_perlas")
                                .resizable()
                                .offset(dragAmountPerlas)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountPerlas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountPerlas.width, y: (geo2.frame(in: .global).minY) + 370 + dragAmountPerlas.height)) {
                                                DispatchQueue.main.async {
                                                    perlas = "Pastel/perlas"
                                                    play(sound: "Sonidos/Minijuegos/perlas.wav")
                                                }
                                            }
                                            self.dragAmountPerlas = .zero
                                        }
                                )
                            
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 230, y: 370))
                            Image("Pastel/logo_velas")
                                .resizable()
                                .offset(dragAmountVelas)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountVelas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 80 + dragAmountVelas.width, y: (geo2.frame(in: .global).minY) + 220 + dragAmountVelas.height)) {
                                                DispatchQueue.main.async {
                                                    velas = "Pastel/velas"
                                                    play(sound: "Sonidos/Minijuegos/velas.wav")
                                                }
                                            }
                                            self.dragAmountVelas = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 80, y: 220))
                            
                            Image(pastelImage)
                                .resizable()
                                .offset(dragAmountBlanco)
                                .gesture(
                                    DragGesture(coordinateSpace: .global)
                                        .onChanged{
                                            self.dragAmountBlanco = CGSize(width: $0.translation.width, height: $0.translation.height)
                                        }
                                        .onEnded { _ in
                                            if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 150 + dragAmountBlanco.width, y: (geo2.frame(in: .global).minY) + 470 + dragAmountBlanco.height)) {
                                                DispatchQueue.main.async {
                                                    velas = ""
                                                    perlas = ""
                                                    chispas = ""
                                                    betunes = ""
                                                }
                                            }
                                            self.dragAmountBlanco = .zero
                                        }
                                )
                                .frame(width: 100, height: 100)
                                .position(CGPoint(x: 150, y: 470))
                            
                        }
                    }
                    .frame(width: geo.size.width*0.25)
                    .background(Color(red: 0.502, green: 0.502, blue: 0.502))
                    .padding()
                }
                .background(.white)
                .padding()
            }
            
            Spacer()
            
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
    
}

struct DecorarPastel_Previews: PreviewProvider {
    static var previews: some View {
        DecorarPastel()
    }
}
