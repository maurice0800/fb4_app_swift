//
//  ColorPickerSheet.swift
//  fb4app
//
//  Created by Maurice Hennig on 04.04.23.
//

import Foundation
import SwiftUI

extension View {
    @available(iOS 14.0, *)
    public func colorPickerSheet(isPresented: Binding<Bool>, selection: Binding<Color>, supportsAlpha: Bool = true, title: String? = nil) -> some View {
        self.background(ColorPickerSheet(isPresented: isPresented, selection: selection, supportsAlpha: supportsAlpha, title: title))
    }
}

@available(iOS 14.0, *)
private struct ColorPickerSheet: UIViewRepresentable {
    @Binding var isPresented: Bool
    @Binding var selection: Color
    var supportsAlpha: Bool
    var title: String?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(selection: $selection, isPresented: $isPresented)
    }
    
    class Coordinator: NSObject, UIColorPickerViewControllerDelegate, UIAdaptivePresentationControllerDelegate {
        @Binding var selection: Color
        @Binding var isPresented: Bool
        var didPresent = false
        
        init(selection: Binding<Color>, isPresented: Binding<Bool>) {
            self._selection = selection
            self._isPresented = isPresented
        }
        
        func colorPickerViewControllerDidSelectColor(_ viewController: UIColorPickerViewController) {
            selection = Color(viewController.selectedColor)
        }
        func colorPickerViewControllerDidFinish(_ viewController: UIColorPickerViewController) {
            isPresented = false
            didPresent = false
        }
        func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
            isPresented = false
            didPresent = false
        }
    }

    func getTopViewController(from view: UIView) -> UIViewController? {
        guard var top = view.window?.rootViewController else {
            return nil
        }
        while let next = top.presentedViewController {
            top = next
        }
        return top
    }
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        view.isHidden = true
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        if isPresented && !context.coordinator.didPresent {
            let modal = UIColorPickerViewController()
            modal.selectedColor = UIColor(selection)
            modal.supportsAlpha = supportsAlpha
            modal.title = title
            modal.delegate = context.coordinator
            modal.presentationController?.delegate = context.coordinator
            let top = getTopViewController(from: uiView)
            top?.present(modal, animated: true)
            context.coordinator.didPresent = true
        }
    }
}
