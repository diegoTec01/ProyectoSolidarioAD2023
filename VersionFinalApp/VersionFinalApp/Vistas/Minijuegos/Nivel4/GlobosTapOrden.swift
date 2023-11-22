//
//  GlobosTapOrden.swift
//  VersionFinalApp
//
//  Created by Alejandro Lizarraga Vizcarra on 09/10/23.
//

import SwiftUI
import Subsonic

struct GlobosTapOrden: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var maxGlobos: Double = 15
    @State var minGlobos: Double = 3
    let inOrder: Bool = true
    @State var sizeGlobo: Double = 100
    
    @State private var isSettingsVisible = false
    
    @State private var counter = 0
    @State private var score = 0
    @State private var nCandles = 0
    @State private var positions: [(Float, Float)] = []
    @State private var setColors: [String] = []
    
    @State private var mostrarComunicaciones = false
    
    @State private var viewID = UUID()
    
    let balloons: [String] = ["Globos/globo_amarillo","Globos/globo_celeste","Globos/globo_indigo","Globos/globo_morado","Globos/globo_naranja","Globos/globo_rojo","Globos/globo_verde"]
    
    func changeArray(in geo: GeometryProxy) {
        print(counter)
        if counter >= nCandles {
            positions.removeAll()
            setColors.removeAll()
            nCandles = Int.random(in: Int(minGlobos)...Int(maxGlobos))
            
            let bounds = geo.frame(in: .local)
            let minX = Float(bounds.minX + (bounds.maxX-bounds.minX)*0.05)
            let minY = Float(bounds.minY + (bounds.maxY-bounds.minY)*0.2)
            let maxX = Float(bounds.maxX - (bounds.maxX-bounds.minX)*0.15)
            let maxY = Float(bounds.maxY - (bounds.maxY-bounds.minY)*0.05)
            
            for _ in 0..<nCandles {
                let randomX = Float.random(in: minX...maxX)
                let randomY = Float.random(in: minY...maxY)
                let position: (Float, Float) = (randomX, randomY)
                positions.append(position)
                setColors.append(balloons.randomElement()!)
            }
            viewID = UUID()
            counter = 0
            print("N: \(nCandles)")
        }
    }
    
    func init_sound() {
        play(sound: "select-game.wav")
    }
    
    var body: some View {
        GeometryReader{ geo2 in
            VStack {
                HStack{
                    
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
                    .padding(.top, 40)
                    
                    Spacer()
                    
                    
                    VStack{
                        GeometryReader { geo in
                            
                            
                            Text("Nivel 4")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255)))
                                .position(CGPoint(x: geo.size.width/2, y: 2 * geo.size.height/7))
                            
                            Spacer()
                            
                            
                            Text("Revienta los globos en orden ascendente")
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
                    //.padding(.top, 10)
                    .frame(height:130)
                    
                    Spacer()
                    Spacer()
                    
                    Button {
                        isSettingsVisible = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(10)
                            .background(Color.white)
                            .clipShape(Rectangle())
                            .cornerRadius(20)
                    }
                    .sheet(isPresented: $isSettingsVisible) {
                        ConfiguracionGlobo(isSettingsVisible: $isSettingsVisible, maxGlobos: $maxGlobos, minGlobos: $minGlobos, sizeGlobo: $sizeGlobo, counter: $counter, nCandles: $nCandles)
                    }
                    .padding(.trailing, 40)
                    .padding(.top, 40)
                }
                GeometryReader { geo in
                    ZStack {
                        Image("Fondos/Globos")
                            .resizable()
                            .opacity(0.50)
                        
                        ForEach(positions.indices.reversed(), id: \.self) { index in
                            let index2 = index + 1
                            VistaGlobo(counter: $counter, score: $score, inOrder: inOrder, num: index2, fSize: Int(sizeGlobo)+120, imageString: setColors[index])
                                .frame(width: CGFloat(sizeGlobo+120), height: CGFloat(sizeGlobo+120))
                                .id(viewID) // Unique identifier for each candle view
                                .position(
                                    x: CGFloat(positions[index].0),
                                    y: CGFloat(positions[index].1)
                                )
                        }
                    }
                    .background(.black)
                    .position(x: geo.frame(in: .local).midX, y: geo.frame(in: .local).midY)
                    .frame(width: geo.size.width * 0.90)
                    .onAppear {
                        changeArray(in: geo)
                    }
                    .onChange(of: counter) { _ in
                        changeArray(in: geo)
                    }
                    .onChange(of: UIDevice.current.orientation) { newOrientation in
                        changeArray(in: geo)
                    }
                }
                Text("Globos reventados: \(score)")
                    .font(.custom("HelveticaNeue", size: 40))
                    .shadow(radius: 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: 230/255, green: 230/255, blue: 230/255))
                            .frame(width: geo2.size.width/2, height: geo2.size.height/11))
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
}

struct GlobosTapOrden_Previews: PreviewProvider {
    static var previews: some View {
        GlobosTapOrden()
    }
}
