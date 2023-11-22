//
//  Restas.swift
//  VersionFinalApp
//
//  Created by Diego Esparza Hurtado on 09/10/23.
//

import SwiftUI
import Subsonic

struct Restas: View {
    
    //Funcion de números a restar
    @State private var numerorandom1 = Int.random(in: 10...20)
    @State private var numerorandom2 = Int.random(in: 1...10)
    //variable que almacena la suma
    @State private var restaNumeros = 0
    @State private var textoResta = " "
    @State private var election = 0
    @State private var electiontwo = 0
    @State var arregloDeNumeros = [Int]()
    @State var calculadora = "Fondos/Calculadora"
    @State var resta = 0
    
    @State private var totalRight = -1
    
    @Environment(\.dismiss) private var dismiss
    @State private var mostrarMenu = false
    
    @State private var mostrarComunicaciones = false
    
    func generarRandom(){
        
        totalRight = totalRight + 1
        play(sound: "correct-2.wav")
        
        arregloDeNumeros = [Int]()
        numerorandom1 = Int.random(in: 10...20)
        numerorandom2 = Int.random(in: 1...10)
        let restaNumeros = numerorandom1 - numerorandom2
        var restaNumerosFalsa = Int.random(in: 1...20)
        while(restaNumeros == restaNumerosFalsa){
            restaNumerosFalsa = Int.random(in: 1...20)
        }
        arregloDeNumeros.append(restaNumeros)
        arregloDeNumeros.append(restaNumerosFalsa)
        arregloDeNumeros.shuffle()
        
        election = arregloDeNumeros[0]
        electiontwo = arregloDeNumeros[1]
        
    }
    var body: some View {
        
        VStack {
            
            HStack {
                GeometryReader { geometry in
                    //Spacer()
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
                    
                    VStack(){
                        
                        
                        GeometryReader { geo in
                            
                            
                            Text("Nivel 4")
                                .font(.custom("HelveticaNeue", size: 40))
                                .shadow(radius: 10)
                                .fontWeight(.bold)
                                .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(red: 229/255 , green: 137/255 , blue: 255/255)))
                                .position(CGPoint(x: geo.size.width/2, y: 2*geo.size.height/10))
                            
                            
                            Text("Resta de números")
                                .font(.custom("HelveticaNeue", size: 20))
                                .foregroundColor(Color.white)
                                .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.35)
                                .bold()
                                .cornerRadius(20)
                                .background(
                                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                                        .fill(Color(red: 0.295, green: 0.31, blue: 0.441)))
                                .position(CGPoint(x: geo.size.width/2, y: 7 * geo.size.height/10))
                            
                        }
                        
                    }
                    .frame(height:170)
                    
                    Spacer()
                }
            }
            
            ZStack{
                Image(calculadora)
                    .resizable()
                    .frame(width: 800,height: 700)
                    .offset(x:0, y:65)
                //Texto de suma que va cambiandolet  _ = self.generarRandom()
                let textoResta = "\(numerorandom1) - \(numerorandom2)"
                //Texto que muestra la operación
                Text(textoResta)
                    .font(.custom("HelveticNeue", size: 100))
                    .font(.largeTitle)
                
                    .offset(x:0, y:-70)
                
                let restaNumeros2 = numerorandom1 - numerorandom2
                HStack{
                    Button ("\(election)"){
                        if (election == restaNumeros2){
                            play(sound: "correct-1.wav")
                            generarRandom()
                            
                        }
                        
                    }
                    .font(.custom("HelveticNeue", size: 100))
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    .tint(Color(red: 0.936, green: 0.746, blue: 0.073))
                    .padding(50)
                    
                    
                    Button ("\(electiontwo)"){
                        if (electiontwo == restaNumeros2){
                            play(sound: "correct-1.wav")
                            generarRandom()
                            
                        }
                    }
                    .font(.custom("HelveticNeue", size: 100))
                    .foregroundColor(.white)
                    .buttonStyle(.borderedProminent)
                    //.background(.purple)
                    .tint(Color(red: 0.936, green: 0.746, blue: 0.073))
                    .padding(50)
                    
                    
                }
                .offset(x:0, y:250)
                
                Text("Acertados: \(totalRight)")
                    .font(.custom("HelveticaNeue", size: 20))
                    .foregroundColor(Color.white)
                    .bold()
                    .offset(x:0, y:-260)
            }
        }
        .onAppear{
            generarRandom()
        }
        
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
    
}

struct Restas_Previews: PreviewProvider {
    static var previews: some View {
        Restas()
    }
}
