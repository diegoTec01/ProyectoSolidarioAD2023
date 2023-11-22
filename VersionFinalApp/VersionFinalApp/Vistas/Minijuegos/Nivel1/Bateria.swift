//
//  Bateria.swift
//  VersionFinalApp
//
//  Created by Diego Esparza on 11/10/23.
//

import SwiftUI
import AudioToolbox
import Subsonic

struct DrumButton: View {
    let sound: String
    let piece: String
    
    var body: some View {
        Button(action: {
            play(sound: "Sonidos/Intrumentos/\(sound).wav")
            playSound(sound: sound)
        }) {
//            ZStack {
//                RoundedRectangle(cornerRadius: 20)
//                    .fill(color)
//                    .frame(width: 200, height: 120)
//                    .overlay(
//                        RoundedRectangle(cornerRadius: 20)
//                            .stroke(Color.white, lineWidth: 3)
//                    )
//                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
//
//                Text(sound.prefix(1).uppercased() + sound.dropFirst())
//                    .foregroundColor(.white)
//                    .fontWeight(.bold)
//                    .font(.system(size: 18))
//            }
            Image("Bateria/\(piece)")
                .resizable()
                .aspectRatio(1,contentMode: .fit)
                //.background(Color(red: 124/255 , green: 244/255 , blue: 244/255))
                .frame(width: 200, height: 200)
        }
    }
    
    func playSound(sound: String) {
        if let soundURL = Bundle.main.url(forResource: sound, withExtension: "wav") {
            var soundID: SystemSoundID = 0
            AudioServicesCreateSystemSoundID(soundURL as CFURL, &soundID)
            AudioServicesPlaySystemSound(soundID)
        }
    }
}

struct Bateria: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let drumSounds: [String] = ["hi-hat", "snare", "kick", "tom", "crash"]
    let drumPieces: [String] = ["b4_izq","b1_izq","b3_medio","b1_der","b5_der"]
    
    func init_sound() {
        play(sound: "select-game.wav")
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                Spacer()
                
                HStack {
                    Button(action: {
                        play(sound: "go-back.wav")
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
                            
                            
                            Text("Nivel 1")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255)))
                                .position(CGPoint(x: geo.size.width/2, y: 2 * geo.size.height/7))
                            
                            Spacer()
                            
                            
                            Text("Toca la batería")
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
                    
                    Spacer()
                    Spacer()
                    Spacer()
                    
                }
                
                Spacer()
                Spacer()
                
                //VStack {
                    //Spacer()
                    HStack {
                        Spacer()
                        VStack {
                            DrumButton(sound: drumSounds[0], piece: drumPieces[0])
                            DrumButton(sound: drumSounds[1], piece: drumPieces[1])
                        }
                        Spacer()
                        VStack {
                            DrumButton(sound: drumSounds[4], piece: drumPieces[4])
                            DrumButton(sound: drumSounds[3], piece: drumPieces[3])
                        }
                        Spacer()
                    }
                    Spacer()
                    HStack {
                        Spacer()
                        DrumButton(sound: drumSounds[2], piece: drumPieces[2])
                        Spacer()
                    }
                    Spacer()
                //}
                //.background(LinearGradient(gradient: Gradient(colors: [.purple, .cyan]), startPoint: .leading, endPoint: .trailing))
                
                Spacer()
                
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        .onAppear() {
            init_sound()
        }
    }
    
}

struct Bateria_Previews: PreviewProvider {
    static var previews: some View {
        Bateria()
    }
}
