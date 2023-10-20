//
//  MenuPrincipal.swift
//  VersionFinalApp
//
//  Created by Diego Esparza on 08/10/23.
//

import SwiftUI



struct MenuPrincipal: View {
    @State private var selectedLevel = 0
    let levels = ["Nivel 1", "Nivel 2", "Nivel 3", "Nivel 4"]
    let titulos = ["Presionar", "Arrastrar", "Presionar y arrastrar", "Operaciones"]
    
    init() {
        
        //This changes the "thumb" that selects between items
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(red: 252/255, green: 218/255, blue: 254/255, alpha: 1.0)
        
        //This changes the color for the whole "bar" background
        UISegmentedControl.appearance().backgroundColor = .white
        
        
        //This will change the font size
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .headline)], for: .highlighted)
        UISegmentedControl.appearance().setTitleTextAttributes([.font : UIFont.preferredFont(forTextStyle: .title2)], for: .normal)
        
        //these lines change the text color for various states
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .highlighted)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor : UIColor.black], for: .selected)
    }
    
    let gamesPerLevel: [String: [(AnyView, String, String)]] = [
        "Nivel 1": [
            (AnyView(PerroTap()), "Perro", "Menu/perro_1"),
            (AnyView(GatoTap()), "Gato", "Menu/gato_1"),
            (AnyView(Bateria()), "Batería", "Menu/bateria"),
            (AnyView(Piano()), "Piano", "Menu/piano"),
            (AnyView(Xilofono()), "Xilófono", "Menu/xilofono")
        ],
        
        "Nivel 2": [
            (AnyView(DecorarPastel()), "Decorar Pastel", "Menu/pastel_1"),
            (AnyView(GlobosTap()), "Reventar Globos", "Menu/globo_1"),
            (AnyView(AvionTap()), "Avión", "Menu/avion")
        ],
        
        "Nivel 3": [
            (AnyView(DecorarPastelComplejo()), "Decorar Pastel", "Menu/pastel_2"),
            (AnyView(ColoresTap()), "Colores", "Menu/colores"),
            (AnyView(AlinearFiguras()), "Alinear Figuras", "Menu/figuras"),
            (AnyView(GatoDrag()), "Gato", "Menu/gato_2"),
            (AnyView(PerroDrag()), "Perro", "Menu/perro_2")
            
        ],
        
        "Nivel 4": [
            (AnyView(Sumas()), "Sumas", "Menu/suma"),
            (AnyView(Restas()), "Restas", "Menu/resta"),
            (AnyView(GlobosTapOrden()), "Reventar Globos", "Menu/globo_2")
        ],
    ]
    @State private var isGameViewPresented = false
    @State private var selectedGameNumber = 0
    @State private var preloadedGameViews: [AnyView?] = Array(repeating: nil, count: 4)
    @State private var currentGameView: AnyView?
    
    @State private var isCreditsViewPresented = false
    
    var columnsForLevel: Int {
        let gamesCount = gamesPerLevel[levels[selectedLevel]]?.count ?? 1
        return max(3, Int(ceil(sqrt(Double(gamesCount)))))
    }
    
    var firstTitle: String {
        return titulos[selectedLevel]
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color(red: 46/255 , green: 155/255 , blue: 240/255), Color(red: 23/255 , green: 205/255 , blue: 212/255)]), startPoint: .trailing, endPoint: .leading)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack{
                    
                    Button(action: {
                        isCreditsViewPresented = true
                    }) {
                        Image(systemName: "info.circle")
                            .font(.custom("HelveticaNeue", size: 40))
                            .foregroundColor(.white)
                            .bold()
                            .padding(10)
//                            .background(Color.white)
//                            .clipShape(Rectangle())
//                            .cornerRadius(20)
                    }
                    //.padding(.leading, 40)
                    //.padding(.top, 15)
                    .padding(.leading, 50)
                    .sheet(isPresented: $isCreditsViewPresented) {
                            Creditos()
                    }
                    
                    Spacer()
                    Spacer()
                    
                    Text(firstTitle)
                        .font(.custom("HelveticaNeue", size: 40))
                        .fontWeight(.bold)
                        .padding(15)
                        .shadow(radius: 10)
                        .background(
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(Color(red: 252/255 , green: 218/255 , blue: 254/255))
                        )
                        //.padding(.top, 15)
                        .padding(.trailing, 120)
                    
                    Spacer()
                    Spacer()
                    
                    
                    
                    

                }
                
                Spacer()
                
                if let gameInfos = gamesPerLevel[levels[selectedLevel]] {
                    LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: columnsForLevel), spacing: 20) {
                        ForEach(gameInfos.indices, id: \.self) { index in
                            let (gameView, gameTitle, gameImage) = gameInfos[index]
                            let isGameViewPreloaded = preloadedGameViews[selectedLevel] != nil
                            
                            VStack {
                                Button(action: {
                                    selectedGameNumber = index
                                    if isGameViewPreloaded {
                                        currentGameView = gameView
                                        isGameViewPresented = true
                                    } else {
                                        preloadedGameViews[selectedLevel] = gameView
                                        currentGameView = gameView
                                        isGameViewPresented = true
                                    }
                                    print(gameTitle)
                                    print(index)
                                    print(" ")
                                }) {
                                    Image(gameImage)
                                        .resizable()
                                        .aspectRatio(1, contentMode: .fit)
                                        //.background(Color(red: 124/255 , green: 244/255 , blue: 244/255))
                                        .frame(width: 200, height: 200)
                                        //.cornerRadius(10)
                                        .shadow(radius: 20)
                                }
                                //.frame(width: 200, height: 200)
                                .fullScreenCover(isPresented: $isGameViewPresented) {
                                    //if selectedGameNumber != nil {
                                        gameInfos[selectedGameNumber].0
                                    //} else {
                                        //EmptyView()
                                    //}
                                    
                                }
                                
                                Text(gameTitle)
                                    .foregroundColor(.white)
                                    .padding(.all, 0)
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .padding(.horizontal, 20)
                                    .shadow(radius: 10)
                                
                            }
                        }
                    }
                    .padding()
                }
                
                Spacer()
                Spacer()
                
                Picker("Level", selection: $selectedLevel) {
                    ForEach(0..<levels.count, id: \.self) { index in
                        Text(levels[index])
                            .fontWeight(.bold)
                            .font(.custom("HelveticaNeue", size: 80))
                            .tag(index)
                            .padding(30)
                        
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .frame(height: 50)
                .padding(.horizontal)
                .padding(.bottom, 40)
            }
            .padding(.top, 40)
        }
        .ignoresSafeArea()
    }
    
}

struct MenuPrincipal_Previews: PreviewProvider {
    static var previews: some View {
        MenuPrincipal()
    }
}
