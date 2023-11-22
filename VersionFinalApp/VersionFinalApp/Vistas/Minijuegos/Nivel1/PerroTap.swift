//
//  PerroTap.swift
//  VersionFinalApp
//
//  Created by Diego Esparza Hurtado on 09/10/23.
//

import SwiftUI
import Subsonic
import AVFoundation

struct PerroTap: View {
    
    let synthesizer = AVSpeechSynthesizer()
    @State var textToSpeech = true
    
    @Environment(\.dismiss) private var dismiss
    @State var imagen = "Perro/perro_base"
    
    func init_sound() {
        play(sound: "select-game.wav")
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
                startPoint: .leading,
                endPoint: .trailing
            )
            GeometryReader { geo in
                VStack {
                    Text("NIVEL 1")
                        .font(.custom("HelveticaNeue", size: 40))
                        .onTapGesture {
                            speakF(text: "Nivel 1", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(red: 206 / 255, green: 231 / 255, blue: 65 / 255))
                                .frame(width: geo.size.width/2, height: geo.size.height/11))
                    Text("Toca el Perro")
                        .foregroundColor(Color.white)
                        .font(.custom("HelveticaNeue", size: 40))
                        .onTapGesture {
                            speakF(text: "Toca el perro", isOn: textToSpeech)
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 1, style: .continuous)
                                .fill(Color(red: 75 / 255, green: 79 / 255, blue: 113 / 255))
                                .frame(width: geo.size.width/2, height: geo.size.height/10))
                        .padding()
                }
                .frame(width: geo.size.width + geo.size.width/2.25, height: geo.size.width/5)
                GeometryReader { geo in
                    ZStack {
                        Image("Fondos/Perro")
                            .resizable()
                            .frame(width: geo.size.width - geo.size.width/15, height: geo.size.height/1.6)
                            .position(x: geo.size.width/2, y: geo.size.height/2 + geo.size.height/10)
                            .shadow(radius: 20)
                        Image(imagen)
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width/2, height: geo.size.height/1.1)
                            .position(x: geo.size.width/2, y: geo.size.height/2 + geo.size.height/9)
                            .shadow(radius: 10)
                            .onTapGesture {
                                speakF(text: "Perro", isOn: textToSpeech)
                                play(sound: "bark.wav")
                                imagen = "Perro/perro_tap"
                                Task {
                                    try? await Task.sleep(nanoseconds: UInt64(1 * 1E9))
                                    imagen = "Perro/perro_base"
                                }
                            }
                        Button(action: {
                            play(sound: "go-back.wav")
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
                
            }
            
        }
        .ignoresSafeArea()
        .onAppear() {
            init_sound()
        }
    }
    
    func speakF(text: String, isOn: Bool) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        if isOn {
            synthesizer.speak(utterance)
        }
    }
    
}

struct PerroTap_Previews: PreviewProvider {
    static var previews: some View {
        PerroTap()
    }
}
