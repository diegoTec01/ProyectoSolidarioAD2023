//
//  Piano.swift
//  VersionFinalApp
//
//  Created by Diego Esparza on 11/10/23.
//

import SwiftUI
import AudioToolbox
import Subsonic

struct Piano: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let whiteKeys: [String] = ["C_piano", "D_piano", "E_piano", "F_piano", "G_piano", "A_piano", "B_piano"]
    let blackKeys: [String?] = ["CS_piano", "DS_piano", nil, "FS_piano", "GS_piano", "AS_piano"]

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
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
                            
                            
                            Text("Toca el piano")
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
                
                GeometryReader { geometry in
                    let keyWidth = geometry.size.width / CGFloat(whiteKeys.count)
                    let blackKeyWidth = keyWidth * 0.6
                    
                    ZStack {
                        createWhiteKeys(keyWidth: keyWidth, keyHeight: geometry.size.height)
                        createBlackKeys(keyWidth: blackKeyWidth, keyHeight: geometry.size.height * 0.5, whiteKeyWidth: keyWidth)
                    }
                    .padding(10)
                }
                .scaleEffect(0.7) // scale the entire piano to 70%
                //.background(LinearGradient(gradient: Gradient(colors: [.purple, .cyan]), startPoint: .top, endPoint: .bottom))
                
                Spacer()
                
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
    }

    func createWhiteKeys(keyWidth: CGFloat, keyHeight: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(whiteKeys, id: \.self) { key in
                Button(action: {
                    playSound(note: key)
                }) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: keyWidth, height: keyHeight)
                        .cornerRadius(5)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        .overlay(
                            RoundedRectangle(cornerRadius: 5)
                                .stroke(Color.black, lineWidth: 3)
                        )
                }
            }
        }
    }

    func createBlackKeys(keyWidth: CGFloat, keyHeight: CGFloat, whiteKeyWidth: CGFloat) -> some View {
        HStack(spacing: 0) {
            ForEach(blackKeys.indices, id: \.self) { index in
                if let key = blackKeys[index] {
                    Button(action: {
                        playSound(note: key)
                    }) {
                        Rectangle()
                            .foregroundColor(.black)
                            .frame(width: keyWidth, height: keyHeight)
                            .cornerRadius(5)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(Color.white, lineWidth: 2)
                            )
                    }
                    .padding(.leading, (whiteKeyWidth - keyWidth) / 2)
                    .padding(.trailing, (whiteKeyWidth - keyWidth) / 2)
                } else {
                    Spacer()
                        .frame(width: whiteKeyWidth)
                }
            }
        }
        .offset(y: -keyHeight / 2)
    }

    func playSound(note: String) {
        guard let url = Bundle.main.url(forResource: note, withExtension: "wav") else {
            return
        }

        var soundID: SystemSoundID = 0
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
        AudioServicesPlaySystemSound(soundID)
    }
    
}

struct Piano_Previews: PreviewProvider {
    static var previews: some View {
        Piano()
    }
}






