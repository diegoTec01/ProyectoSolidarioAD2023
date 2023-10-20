//
//  Xilofono.swift
//  VersionFinalApp
//
//  Created by Diego Esparza on 11/10/23.
//

import SwiftUI
import AudioToolbox
import Subsonic

struct Xilofono: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let colors: [Color] = [.red, .orange, .yellow, .green, .blue, .purple, .pink]
    let notes: [String] = ["Do", "Re", "Mi", "Fa", "Sol", "La", "Si"]
    let buttonSize: CGFloat = 70

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
                            
                            
                            Text("Toca el Xilófono")
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
                    let isHorizontal = geometry.size.width > geometry.size.height

                    VStack(spacing: isHorizontal ? 8 : 20) {
                        Spacer(minLength: 10)
                        if isHorizontal {
                            HStack() {
                                Spacer(minLength: 0)
                                createButtons(width: geometry.size.width - 150, height: geometry.size.height - 200)
                                Spacer(minLength: 0)
                            }
                        } else {
                            createButtons(width: geometry.size.width - 20, height: (geometry.size.height - 60) / CGFloat(notes.count) - 8)
                        }
                        Spacer(minLength: 10)
                    }
                    .padding(50)
                    //.background(LinearGradient(gradient: Gradient(colors: [.purple, .cyan]), startPoint: .top, endPoint: .bottom))
                    //.edgesIgnoringSafeArea(.all)
                }
                
                Spacer()
                
            }
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [.purple, .blue]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        )
        
        
        
        
        
    }

    func createButtons(width: CGFloat, height: CGFloat) -> some View {
        HStack(spacing: 9) {
            ForEach(Array(zip(notes, colors)), id: \.0) { note, color in
                Button(action: {
                    playSound(note: note)
                }) {
                    Text(note)
                        .font(.system(size: 60, weight: .bold, design: .default))
                        .frame(width: width / CGFloat(notes.count) - 8, height: height)
                        .background(color)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        .overlay(
                            Circle()
                                .frame(width: width * 0.6, height: height * 0.10)
                                .foregroundColor(.white)
                                .opacity(0.6)
                                .offset(y: -height * 0.4)
                        )
                        .overlay(
                            Circle()
                                .frame(width: width * 0.6, height: height * 0.10)
                                .foregroundColor(.white)
                                .opacity(0.6)
                                .offset(y: height * 0.4)
                        )
                }
            }
        }
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

struct Xilofono_Previews: PreviewProvider {
    static var previews: some View {
        Xilofono()
    }
}
