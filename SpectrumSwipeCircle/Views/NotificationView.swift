//
//  NotificationView.swift
//  SpectrumSwipeCircle
//
//  Created by 123 on 19.04.24.
//

import SwiftUI

struct NotificationView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Image("MenuBG")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .offset(x:-40)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Logo")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 400, height: 400)
                    .padding(.top, 70)
                
                Text("ALLOW NOTIFICATIONS ABOUT BONUSES AND PROMOS")
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 400)
                    .padding(.bottom, 8)
                
                
                
                Text("Stay tuned with best offers from our casino")
                    .font(.title3)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 350)

                
                VStack {
                    Button(action: {
                        print("Yes, I Want Bonuses! button tapped")
                        isPresented = false
                    }) {
                        Text("Yes, I Want Bonuses!")
                            .foregroundColor(.black)
                            .padding()
                            .frame(minWidth: 330)
                            .background(Color.yellow)
                            .cornerRadius(10)
                    }
                    
                    Button(action: {
                        print("Skip button tapped")
                        isPresented = false
                    }) {
                        Text("Skip")
                            .foregroundColor(.gray)
                            .padding()
                            .cornerRadius(10)
                    }
                }
            }
            .padding()
            .cornerRadius(20)
            .background(
                Image("MenuBlackout")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .offset(y:360)
                    .opacity(0.75)
            )
            .edgesIgnoringSafeArea(.all)
            
        }
    }
}

//#Preview {
//    NotificationView()
//}
