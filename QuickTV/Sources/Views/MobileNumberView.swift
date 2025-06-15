//
//  MobileNumberView.swift
//  QuickTV
//
//  Created by Pradeep KN on 16/06/25.
//

import SwiftUI

struct MobileNumberView: View {
    @State private var phoneNumber: String = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 40) {
                Text("Mobile number")
                    .font(.title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                HStack {
                    Text("+91")
                        .foregroundColor(.white)
                        .font(.title3)
                        .padding(.leading, 8)
                    
                    TextField("Enter number", text: $phoneNumber)
                        .keyboardType(.numberPad)
                        .foregroundColor(.white)
                        .padding(12)
                        .accentColor(.white)
                }
                .overlay(
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.white),
                    alignment: .bottom
                )
                
                Spacer()
                
                Button(action: {
                    // Handle OTP generation
                }) {
                    Text("Get OTP")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(white: 0.2))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 100)
        }
    }
}

struct MobileNumberView_Previews: PreviewProvider {
    static var previews: some View {
        MobileNumberView()
            .preferredColorScheme(.dark) // Preview in dark mode
    }
}
