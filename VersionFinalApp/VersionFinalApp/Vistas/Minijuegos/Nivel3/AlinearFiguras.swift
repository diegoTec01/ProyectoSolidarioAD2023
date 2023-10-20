//
//  AlinearFiguras.swift
//  VersionFinalApp
//
//  Created by Diego Esparza on 11/10/23.
//

import SwiftUI
import Subsonic

struct AlinearFiguras: View {
    
    @State var offset: CGSize = .zero
        @State private var image1Position = CGPoint(x: 100, y: 100)
        @State private var image2Position = CGPoint(x: 250, y: 100)
        @State private var woodboxCirculo = "AlinearFiguras/woodbox_circulo"
        @State private var woodboxTriangulo = "AlinearFiguras/woodbox_triangulo"
        @State private var woodboxCuadrado = "AlinearFiguras/woodbox_cuadrado"
        @State private var woodboxOvalo = "AlinearFiguras/woodbox_ovalo"
        @State private var woodboxPoligono = "AlinearFiguras/woodbox_poligono"
        @State private var woodboxRectangulo = "AlinearFiguras/woodbox_rectangulo"
        @State private var circulo = ""
        @State private var triangulo = ""
        @State private var cuadrado = ""
        @State private var rectangulo = ""
        @State private var poligono = ""
        @State private var ovalo = ""
        
        
        
        
        @Environment(\.dismiss) private var dismiss
        @State private var mostrarMenu = false
        
        @State private var mostrarComunicaciones = false
        
        @State var circuloBox = CGRect.zero
        @State var trianguloBox = CGRect.zero
        @State var cuadradoBox = CGRect.zero
        @State var rectanguloBox = CGRect.zero
        @State var poligonoBox = CGRect.zero
        @State var ovaloBox = CGRect.zero
        @State var emptyWoodbox = CGRect.zero
        
        @State var dragAmountCirculo = CGSize.zero
        @State var dragAmountTriangulo = CGSize.zero
        @State var dragAmountCuadrado = CGSize.zero
        @State var dragAmountRectangulo = CGSize.zero
        @State var dragAmountPoligono = CGSize.zero
        @State var dragAmountOvalo = CGSize.zero
        @State var dragAmountEmptyWoodbox = CGSize.zero
        
        @State private var dragStartedX: CGFloat = 0
        @State private var dragStartedY: CGFloat = 0


        
        var body: some View {
            VStack(){
                
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
                            
                            
                            Text("Alinear Figuras")
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
                    //.background(Color.red)
                    
                    Spacer()
                    Spacer()
                    Spacer()
                }
                
                
                
                GeometryReader { geo in
                    HStack {
                        GeometryReader { geo2 in
                            ZStack{
                                
                                Group{
                                    
                                    Image("Fondos/Figuras")
                                        .resizable()
                                        .frame(width:geo2.size.width*1,height:geo2.size.height*1.0)
                                        .scaledToFill()
                                        .opacity(0.3)
                                        .blur(radius: 5)
                                    
                                    
                                    // 3 bloques de arriba
                                    GeometryReader{ geo3 in
                                        Image(woodboxCirculo)
                                            .resizable()
                                            .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                            .scaledToFit()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        circuloBox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .overlay {
                                        Color.clear
                                    }
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .offset(x:geo2.size.width*(-0.34), y:geo2.size.height*(-0.16))
                                    
                                    
                                    GeometryReader{ geo3 in
                                        Image(woodboxTriangulo)
                                            .resizable()
                                            .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                            .scaledToFit()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        trianguloBox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .offset(x:geo2.size.width*(0), y:geo2.size.height*(-0.16))
                                    
                                    
                                    GeometryReader{ geo3 in
                                        Image(woodboxCuadrado)
                                            .resizable()
                                            .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                            .scaledToFit()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        cuadradoBox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .offset(x:geo2.size.width*(0.33), y:geo2.size.height*(-0.16))
                                    
                                    GeometryReader{ geo3 in
                                        Image(woodboxRectangulo)
                                            .resizable()
                                            .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                            .scaledToFit()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        rectanguloBox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .offset(x:geo2.size.width*(-0.33), y:geo2.size.height*(0.18))
                                    
                                    
                                    GeometryReader{ geo3 in
                                        Image(woodboxPoligono)
                                            .resizable()
                                            .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                            .scaledToFit()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        poligonoBox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .offset(x:geo2.size.width*(0), y:geo2.size.height*(0.18))
                                    
                                    
                                    GeometryReader{ geo3 in
                                        Image(woodboxOvalo)
                                            .resizable()
                                            .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                            .scaledToFit()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        ovaloBox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                    .offset(x:geo2.size.width*(0.33), y:geo2.size.height*(0.18))
                                    
                                    GeometryReader{ geo3 in
                                        Rectangle()
                                            .fill(.clear)
                                            .frame(width:geo2.size.width*0.9,height:geo2.size.height*0.6)
                                            .scaledToFill()
                                            .overlay {
                                                Color.clear
                                                    .onAppear{
                                                        emptyWoodbox = geo3.frame(in: .global)
                                                    }
                                            }
                                    }
                                    .offset(x:geo2.size.width*0.04,y:geo2.size.height*0.2)
                                    
                                }
                                
                                ZStack{
                                    Image(circulo)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.26)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*(-0.34), y:geo2.size.height*(-0.16))
                                    
                                    Image(triangulo)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*(0), y:geo2.size.height*(-0.155))
                                    
                                    Image(cuadrado)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*(0.33), y:geo2.size.height*(-0.156))
                                    
                                    Image(rectangulo)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*(-0.33), y:geo2.size.height*(0.184))
                                    
                                    Image(poligono)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*(0), y:geo2.size.height*(0.184))
                                    
                                    Image(ovalo)
                                        .resizable()
                                        .frame(width:geo2.size.width*0.33,height:geo2.size.height*0.27)
                                        .scaledToFill()
                                        .offset(x:geo2.size.width*(0.33), y:geo2.size.height*(0.184))
                                }
                            }
                        }
                        .padding()
                        
                        VStack(){
                            GeometryReader { geo2 in
                                //Aqui va lo relacionando con arrastrar y soltar
                                Image("AlinearFiguras/figura_circulo")
                                    .resizable()
                                    .offset(dragAmountCirculo)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountCirculo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if circuloBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.height*0.25 + dragAmountCirculo.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.15 + dragAmountCirculo.height)) {
                                                    DispatchQueue.main.async {
                                                        circulo = "AlinearFiguras/figura_circulo"
                                                    }
                                                }
                                                self.dragAmountCirculo = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.9, height: geo2.size.height*0.25)
                                    .position(CGPoint(x: geo2.size.width*0.23, y: geo2.size.height*0.15))
                                
                                Image("AlinearFiguras/figura_triangulo")
                                    .resizable()
                                    .offset(dragAmountTriangulo)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountTriangulo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if trianguloBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.75 + dragAmountTriangulo.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.15 + dragAmountTriangulo.height))  {
                                                    DispatchQueue.main.async {
                                                        triangulo = "AlinearFiguras/figura_triangulo"
                                                    }
                                                }
                                                self.dragAmountTriangulo = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.8, height: geo2.size.height*0.25)
                                    .position(CGPoint(x: geo2.size.width*0.75, y: geo2.size.height*0.15))
                                
                                Image("AlinearFiguras/figura_cuadrado")
                                    .resizable()
                                    .offset(dragAmountCuadrado)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountCuadrado = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if cuadradoBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.23 + dragAmountCuadrado.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.4 + dragAmountCuadrado.height)) {
                                                    DispatchQueue.main.async {
                                                        cuadrado = "AlinearFiguras/figura_cuadrado"
                                                    }
                                                }
                                                self.dragAmountCuadrado = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.8, height: geo2.size.height*0.27)
                                    .position(CGPoint(x: geo2.size.width*0.23, y: geo2.size.height*0.4))
                                
                                Image("AlinearFiguras/figura_ovalo")
                                    .resizable()
                                    .offset(dragAmountOvalo)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountOvalo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if ovaloBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.75 + dragAmountOvalo.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.4 + dragAmountOvalo.height)) {
                                                    DispatchQueue.main.async {
                                                        ovalo = "AlinearFiguras/figura_ovalo"
                                                    }
                                                }
                                                self.dragAmountOvalo = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.7, height: geo2.size.height*0.25)
                                    .position(CGPoint(x: geo2.size.width*0.75, y: geo2.size.height*0.4))
                                
                                Image("AlinearFiguras/figura_poligono")
                                    .resizable()
                                    .offset(dragAmountPoligono)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountPoligono = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if poligonoBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) +  geo2.size.width*0.23 + dragAmountPoligono.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountPoligono.height)) {
                                                    DispatchQueue.main.async {
                                                        poligono = "AlinearFiguras/figura_poligono"
                                                    }
                                                }
                                                self.dragAmountPoligono = .zero
                                            }
                                    )
                                
                                    .frame(width: geo2.size.width*0.7, height: geo2.size.height*0.25)
                                    .position(CGPoint(x: geo2.size.width*0.23, y: geo2.size.height*0.65))
                                
                                Image("AlinearFiguras/figura_rectangulo")
                                    .resizable()
                                    .offset(dragAmountRectangulo)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountRectangulo = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if rectanguloBox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.75 + dragAmountRectangulo.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.65 + dragAmountRectangulo.height)) {
                                                    DispatchQueue.main.async {
                                                        rectangulo = "AlinearFiguras/figura_rectangulo"
                                                    }
                                                }
                                                self.dragAmountRectangulo = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.7, height: geo2.size.height*0.25)
                                    .position(CGPoint(x: geo2.size.width*0.75, y: geo2.size.height*0.65))
                            
                                
                                Image("AlinearFiguras/empty_woodbox")
                                    .resizable()
                                    .offset(dragAmountEmptyWoodbox)
                                    .gesture(
                                        DragGesture(coordinateSpace: .global)
                                            .onChanged{
                                                self.dragAmountEmptyWoodbox = CGSize(width: $0.translation.width, height: $0.translation.height)
                                            }
                                            .onEnded { _ in
                                                if emptyWoodbox.contains(CGPoint(x: (geo2.frame(in: .global).minX) + geo2.size.width*0.53 + dragAmountEmptyWoodbox.width, y: (geo2.frame(in: .global).minY) + geo2.size.height*0.85 + dragAmountEmptyWoodbox.height)) {
                                                    DispatchQueue.main.async {
                                                        circulo = ""
                                                        triangulo = ""
                                                        cuadrado = ""
                                                        rectangulo = ""
                                                        poligono = ""
                                                        ovalo = ""
                                                    }
                                                }
                                                self.dragAmountEmptyWoodbox = .zero
                                            }
                                    )
                                    .frame(width: geo2.size.width*0.6, height: geo2.size.height*0.15)
                                    .position(CGPoint(x: geo2.size.width*0.53, y: geo2.size.height*0.85))
                                
                            }
                        }
                        .frame(width: geo.size.width*0.25)
                        .background(Color(red: 0.5, green: 0.65, blue: 0.7))
                        .padding()
                    }
                    .background(.white)
                    .padding()
                }
                
                Spacer()
                
            }
            .background(LinearGradient(
                gradient: Gradient(colors: [Color(red: 135 / 255, green: 132 / 255, blue: 255 / 255), Color.green]),
                startPoint: .leading,
                endPoint: .trailing
            ))
        }
    
}

struct AlinearFiguras_Previews: PreviewProvider {
    static var previews: some View {
        AlinearFiguras()
    }
}

