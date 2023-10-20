//
//  GatoDrag.swift
//  VersionFinalApp
//
//  Created by Diego Esparza Hurtado on 09/10/23.
//

import SwiftUI
import Subsonic
import AVFoundation

struct GatoDrag: View {
    let synthesizer = AVSpeechSynthesizer()
    
    @State var catImage = "Gato/gato_base"
    @State var bowlImage = "Gato/plato_vacio"
    @State var textToSpeech = true
    
    @State var catBox = CGRect.zero
    @State var bowlBox = CGRect.zero
    
    @State var dragAmount = CGSize.zero
    @State var dragAmountToy = CGSize.zero
    @State var dragAmountFood = CGSize.zero
    
    
    
    @Environment(\.dismiss) private var dismiss
    
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
                        .onTapGesture {
                            speakF(text: "Nivel 3", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(red: 255 / 255, green: 0 / 255, blue: 0 / 255))
                                .frame(width: geo.size.width/2, height: geo.size.height/11))
                    Text("Juega con el Gato")
                        .foregroundColor(Color.white)
                        .font(.custom("HelveticaNeue", size: 40))
                        .onTapGesture {
                            speakF(text: "Juega con el Gato", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 1, style: .continuous)
                                .fill(Color(red: 75 / 255, green: 79 / 255, blue: 113 / 255))
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
                        Image("Fondos/Gato")
                            .resizable()
                            .frame(width: geo.size.width/1.5 - geo.size.width/15, height: geo.size.height/1.6)
                        Image(catImage)
                            .resizable()
                            .scaledToFit()
                            .scaleEffect(x:-1, y:1)
                            .frame(width: geo.size.width/1.5 - geo.size.width/15, height: geo.size.height/1.9)
                            .position(x:geo.size.width/5.5,y:geo.size.height/1.6)
                            .onTapGesture {
                                speakF(text: "Gato", isOn: textToSpeech)
                            }
                            .overlay {
                                GeometryReader { geo2 in
                                    Color.clear
                                        .onAppear{
                                            catBox = geo2.frame(in: .global)
                                        }
                                }
                                .frame(width: geo.size.width/1.5 - geo.size.width/2.5, height: geo.size.height/1.9)
                                .position(x:geo.size.width/6,y:geo.size.height/1.6)
                            }
                        
                        Image(bowlImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/6, height: geo.size.height)
                            .position(x:geo.size.width/2.3,y:geo.size.height/1.26)
                            .onTapGesture {
                                speakF(text: "Tazón del gato", isOn: textToSpeech)
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
                            Image("Gato/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                            Image("Gato/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                            Image("Gato/woodenBox")
                                .resizable()
                                .frame(width: geo.size.width/3, height: geo.size.height/5)
                        }
                        .position(x:geo.size.width/3.3,y:geo.size.height/1.67)
                    }
                }
                .frame(width: geo.size.width, height: geo.size.width/1.2)
            }
            GeometryReader { geo in
                Image("Gato/gato_comida")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/3, height: geo.size.height/6)
                    .position(x:geo.size.width/1.39, y:geo.size.height/2.57)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Comida para el gato", isOn: textToSpeech)
                    }
                    .offset(dragAmountFood)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged{
                                self.dragAmountFood = CGSize(width: $0.translation.width, height: $0.translation.height)
                            }
                            .onEnded { _ in
                                if bowlBox.contains(CGPoint(x: geo.size.width/1.39 + dragAmountFood.width, y: geo.size.height/2.57 + dragAmountFood.height)) {
                                    play(sound:"catMeow1.mp3")
                                    DispatchQueue.main.async {
                                        bowlImage = "Gato/plato_lleno"
                                        catImage = "Gato/gato_comiendo"
                                        Task {
                                            play(sound:"pourFood.mp3")
                                            try? await Task.sleep(nanoseconds: UInt64(3 * 1E9))
                                            bowlImage = "Gato/plato_vacio"
                                            catImage = "Gato/gato_base"
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
                
                Image("Gato/jabon")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/2, height: geo.size.height/7)
                    .position(x:geo.size.width/1.42, y:geo.size.height/1.66)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Esponja", isOn: textToSpeech)
                    }
                    .offset(dragAmount)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged{
                                self.dragAmount = CGSize(width: $0.translation.width, height: $0.translation.height)
                            }
                            .onEnded { _ in
                                if catBox.contains(CGPoint(x: geo.size.width/1.42 + dragAmount.width, y: geo.size.height/1.66 + dragAmount.height)) {
                                    play(sound: "scrubbing.mp3")
                                    catImage = "Gato/gato_enjabonado"
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                        play(sound: "catMeow1.mp3")
                                        catImage = "Gato/gato_base"
                                    }
                                }
                                self.dragAmount = .zero
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
                Image("Gato/juguete_raton")
                    .resizable()
                    .scaledToFit()
                    .frame(width: geo.size.width/3, height: geo.size.height/6)
                    .position(x:geo.size.width/1.39, y:geo.size.height/1.23)
                    .shadow(radius: 10)
                    .onTapGesture {
                        speakF(text: "Juguete para el gato", isOn: textToSpeech)
                    }
                    .offset(dragAmountToy)
                    .gesture(
                        DragGesture(coordinateSpace: .global)
                            .onChanged{
                                self.dragAmountToy = CGSize(width: $0.translation.width, height: $0.translation.height)
                            }
                            .onEnded { _ in
                                if catBox.contains(CGPoint(x: geo.size.width/1.42 + dragAmountToy.width, y: geo.size.height/1.66 + dragAmountToy.height)) {
                                    play(sound: "catPlay.mp3")
                                    DispatchQueue.main.async {
                                        play(sound: "catMeow1.mp3")
                                        catImage = "Gato/gato_jugando"
                                        Task {
                                            try? await Task.sleep(nanoseconds: UInt64(5 * 1E9))
                                            catImage = "Gato/gato_base"
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

struct GatoDrag_Previews: PreviewProvider {
    static var previews: some View {
        GatoDrag()
    }
}
