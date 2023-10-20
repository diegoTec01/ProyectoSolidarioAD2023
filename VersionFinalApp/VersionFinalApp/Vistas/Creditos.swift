//
//  Creditos.swift
//  VersionFinalApp
//
//  Created by Diego Esparza on 12/10/23.
//

import SwiftUI

struct Creditos: View {
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 125/255 , green: 132/255 , blue: 199/255), Color(red: 83/255 , green: 88/255 , blue: 128/255)]), startPoint: .trailing, endPoint: .leading)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Sobre FlowComms")
                    .font(.custom("HelveticaNeue", size: 40))
                    
                    .fontWeight(.bold)
                    .padding(.top, 20)
                
                VStack(alignment: .leading){
                    Text("FlowComms ha sido desarrollada por estudiantes del Tecnológico de Monterrey durante el periodo de Abril a Octubre del 2023.")
                        .font(.custom("HelveticaNeue", size: 22))
                    
                    Text("Créditos")
                        .font(.custom("HelveticaNeue", size: 30))
                        .bold()
                        .padding(.top, 25)
                        .padding(.bottom, 10)
                    
                    Text("Desarrolladores")
                        .font(.custom("HelveticaNeue", size: 25))
                        .bold()
                        .padding(.top, 5)
                        .padding(.bottom, 1)
                    
                    Text("Diego Esparza Hurtado\nAlejandro Lizárraga Vizcarra\nNicolas Aguirre Villafañe\nLeonardo González Guerra\nSamuel Acosta Ugarte")
                        .font(.custom("HelveticaNeue", size: 20))
                        .padding(.bottom, 15)
                    
                    Text("Ilustraciones")
                        .font(.custom("HelveticaNeue", size: 25))
                        .bold()
                        .padding(.bottom, 1)
                    
                    Text("Jackeline Conant Rubalcava")
                        .font(.custom("HelveticaNeue", size: 20))
                        .padding(.bottom, 15)
                    
                    Text("Profesores Asesores")
                        .font(.custom("HelveticaNeue", size: 25))
                        .bold()
                        .padding(.bottom, 1)
                    
                    Text("Yolanda Martínez Treviño\nJorge Mora MacBeath")
                        .font(.custom("HelveticaNeue", size: 20))
                        .padding(.bottom, 25)
                    
                    Text("Flowcomms se distribuye como está de manera gratuita y se prohibe su distribución y uso con fines de lucro.")
                        .font(.custom("HelveticaNeue", size: 22))
                    
                }
                .padding(.top, 1)
                .padding(.leading, 15)
                .padding(.trailing, 15)
                
                Spacer()
                
            }
            .foregroundColor(.white)
            
        }
        .ignoresSafeArea()
        
        
    }
}

struct Creditos_Previews: PreviewProvider {
    static var previews: some View {
        Creditos()
    }
}
