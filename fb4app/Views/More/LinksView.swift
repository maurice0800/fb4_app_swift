//
//  LinksView.swift
//  fb4app
//
//  Created by Maurice Hennig on 08.07.23.
//

import SwiftUI

struct LinksView: View {
    @Environment(\.openURL) var openURL
    var body: some View {
        NavigationStack {
            ScrollView {
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Studierbar")
                    .onTapGesture {
                        openURL(URL(string: "https://www.studierbar.de")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Ilias")
                    .onTapGesture {
                        openURL(URL(string: "https://www.ilias.fh-dortmund.de")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Portal")
                    .onTapGesture {
                        openURL(URL(string: "https://portal.fh-dortmund.de")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "SmartAssign")
                    .onTapGesture {
                        openURL(URL(string: "https://smartassign.inf.fh-dortmund.de")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Intranet")
                    .onTapGesture {
                        openURL(URL(string: "intranet.fh-dortmund.de")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Fachschaftsrat Informatik")
                    .onTapGesture {
                        openURL(URL(string: "https://www.fsrfb4.de")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Prüfungsplan")
                    .onTapGesture {
                        openURL(URL(string: "https://www.fh-dortmund.de/de/fb/4/lehre/pplan.php")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Lageplan")
                    .onTapGesture {
                        openURL(URL(string: "https://www.fh-dortmund.de/de/_diverses/anschr/medien/Lageplan_EFS.pdf")!)
                    }
                MoreListItemNoLink(icon: "globe.badge.chevron.backward", title: "Zeitplan")
                    .onTapGesture {
                        openURL(URL(string: "https://www.fh-dortmund.de/zeitplan")!)
                    }
            }
            .navigationTitle("Links")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct LinksView_Previews: PreviewProvider {
    static var previews: some View {
        LinksView()
    }
}
