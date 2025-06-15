//
//  LoginScreenView.swift
//  QuickTV
//
//  Created by Pradeep KN on 16/06/25.
//

import SwiftUI

struct LoginScreenView: View {
    let primaryPink = Color(hex: "#AD195D")
    let secondaryPink = Color(hex: "#EA1163")
    @State private var navigate = false
    @State private var isPlaying = true
    @State private var isMuted = false

    var body: some View {
        NavigationView {
            ZStack {
                // Background Image
                VideoLoopView(videoName: "intro_video", isPlaying: $isPlaying, isMute: $isMuted)
                    .scaledToFill()
                    .ignoresSafeArea()
                
                // Dark overlay
                ForEach(0..<3) { index in
                    GeometryReader { geo in
                        LinearGradient(
                            gradient: Gradient(colors: [Color.clear, Color.black]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .frame(height: geo.size.height / 2)
                        .position(x: geo.size.width / 2, y: geo.size.height * 0.75) // start at mid, end at bottom
                    }
                    .ignoresSafeArea()
                }
                
                
                VStack(spacing: 16) {
                    Spacer()
                    // App Icon
                    Image("logo_with_text") // Replace with actual icon asset
                    // Tagline
                    Text("High speed drama, on the go!")
                        .font(.subheadline)
                        .foregroundColor(Color.pink).padding(.bottom, 20)
                    
                    Button(action: {
                        isPlaying = false // 👈 Pause before navigating
                        navigate = true
                    }) {
                        Text("Login")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width - 40, height: 32) // Keep this
                            .padding()
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [primaryPink, secondaryPink]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .cornerRadius(12)
                    }
                    // Terms & Policy Text
                    Text("By tapping you agree to our ")
                        .foregroundColor(.white.opacity(0.6))
                        .font(.footnote)
                    +
                    Text("Terms of use")
                        .foregroundColor(.pink)
                        .underline()
                        .font(.footnote)
                    +
                    Text(" and ")
                        .foregroundColor(.white.opacity(0.6))
                        .font(.footnote)
                    +
                    Text("Privacy policy.")
                        .foregroundColor(.pink)
                        .underline()
                        .font(.footnote)
                    
                    Spacer().frame(height: 30)
                }.padding(.horizontal, 20)
                
                NavigationLink(destination: MobileNumberView(), isActive: $navigate) {
                    EmptyView()
                }
            }.onAppear {
                // Resume playing when view appears again (after pop)
                isPlaying = true
            }
            .contentShape(Rectangle()) // Make the entire screen tappable
            .onTapGesture {
                isMuted = !isMuted
            }
            .navigationBarHidden(true)
        }
    }
}

// Preview
struct LoginScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenView()
            .previewDevice("iPhone 14 Pro")
            .preferredColorScheme(.dark)
    }
}
