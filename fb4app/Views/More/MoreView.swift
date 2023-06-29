//
//  MoreView.swift
//  fb4app
//
//  Created by Maurice Hennig on 10.06.23.
//

import SwiftUI
import MessageUI

struct MoreView: View {
    @State var isShowingAbout: Bool = false
    
    var body: some View {
        NavigationStack {
            ScrollView
            {
                VStack(alignment: .leading) {
                    Group {
                        MoreListItemNoLink(icon: "graduationcap", title: "Notenübersicht")
                        Divider()
                        MoreListItemNoLink(icon: "globe", title: "Links / Downloads")
                        Divider()
                        MoreListItemNoLink(icon: "envelope", title: "Feddback geben")
                            .onTapGesture {
                                if let url = URL(string: "mailto:abc@abc.abc") {
                                     UIApplication.shared.open(url, options: [:], completionHandler: nil)
                                }
                            }
                        Divider()
                    }
                    Group {
                        MoreListItem(icon: "gear", title: "Einstellungen") {
                            SettingsView()
                        }
                        Divider()
                        MoreListItemNoLink(icon: "info.circle", title: "Über")
                            .onTapGesture {
                                isShowingAbout.toggle()
                            }
                        Divider()
                        MoreListItem(icon: "lock", title: "Datenschutz") {
                            PrivacyPolicyView()
                        }
                        Divider()
                    }
                }
                .sheet(isPresented: $isShowingAbout) {
                    VStack(alignment: .leading) {
                        Text("FH Dortmund FB4 App")
                            .font(.system(size: 24.0))
                            .fontWeight(.bold)
                        Text("Version: \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String)")
                            .padding(.vertical, 8.0)
                            .font(.system(size: 16.0))
                        Text("Diese App ist eine studentische Eigenentwicklung und steht in keinem Zusammenhang mit der Fachhochschule Dortmund")
                    }
                    .padding()
                    .presentationDetents([.height(200.0)])
                }
            }
            .frame(maxHeight: .infinity)
            .fixedSize(horizontal: false, vertical: false)
            .navigationTitle("Mehr")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
