//
//  ScreenShotPreventView.swift
//  ScreenshotHide
//
//  Created by Arun Rathore on 22/03/24.
//

import SwiftUI

struct ScreenShotPreventView<Content: View>: View {
    var content: Content
    init(@ViewBuilder content: @escaping() -> Content) {
        self.content = content()
    }

    @State private var hostingController: UIHostingController<Content>?
    var body: some View {
        _ScreenShotPreventHelper(hostingController: $hostingController)
            .overlay {
                GeometryReader {
                    let size = $0.size
                    Color.clear
                        .preference(key: SizeKey.self, value: size)
                        .onPreferenceChange(SizeKey.self, perform: { value in
                            if value != .zero {
                                if hostingController == nil {
                                    hostingController = UIHostingController(rootView: content)
                                    hostingController?.view.backgroundColor = .clear
                                    hostingController?.view.tag = 1009
                                    hostingController?.view.frame = .init(origin: .zero, size: value)
                                } else {
                                    hostingController?.view.frame = .init(origin: .zero, size: value)
                                }

                            }
                        })
                }
            }
    }
}

fileprivate struct SizeKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

private struct _ScreenShotPreventHelper<Content: View>: UIViewRepresentable {
    @Binding var hostingController: UIHostingController<Content>?

    func makeUIView(context: Context) -> UIView {
        let secureField = UITextField()
        secureField.isSecureTextEntry = true

        if let textLayoutView = secureField.subviews.first {
            return textLayoutView
        }
        return UIView()
    }

    func updateUIView(_ uiView: UIView, context: Context) {
        if let hostingController, !uiView.subviews.contains(where: {$0.tag == 1009}) {
            uiView.addSubview(hostingController.view)
        }

    }

}

#Preview {
    ContentView()
}
