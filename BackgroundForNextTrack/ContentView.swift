//
//  ContentView.swift
//  BackgroundForNextTrack
//
//  Created by Димон on 9.10.23.
//

import SwiftUI

struct ContentView: View {
    @State private var isAnimate: Bool = false
    @State private var isBackgroundAnimate = false
    
    private let playImageName = "play.fill"
    
    var body: some View {
        Button {
            if !isAnimate && !isBackgroundAnimate {
                isBackgroundAnimate.toggle()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
                    isBackgroundAnimate.toggle()
                }
                
                withAnimation(.interpolatingSpring(stiffness: 180, damping: 15)) {
                    isAnimate.toggle()
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    isAnimate.toggle()
                }
            }
        } label: {
            GeometryReader { proxy in
                let width = proxy.size.width / 2
                
                HStack(alignment: .center, spacing: 0) {
                    Image(systemName: playImageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isAnimate ? width : .zero)
                        .opacity(isAnimate ? 1 : .zero)
                    Image(systemName: playImageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: width)
                    Image(systemName: playImageName)
                        .renderingMode(.template)
                        .resizable()
                        .scaledToFit()
                        .frame(width: isAnimate ? 0.5 : width)
                        .opacity(isAnimate ? .zero : 1)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .buttonStyle(NextTrackButtonStyle(isBackgroundAnimate: $isBackgroundAnimate))
    }
}

struct NextTrackButtonStyle: ButtonStyle {
    @Binding var isBackgroundAnimate: Bool
    
    private let initialScaleEffect: CGFloat = 1
    private let scaleEffect: CGFloat = 0.86
    private let initialOpacity: CGFloat = 0
    private let opacity: CGFloat = 0.2
    private let animationDuration: CGFloat = 0.22
    private let buttonSize: CGFloat = 60
    private let buttonPadding: CGFloat = 15
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(maxWidth: buttonSize,
                   maxHeight: buttonSize)
            .padding(.all, buttonPadding)
            .foregroundStyle(.blue)
            .scaleEffect(isBackgroundAnimate || configuration.isPressed
                         ? scaleEffect
                         : initialScaleEffect)
            .background(.gray.opacity(isBackgroundAnimate || configuration.isPressed
                                      ? opacity
                                      : initialOpacity))
            .clipShape(.circle)
            .animation(.linear(duration: animationDuration),
                       value: isBackgroundAnimate || configuration.isPressed)
    }
}

#Preview {
    ContentView()
}
