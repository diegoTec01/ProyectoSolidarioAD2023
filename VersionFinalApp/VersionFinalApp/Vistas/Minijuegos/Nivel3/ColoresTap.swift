//
//  ColoresTap.swift
//  VersionFinalApp
//
//  Created by Diego Esparza Hurtado on 09/10/23.
//

import SwiftUI
import AVFoundation
import Subsonic

class SpeechSynthesizer: ObservableObject {
    let synthesizer = AVSpeechSynthesizer()
    
    func speak(text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = 0.4
        utterance.voice = AVSpeechSynthesisVoice(language: "es-MX")
        synthesizer.speak(utterance)
    }
}

func randomColor() -> Color {
    let colores: [Color] = [.red, .green, .blue, .orange, .yellow, .purple, .gray, .white]
    return colores.randomElement()!
}

func randomOptions(including colorCorrecto: Color) -> [Color] {
    var opciones: [Color] = [colorCorrecto]
    while opciones.count < 4 {
        let opcionColor = randomColor()
        if !opciones.contains(opcionColor) {
            opciones.append(opcionColor)
        }
    }
    return opciones.shuffled()
}

struct ColoresTap: View {
    
    @StateObject private var speechSynthesizer = SpeechSynthesizer()
    @State private var puntaje = 0
    @State private var colorCorrecto = randomColor()
    @State private var opciones: [Color] = []
    @State private var showInstrucciones = true
    
    @Environment(\.dismiss) private var dismiss
    
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.mint, .cyan, .mint]), startPoint: .trailing, endPoint: .leading)
                .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                
                HStack{
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
                    .padding(.top, 40)
                    
                    Spacer()
                    VStack{
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
                            
                            
                            Text("Seleccciona el color correcto")
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
                    .padding(.top, 20)
                    .padding(.trailing, 100)
                    .frame(height:170)
                    
                    Spacer()
                }
                VStack {
                    Button (colorCorrectoEspaniol()) {
                        speechSynthesizer.speak(text: colorCorrectoEspaniol())
                    }
                    .foregroundColor(colorCorrecto)
                    .font(.custom("Avenir", size: 80))
                    .bold()
                    .shadow(color: .black, radius: 1)
                    
                    Text("Puntaje : \(puntaje)")
                        .font(.largeTitle)
                    LazyVGrid(columns: [
                        GridItem(spacing: 16),
                        GridItem(spacing: 16)
                    ], spacing: 16) {
                        ForEach(opciones, id: \.self) { color in
                            Button(action: {
                                checkAnswer(color)
                            }) {
                                RoundedRectangle(cornerRadius: 10)
                                    .foregroundColor(color)
                                    .frame(height: 200)
                                //.border(.black, width: 3)
                                    .cornerRadius(30)
                                    .shadow(radius: 20)
                            }
                        }
                    }
                    .padding()
                }
                .onAppear {
                    opciones = randomOptions(including: colorCorrecto)
                }
                
                Spacer()
            }
        }
    }
    
    private func checkAnswer(_ colorSeleccionado: Color) {
        if colorSeleccionado == colorCorrecto {
            puntaje += 1
            colorCorrecto = randomColor()
            opciones = randomOptions(including: colorCorrecto)
            speechSynthesizer.speak(text: colorCorrectoEspaniol())
        }
    }
    
    private func colorCorrectoEspaniol() -> String {
        switch colorCorrecto {
        case .red:
            return "ROJO"
        case .green:
            return "VERDE"
        case .blue:
            return "AZUL"
        case .orange:
            return "NARANJA"
        case .yellow:
            return "AMARILLO"
        case .purple:
            return "MORADO"
        case .gray:
            return "GRIS"
        case .white:
            return "BLANCO"
        default:
            return "COLOR"
        }
    }
    
}

struct ColoresTap_Previews: PreviewProvider {
    static var previews: some View {
        ColoresTap()
    }
}
