//
//  ContentView.swift
//  ScreenshotHide
//
//  Created by Arun Rathore on 22/03/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                NavigationLink {
                    ScreenShotPreventView() {
                        GeometryReader {
                            let size = $0.size
                            Image(.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: size.width, height: size.height)
                                .clipShape(.rect(topLeadingRadius: 35, bottomTrailingRadius: 35))

                        }

                    }
                } label: {
                    Text("Show Image")
                }

                NavigationLink {

                } label: {
                    Text("Show Security Key")
                }

            }
        }.navigationTitle("My List")
    }
}

#Preview {
    ContentView()
}
