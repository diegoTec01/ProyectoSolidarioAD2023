//
//  AvionTap.swift
//  VersionFinalApp
//
//  Created by Alejandro Lizarraga Vizcarra on 09/10/23.
//

import SwiftUI
import Subsonic

struct AvionTap: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var buttonPosition: CGPoint = .zero
    @State private var targetPosition: CGPoint = .zero
    let buttonSize: CGFloat = 125
    
    @State private var score: Int = 0
    
    @State private var speed: Double = 150
    let minSpeed: Int = 150 // Variable speed
    let maxSpeed: Int = 500 // Variable speed
    let gameAreaSize: CGSize = CGSize(width: 300, height: 300)
    
    @State private var planeAngle: Double = 0.0
    
    let Hpad: CGFloat = 50
    let Vpad: CGFloat = 50
    @State private var flightArea = CGSize.zero
    
    @State private var timer: Timer? // Declare the timer variable
    
    
    var body: some View {
        VStack{
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
                        
                        
                        Text("Nivel 2")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .frame(width: geo.size.width * 0.45, height: geo.size.height * 0.45)
                            .cornerRadius(20)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(Color(red: 251/255 , green: 198/255 , blue: 18/255)))
                            .position(CGPoint(x: geo.size.width/2, y: 2 * geo.size.height/7))
                        
                        Spacer()
                        
                        
                        Text("Presiona el avión")
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
                .frame(height:170)
                
                Spacer()
                
                Text("puntos:\n\(score)")
                    .font(.custom("HelveticaNeue", size: 25))
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .shadow(radius: 10)
                    .background(
                        RoundedRectangle(cornerRadius: 10, style: .continuous)
                            .fill(Color(red: 230/255, green: 230/255, blue: 230/255))
                    )
                    .padding(.trailing, 40)
                    .padding(.top, 40)
            }
            ZStack {
                
                Color(red: 200/255, green: 200/255, blue: 200/255)
                    .edgesIgnoringSafeArea(.all)
                    .cornerRadius(40)
                    .padding(30)
                
                GeometryReader { geo in
                    Image("Fondos/Avion")
                    //.stroke(Color.clear, lineWidth: 4)
                        .resizable()
                        .cornerRadius(40)
                        .onAppear {
                            self.flightArea = CGSize(width: geo.size.width - (Hpad*2), height: geo.size.height - (Vpad*2))
                        }
                }
                
                Button(action: {
                    score += 1
                    moveButton(to: randomPosition(in: gameAreaSize), withSpeed: speed)
                }) {
                    Image("Avion/avion")
                        .resizable()
                        .frame(width: buttonSize, height: buttonSize)
                    //                        .font(.system(size: buttonSize))
                        .foregroundColor(.blue)
                        .rotationEffect(.degrees(planeAngle))
                }
                .position(buttonPosition)
                
            }
            .padding(30)
            .onAppear {
                // Start the game by moving the button to a random position with variable speed
                moveButton(to: randomPosition(in: gameAreaSize), withSpeed: speed)
            }
        }
        .background(LinearGradient(
            gradient: Gradient(colors: [Color(red: 125 / 255, green: 132 / 255, blue: 199 / 255), Color.purple]),
            startPoint: .leading,
            endPoint: .trailing
        ))
    }
    
    func randomPosition(in size: CGSize) -> CGPoint {
        let x = CGFloat.random(in: Hpad...(Hpad+flightArea.width))
        let y = CGFloat.random(in: Vpad...(Vpad+flightArea.height))
        return CGPoint(x: x, y: y)
    }
    
    func moveButton2(to position: CGPoint, withSpeed speed: Double) {
        let deltaX = position.x - buttonPosition.x
        let deltaY = position.y - buttonPosition.y
        let angleInRadians = atan2(deltaY, deltaX)
        let angleInDegrees = (angleInRadians * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        
        withAnimation(.none) { // No animation for instant rotation
            planeAngle = angleInDegrees
        }
        
        // Move the target position as well
        targetPosition = randomPosition(in: gameAreaSize)
        
        
        let distanceToTarget = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        let duration = distanceToTarget / speed
        withAnimation(.linear(duration: duration)) { // Animate the button's movement
            buttonPosition = position
        }
    }
    
    func moveButton(to position: CGPoint, withSpeed speed: Double) {
        timer?.invalidate() // Stop the timer when pressed even if midaction
        self.speed = Double(Int.random(in: minSpeed...maxSpeed))
        
        let deltaX = position.x - buttonPosition.x
        let deltaY = position.y - buttonPosition.y
        let angleInRadians = atan2(deltaY, deltaX)
        let angleInDegrees = (angleInRadians * 180 / .pi + 360).truncatingRemainder(dividingBy: 360)
        
        withAnimation(.none) { // No animation for instant rotation
            planeAngle = angleInDegrees
        }
        
        // Move the target position as well
        targetPosition = randomPosition(in: gameAreaSize)
        
        //        let distanceToTarget = sqrt(deltaX * deltaX + deltaY * deltaY)
        
        
        // Use a Timer to move the button with a certain time interval
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            let step = CGFloat(speed) * 0.01
            let newX = buttonPosition.x + step * cos(angleInRadians)
            let newY = buttonPosition.y + step * sin(angleInRadians)
            buttonPosition = CGPoint(x: newX, y: newY)
            
            // Check if the button has reached the target position
            let distanceToTarget = sqrt((position.x - newX) * (position.x - newX) + (position.y - newY) * (position.y - newY))
            if distanceToTarget < step {
                timer?.invalidate() // Stop the timer when the button reaches the target
            }
        }
    }
    
}

struct AvionTap_Previews: PreviewProvider {
    static var previews: some View {
        AvionTap()
    }
}
