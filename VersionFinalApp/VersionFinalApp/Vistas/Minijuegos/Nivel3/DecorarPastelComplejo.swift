//
//  DecorarPastelComplejo.swift
//  VersionFinalApp
//
//  Created by Nicolas Aguirre Villafañe on 09/10/23.
//

import SwiftUI
import Subsonic

struct DecorarPastelComplejo: View {
    
    @State var offset: CGSize = .zero
        @State private var image1Position = CGPoint(x: 100, y: 100)
        @State private var image2Position = CGPoint(x: 250, y: 100)
        @State private var pastelImage = "Pastel/pastel_vacio"
        @State private var ladrillosImage = "Fondos/Pastel"
        @State private var betunAzul = "Pastel/betun_azul"
        @State private var betunes = ""
        @State private var velas = ""
        @State private var velasL1 = ""
        @State private var velasL2 = ""
        @State private var velasL3 = ""
        @State private var perlas = ""
        @State private var perlasL1 = ""
        @State private var perlasL2 = ""
        @State private var perlasL3 = ""
        @State private var chispas = ""
        @State private var chispasL1 = ""
        @State private var chispasL2 = ""
        @State private var chispasL3 = ""
        @State private var imagenes = ""
        @State private var pastelL1 = ""
        @State private var pastelL2 = ""
        @State private var pastelL3 = ""
        @State private var dragStartedX: CGFloat = 0
        @State private var dragStartedY: CGFloat = 0
        
        
        @Environment(\.dismiss) private var dismiss
        @State private var mostrarMenu = false
        
        @State private var mostrarComunicaciones = false
        
        @State var cakeBoxL1 = CGRect.zero
        @State var cakeBoxL2 = CGRect.zero
        @State var cakeBoxL3 = CGRect.zero
        @State var cakeBox = CGRect.zero
        
        @State var dragAmountBetunAzul = CGSize.zero
        @State var dragAmountBetunRosa = CGSize.zero
        @State var dragAmountBetunNaranja = CGSize.zero
        @State var dragAmountChispas = CGSize.zero
        @State var dragAmountPerlas = CGSize.zero
        @State var dragAmountVelas = CGSize.zero
        @State var dragAmountBlanco = CGSize.zero

        func init_sound() {
            play(sound: "select-game.wav")
        }
        
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
                            Text("Nivel 3")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255)))
                                .position(CGPoint(x: geo.size.width/2, y: 2 * geo.size.height/7))
                            
                            Spacer()
                            
                            
                            Text("Decora el pastel capa por capa")
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
                                
                                GeometryReader{ geo3 in
                                    Rectangle()
                                        .fill(.clear)
                                    
                                        .overlay {
                                            Color.clear
                                                .onAppear{
                                                    cakeBoxL3 = geo3.frame(in: .global)
                                                }
                                        }
                                }
                                .frame(width:geo2.size.width*0.27,height:geo2.size.height*0.13)
                                .offset(x:geo2.size.width*0.035 ,y:geo2.size.height*(-0.06))
                                
                                
                                GeometryReader{ geo3 in
                                    Rectangle()
                                        .fill(.clear)
                                        .overlay {
                                            Color.clear
                                                .onAppear{
                                                    cakeBoxL2 = geo3.frame(in: .global)
                                                }
                                        }
                                }
                                .frame(width:geo2.size.width*0.45,height:geo2.size.height*0.16)
                                .offset(x:geo2.size.width*0.04 ,y:geo2.size.height*(0.088))
                                
                                GeometryReader{ geo3 in
                                    Rectangle()
                                        .fill(.clear)
                                        .frame(width:geo2.size.width*0.5,height:geo2.size.height*0.25)
                                        .scaledToFill()
                                        .overlay {
                                            Color.clear
                                                .onAppear{
                                                    cakeBoxL1 = geo3.frame(in: .global)
                                                }
                                        }
                                }
                                .frame(width:geo2.size.width*0.54,height:geo2.size.height*0.24)
                                .offset(x:geo2.size.width*0.034 ,y:geo2.size.height*(0.28))
                                
                                Group{
                                    Image(pastelL1)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(pastelL2)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(pastelL3)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(velasL1)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(velasL2)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(velasL3)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(perlasL1)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(perlasL2)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(perlasL3)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                }
                                
                                Group{
                                    
                                    Image(chispasL1)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(chispasL2)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                    Image(chispasL3)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.8,height:geo2.size.height*0.8)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*0.025 ,y:geo2.size.height*(0.085))
                                    
                                }
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
                                                if cakeBoxL1.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.135 + dragAmountBetunAzul.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL1 = "Pastel/betun_azul_L1"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                else if cakeBoxL2.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.135 + dragAmountBetunAzul.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL2 = "Pastel/betun_azul_L2"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                else if cakeBoxL3.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountBetunAzul.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.135 + dragAmountBetunAzul.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL3 = "Pastel/betun_azul_L3"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                self.dragAmountBetunAzul = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.35, height: geo2.size.height*0.21)
                                    .position(CGPoint(x: geo2.size.width*0.28, y: geo2.size.height*0.135))
                                
                                Image("Pastel/betun_rosa")
                                    .resizable()
                                    .offset(dragAmountBetunRosa)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountBetunRosa = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cakeBoxL1.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.135 + dragAmountBetunRosa.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL1 = "Pastel/betun_rosa_L1"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                else if cakeBoxL2.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.135 + dragAmountBetunRosa.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL2 = "Pastel/betun_rosa_L2"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                else if cakeBoxL3.contains(CGPoint(x: (geo2.frame(in: .global).minX) + 230 + dragAmountBetunRosa.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.135 + dragAmountBetunRosa.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL3 = "Pastel/betun_rosa_L3"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                self.dragAmountBetunRosa = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.35, height: geo2.size.height*0.21)
                                    .position(CGPoint(x: geo2.size.width*0.72, y: geo2.size.height*0.135))
                                
                                Image("Pastel/logo_velas")
                                    .resizable()
                                    .offset(dragAmountVelas)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountVelas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cakeBoxL1.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountVelas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.4 + dragAmountVelas.height)) {
                                                    DispatchQueue.main.async {
                                                        velasL1 = "Pastel/velas_L1"
                                                        play(sound: "velas.wav")
                                                    }
                                                }
                                                else if cakeBoxL2.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountVelas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.4 + dragAmountVelas.height)) {
                                                    DispatchQueue.main.async {
                                                        velasL2 = "Pastel/velas_L2"
                                                        play(sound: "velas.wav")
                                                    }
                                                }
                                                else if cakeBoxL3.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountVelas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.4 + dragAmountVelas.height)) {
                                                    DispatchQueue.main.async {
                                                        velasL3 = "Pastel/velas_L3"
                                                        play(sound: "velas.wav")
                                                    }
                                                }
                                                self.dragAmountVelas = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.35, height: geo2.size.height*0.18)
                                    .position(CGPoint(x: geo2.size.width*0.28, y: geo2.size.height*0.4))
                                
                                Image("Pastel/betun_naranja")
                                    .resizable()
                                    .offset(dragAmountBetunNaranja)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountBetunNaranja = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cakeBoxL1.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.72 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.42 + dragAmountBetunNaranja.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL1 = "Pastel/betun_naranja_L1"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                else if cakeBoxL2.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.72 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.42 + dragAmountBetunNaranja.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL2 = "Pastel/betun_naranja_L2"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                else if cakeBoxL3.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.72 + dragAmountBetunNaranja.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.42 + dragAmountBetunNaranja.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL3 = "Pastel/betun_naranja_L3"
                                                        play(sound: "impact-paint-1.wav")
                                                    }
                                                }
                                                self.dragAmountBetunNaranja = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.35, height: geo2.size.height*0.21)
                                    .position(CGPoint(x: geo2.size.width*0.72, y: geo2.size.height*0.42))
                                
                                Image("Pastel/logo_chispas")
                                    .resizable()
                                    .offset(dragAmountChispas)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountChispas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cakeBoxL1.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountChispas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountChispas.height)) {
                                                    DispatchQueue.main.async {
                                                        chispasL1 = "Pastel/chispas_L1"
                                                    }
                                                }
                                                else if cakeBoxL2.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountChispas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountChispas.height)) {
                                                    DispatchQueue.main.async {
                                                        chispasL2 = "Pastel/chispas_L2"
                                                    }
                                                }
                                                else if cakeBoxL3.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.28 + dragAmountChispas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountChispas.height)) {
                                                    DispatchQueue.main.async {
                                                        chispasL3 = "Pastel/chispas_L3"
                                                    }
                                                }
                                                self.dragAmountChispas = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.33, height: geo2.size.height*0.2)
                                    .position(CGPoint(x: geo2.size.width*0.28, y: geo2.size.height*0.65))
                                
                                Image("Pastel/logo_perlas")
                                    .resizable()
                                    .offset(dragAmountPerlas)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountPerlas = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cakeBoxL1.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.71 + dragAmountPerlas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountPerlas.height)) {
                                                    DispatchQueue.main.async {
                                                        perlasL1 = "Pastel/perlas_L1"
                                                        play(sound: "pearls.wav")
                                                    }
                                                }
                                                else if cakeBoxL2.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.71 + dragAmountPerlas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountPerlas.height)) {
                                                    DispatchQueue.main.async {
                                                        perlasL2 = "Pastel/perlas_L2"
                                                        play(sound: "pearls.wav")
                                                    }
                                                }
                                                else if cakeBoxL3.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.71 + dragAmountPerlas.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountPerlas.height)) {
                                                    DispatchQueue.main.async {
                                                        perlasL3 = "Pastel/perlas_L3"
                                                        play(sound: "pearls.wav")
                                                    }
                                                }
                                                self.dragAmountPerlas = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.36, height: geo2.size.height*0.2)
                                    .position(CGPoint(x: geo2.size.width*0.71, y: geo2.size.height*0.65))
                                
                                
                                Image(pastelImage)
                                    .resizable()
                                    .offset(dragAmountBlanco)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountBlanco = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cakeBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.5 + dragAmountBlanco.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.85 + dragAmountBlanco.height)) {
                                                    DispatchQueue.main.async {
                                                        pastelL1 = ""
                                                        pastelL2 = ""
                                                        pastelL3 = ""
                                                        velasL1 = ""
                                                        velasL2 = ""
                                                        velasL3 = ""
                                                        perlasL1 = ""
                                                        perlasL2 = ""
                                                        perlasL3 = ""
                                                        chispasL1 = ""
                                                        chispasL2 = ""
                                                        chispasL3 = ""
                                                    }
                                                }
                                                self.dragAmountBlanco = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.36, height: geo2.size.height*0.2)
                                    .position(CGPoint(x: geo2.size.width*0.5, y: geo2.size.height*0.85))
                                
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
            .onAppear() {
                init_sound()
            }
        }
    
}

struct DecorarPastelComplejo_Previews: PreviewProvider {
    static var previews: some View {
        DecorarPastelComplejo()
    }
}
