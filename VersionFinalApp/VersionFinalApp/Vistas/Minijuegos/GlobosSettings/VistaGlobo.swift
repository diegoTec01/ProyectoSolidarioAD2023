//
//  VistaGlobo.swift
//  VersionFinalApp
//
//  Created by Alejandro Lizarraga Vizcarra on 08/10/23.
//

import SwiftUI
import Subsonic

struct VistaGlobo: View {
    @Binding var counter: Int
    @Binding var score: Int
    
    let inOrder : Bool
    
    let num: Int
    let fSize: Int
    let imageString: String
    
    @State var wasHovered: Bool = false
    
    var body: some View {
        // order of nums start
        GeometryReader { geo2 in
            ZStack{
                Image(imageString)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: CGFloat(fSize), height: CGFloat(fSize))
                
                    .opacity(wasHovered ? 0:1)
                    .position(x: geo2.frame(in: .local).midX, y: geo2.frame(in: .local).midY)
                
                
                Text("\(num)")
                    .font(.system(size: CGFloat(fSize/4)))
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .position(x: geo2.frame(in: .local).midX, y: geo2.frame(in: .local).midY - (CGFloat(fSize) * 0.3))
                    .opacity((wasHovered || !inOrder) ? 0:1)
                
            }
            .frame(width: CGFloat(fSize), height: CGFloat(fSize))
            .onTapGesture {
                if (counter + 1 == num || !inOrder){
                    counter += 1
                    score += 1
                    wasHovered = true
                    play(sound: "ballonPop.mp3")
                }
                
                
            }
        }
        
        // order of nums end
        
    }
}

struct VistaGlobo_Previews: PreviewProvider {
    static var previews: some View {
        VistaGlobo(counter: .constant(0), score: .constant(0), inOrder: true, num: 3, fSize: 999,imageString: "Globos/globo_indigo")
    }
}
