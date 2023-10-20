//
//  PerroDrag.swift
//  VersionFinalApp
//
//  Created by Diego Esparza Hurtado on 09/10/23.
//

import SwiftUI
import Subsonic
import AVFoundation

struct PerroDrag: View {
    
    let synthesizer = AVSpeechSynthesizer()
    @State var textToSpeech = true
    
    @State var bowlImage = "Perro/plato_vacio"
    @State var dogImage = "Perro/perro_base"
    @Environment(\.dismiss) private var dismiss
    
    @State var dogBox = CGRect.zero
    @State var bowlBox = CGRect.zero
    
    @State var dragAmountSponge = CGSize.zero
    @State var dragAmountToy = CGSize.zero
    @State var dragAmountFood = CGSize.zero
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
            GeometryReader { geo in
                VStack {
                    Text("NIVEL 3")
                        .font(.custom("HelveticaNeue", size: 40))
                        .shadow(radius: 10)
                        .onTapGesture {
                            speakF(text: "Nivel 3", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255))
                                .frame(width: geo.size.width/2, height: geo.size.height/11))
                    Text("Juega con el Perro")
                        .foregroundColor(Color.white)
                        .font(.custom("HelveticaNeue", size: 40))
                        .onTapGesture {
                            speakF(text: "Juega con el Perro", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 1, style: .continuous)
                                .fill(Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255))
                                .opacity(0.5)
                                .frame(width: geo.size.width/2, height: geo.size.height/10))
                        .padding()
                }
                .frame(width: geo.size.width + geo.size.width/2.25, height: geo.size.width/5)
            }
            GeometryReader { geo in
                HStack {
                    ZStack {
                        Rectangle()
                            .fill(Color.brown)
                            .frame(width: geo.size.width - geo.size.width/15, height: geo.size.height/1.6)
                            .position(x:geo.size.width/2 - geo.size.width/33, y:geo.size.height/1.676)
                        Image("Fondos/Perro")
                            .resizable()
                            .frame(width: geo.size.width/1.5 - geo.size.width/15, height: geo.size.height/1.6)
                        Image(dogImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/1.5 - geo.size.width/15, height: geo.size.height/1.6)
                            .position(x:geo.size.width/5.5,y:geo.size.height/1.6)
                            .onTapGesture {
                                speakF(text: "Perro", isOn: textToSpeech)
                            }
                            .overlay {
                                GeometryReader { geo2 in
                                    Color.clear
                                        .onAppear{
                                            dogBox = geo2.frame(in: .global)
                                        }
                                }
                                .frame(width: geo.size.width/1.4 - geo.size.width/2.5, height: geo.size.height/1.9)
                                .position(x:geo.size.width/6,y:geo.size.height/1.6)
                            }
                        Image(bowlImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/6, height: geo.size.height)
                            .position(x:geo.size.width/2.3,y:geo.size.height/1.26)
                            .onTapGesture {
                                speakF(text: "Tazón del perro", isOn: textToSpeech)
                            }
                            .overlay {
                                GeometryReader { geo2 in
                                    Color.clear
                                        .onAppear{
                                            bowlBox = geo2.frame(in: .global)
                                        }
                                }
                                .frame(width: geo.size.width/7, height: geo.size.height/7)
                                .position(x:geo.size.width/2.3,y:geo.size.height/1.26)
                            }
                    }
                    .position(x: geo.size.width/3, y: geo.size.height/2 + geo.size.height/10)
                    
                    ZStack {
                        VStack {
                            Image("Perro/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                            Image("Perro/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                            Image("Perro/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                        }
                        .position(x:geo.size.width/3.3,y:geo.size.height/1.67)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.width/1.2)
            }
            GeometryReader { geo in
                Image("Perro/perro_comida")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/3, height: geo.size.height/6)
                    .position(x:geo.size.width/1.39, y:geo.size.height/2.57)
                    .onTapGesture {
                        speakF(text: "Comida para el perro", isOn: textToSpeech)
                    }
                    .shadow(radius: 10)
                    .offset(dragAmountFood)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged{
                                self.dragAmountFood = CGSize(width: $0.translation.width, height: $0.translation.height)
                            }
                            .onEnded { _ in
                                if bowlBox.contains(CGPoint(x: geo.size.width/1.39 + dragAmountFood.width, y: geo.size.height/2.57 + dragAmountFood.height)) {
                                    play(sound: "pourFood.mp3")
                                    DispatchQueue.main.async {
                                        bowlImage = "Perro/plato_lleno"
                                        dogImage = "Perro/perro_comiendo"
                                        Task {
                                            play(sound:"dogBark1.mp3")
                                            try? await Task.sleep(nanoseconds: UInt64(3 * 1E9))
                                            bowlImage = "Perro/plato_vacio"
                                            dogImage = "Perro/perro_base"
                                        }
                                    }
                                }
                                self.dragAmountFood = .zero
                            }
                    )
                
                Text("Comida")
                    .foregroundColor(Color.black)
                    .font(.custom("HelveticaNeue", size: 50))
                    .bold()
                    .position(x:geo.size.width/1.17, y:geo.size.height/2.57)
                    .onTapGesture {
                        speakF(text: "Comida", isOn: textToSpeech)
                    }
                Image("Perro/jabon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/2, height: geo.size.height/7)
                    .position(x:geo.size.width/1.42, y:geo.size.height/1.66)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Esponja", isOn: textToSpeech)
                    }
                    .offset(dragAmountSponge)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged{
                                self.dragAmountSponge = CGSize(width: $0.translation.width, height: $0.translation.height)
                            }
                            .onEnded { _ in
                                if dogBox.contains(CGPoint(x: geo.size.width/1.42 + dragAmountSponge.width, y: geo.size.height/1.66 + dragAmountSponge.height)) {
                                    play(sound: "scrubbing.mp3")
                                    DispatchQueue.main.async {
                                        dogImage = "Perro/perro_enjabonado"
                                        Task {
                                            play(sound: "dogBark1.mp3")
                                            try? await Task.sleep(nanoseconds: UInt64(3 * 1E9))
                                            dogImage = "Perro/perro_base"
                                        }
                                    }
                                }
                                self.dragAmountSponge = .zero
                            }
                    )
                
                Text("Limpieza")
                    .foregroundColor(Color.black)
                    .font(.custom("HelveticaNeue", size: 50))
                    .bold()
                    .position(x:geo.size.width/1.16, y:geo.size.height/1.66)
                    .onTapGesture {
                        speakF(text: "Limpieza", isOn: textToSpeech)
                    }
                Image("Perro/juguete_pelota")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/3, height: geo.size.height/6)
                    .position(x:geo.size.width/1.39, y:geo.size.height/1.23)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Pelota del Perro", isOn: textToSpeech)
                    }
                    .offset(dragAmountToy)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged{
                                self.dragAmountToy = CGSize(width: $0.translation.width, height: $0.translation.height)
                            }
                            .onEnded { _ in
                                if dogBox.contains(CGPoint(x: geo.size.width/1.39 + dragAmountToy.width, y: geo.size.height/1.23 + dragAmountToy.height)) {
                                    play(sound: "squeaky.mp3")
                                    DispatchQueue.main.async {
                                        play(sound: "dogBark1.mp3")
                                        dogImage = "Perro/perro_jugando"
                                        Task {
                                            try? await Task.sleep(nanoseconds: UInt64(5 * 1E9))
                                            dogImage = "Perro/perro_base"
                                        }
                                    }
                                    
                                }
                                self.dragAmountToy = .zero
                            }
                    )
                
                Text("Jugar")
                    .foregroundColor(Color.black)
                    .font(.custom("HelveticaNeue", size: 50))
                    .bold()
                    .position(x:geo.size.width/1.17, y:geo.size.height/1.23)
                    .onTapGesture {
                        speakF(text: "Jugar", isOn: textToSpeech)
                    }
                Button(action: {
                    play(sound: "Sonidos/Minijuegos/go-back.wav")
                    dismiss()
                }) {
                    Text("Regresar")
                        .frame(width: geo.size.width / 3, height: geo.size.height / 9)
                        .background(Color.red)
                        .cornerRadius(30)
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .shadow(radius: 10)
                }
                .background(Color.clear)
                .position(x: geo.size.width - geo.size.width/1.3, y: geo.size.height/11)
                Group {
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255))
                        .frame(width: geo.size.width/3.6, height: geo.size.height/15)
                        .position(x: geo.size.width/4.5, y: geo.size.height/5)
                        .opacity(0.5)
                    Text("Text-To-Speech")
                        .foregroundColor(Color.white)
                        .font(.custom("HelveticaNeue", size: 30))
                        .bold()
                        .position(x: geo.size.width/5, y: geo.size.height/5)
                    Toggle("text",isOn: $textToSpeech)
                        .position(x: geo.size.width - geo.size.width*1.15, y: geo.size.height/5)
                    
                }
            }
        }
        .ignoresSafeArea()
    }
    
    func speakF(text: String, isOn: Bool) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        if isOn {
            synthesizer.speak(utterance)
        }
    }
    
}

struct PerroDrag_Previews: PreviewProvider {
    static var previews: some View {
        PerroDrag()
    }
}
