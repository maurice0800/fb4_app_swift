//
//  MainView.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import SwiftUI

struct MainView: View {
    enum TabItem: Int {
        case schedule = 0
        case news
        case canteen
        case ticket
        case more
        
        var icon: String {
            switch self {
                case .schedule:  return "list.bullet.rectangle.portrait"
                case .news: return "newspaper"
                case .canteen:  return "fork.knife"
                case .ticket:  return "ticket"
                case .more:  return "ellipsis"
            }
        }
        
        var title: String {
            switch self {
            case .schedule: return "Kurse"
            case .news: return "News"
            case .canteen: return "Mensa"
            case .ticket: return "Ticket"
            case .more: return "Mehr"
            }
        }
    }
    
    // @State private var selection: TabItem = .schedule
    @State private var selection: String = "Schedule"
    @State private var hasAcceptedPrivacy = UserDefaults.standard.bool(forKey: "acceptedPrivacyPolicy")
    
    var body: some View {
            TabView(selection: $selection) {
                ScheduleOverview()
                    .tabItem {
                        Label("Stundenplan", systemImage: "list.bullet.rectangle.portrait")
                            .foregroundColor(.orange)
                    }
                    .tag("Schedule")
                NewsOverview()
                    .tabItem {
                        Label("News", systemImage: "newspaper")
                    }
                    .tag("News")
                CanteenOverview()
                    .tabItem {
                        Label("Mensa", systemImage: "fork.knife")
                    }
                    .tag("Canteen")
                TicketView()
                    .tabItem {
                        Label("Ticket", systemImage: "ticket")
                    }
                    .tag("Ticket")
                MoreView()
                    .tabItem {
                        Label("Mehr", systemImage: "ellipsis")
                    }
                    .tag("More")
            }
            .sheet(isPresented: $hasAcceptedPrivacy) {
                PrivacyPolicyView()
                    .interactiveDismissDisabled()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
