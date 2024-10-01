//
//  SettingsView.swift
//  ADMIRAL Defense
//
//  Created by Роман on 26.09.2024.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    
    @Binding var isPresentSettings: Bool
    @State private var isPresentShare = false
    @State private var isPresentPolicy = false
    @State var urlShare = "https://www.apple.com/app-store/"
    @State var urlPolicy = URL(string: "https://google.com")

    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea()
                .opacity(0.5)
                
            ZStack {
                
                Image(.settingsBackGround)
                    .resizable()
                VStack{
                    Text("SETTINGS")
                        .foregroundStyle(.settings)
                        .font(.system(size: scaleScreen_x(32), weight: .heavy, design: .monospaced))
                    //MARK: - Policy button
                    Button {
                        isPresentPolicy.toggle()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        SettingsButtonView(text: "POLICY")
                    }
 
                    //MARK: - Share button
                    Button {
                        isPresentShare.toggle()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        SettingsButtonView(text: "SHARE")
                    }
                    
                    //MARK: - Rate us button
                    Button {
                        SKStoreReviewController.requestReview()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        SettingsButtonView(text: "RATE US")
                    }
                    
                    //MARK: - Back button
                    Button {
                        isPresentSettings.toggle()
                        SoundManager.instance.playSound(sound: .buttonClick)
                    } label: {
                        Text("BACK")
                            .foregroundStyle(.settings)
                            .font(.system(size: scaleScreen_x(35), weight: .heavy, design: .monospaced))
                    }
                    
                    
                }
            }
            .frame(width: scaleScreen_x(332), height: scaleScreen_x(491))
        }
        .sheet(isPresented: $isPresentShare, content: {
            ShareSheet(items: urlShare )
        })
        .sheet(isPresented: $isPresentPolicy, content: {
            WebViewPage(urlString: urlPolicy!)
        })
    }
}

#Preview {
    SettingsView(isPresentSettings: .constant(false))
}

struct ShareSheet: UIViewControllerRepresentable{
    var items: String
    func makeUIViewController(context: Context) -> UIActivityViewController {
        let av = UIActivityViewController(activityItems: [items], applicationActivities: nil)
        return av
    }
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
}
