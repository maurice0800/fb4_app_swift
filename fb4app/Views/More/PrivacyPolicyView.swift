//
//  PrivacyPolicyView.swift
//  fb4app
//
//  Created by Maurice Hennig on 17.06.23.
//

import SwiftUI

struct PrivacyPolicyView: View {
    @Environment(\.dismiss) var dismiss
    @State var textContent: String?
    var showAcceptButton = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if (textContent == nil) {
                    ProgressView()
                } else {
                    Text(.init(textContent!))
                        .padding()
                    Button {
                        UserDefaults.standard.set(true, forKey: "acceptedPrivacyPolicy")
                        dismiss()
                    } label: {
                        Text("Akzeptieren")
                            .foregroundColor(.white)
                            .padding(.horizontal, 16.0)
                            .padding(.vertical, 8.0)
                    }
                    .buttonStyle(.borderedProminent)
                }
                
            }
            .navigationTitle("Datenschutzerklärung")
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            if let path = Bundle.main.path(forResource: "PrivacyPolicy", ofType: "txt") {
                let fm = FileManager()
                let exists = fm.fileExists(atPath: path)
                if (exists) {
                    let content = fm.contents(atPath: path)
                    textContent = String(data: content!, encoding: String.Encoding.utf8)!
                }
            }
        }
    }
}

struct PrivacyPolicyView_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPolicyView()
    }
}
