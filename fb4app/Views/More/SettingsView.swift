//
//  MoreView.swift
//  fb4app
//
//  Created by Maurice Hennig on 09.06.23.
//

import SwiftUI
import FirebaseMessaging
import CoreData

struct SettingsView: View {
    @EnvironmentObject private var appDelegate: AppDelegate
    @Environment(\.managedObjectContext) private var context
    
    @State var showCurrentWeekdayFirst = UserDefaultsHelper.shared.bool(key: SettingString.showCurrentWeekday)
    @State var increaseBrightnessInTicket = UserDefaultsHelper.shared.bool(key: .increaseBrightnessInTicket)
    @State var showNotificationOnNews = UserDefaultsHelper.shared.bool(key: .showNotificationOnNews)
    
    @State var isPresentingConfirmDeleteSchedule = false
    @State var isPresentingConfirmDeleteTicket = false
    
    var body: some View {
        NavigationStack {
            List {
                Section("Stundenplan") {                    
                    Toggle(isOn: $showCurrentWeekdayFirst) {
                        Text("Aktuellen Wochentag zuerst zeigen")
                    }
                    .onChange(of: showCurrentWeekdayFirst) { newValue in
                        UserDefaultsHelper.shared.set(newValue, key: .showCurrentWeekday)
                    }
                    
                    Button("Stundenplan löschen", role: .destructive) {
                        isPresentingConfirmDeleteSchedule.toggle()
                    }
                }
                
                Section("NRW-Ticket") {
                    Toggle(isOn: $increaseBrightnessInTicket) {
                        Text("Helligkeit automatisch erhöhren")
                    }
                    
                    Button("Ticket löschen", role: .destructive) {
                        isPresentingConfirmDeleteTicket.toggle()
                    }
                }
                
                Section("News") {
                    Toggle(isOn: $showNotificationOnNews) {
                        Text("Benachrichtigung bei News")
                    }
                    .onChange(of: showNotificationOnNews) { newValue in
                        if (newValue) {
                            appDelegate.registerForRemoteNotifications()
                        } else {
                            appDelegate.unregisterForRemoteNotifications()
                        }
                    }
                }
                
                Section("HISinOne") {
                    Button("Anmeldedaten löschen", role: .destructive) {
                        
                    }
                }
            }
            .navigationTitle(Text("Einstellungen"))
            .confirmationDialog("Soll der Stundenplan wirklich gelöscht werden?",
              isPresented: $isPresentingConfirmDeleteSchedule) {
              Button("Stundenplan löschen", role: .destructive) {
                  let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ScheduleItem")
                  let items = try! context.fetch(fetchRequest) as? [ScheduleItem] ?? []
                  
                  for item in items {
                      context.delete(item)
                  }
                  
                  try! context.save()
               }
             }
              .confirmationDialog("Soll das Semesterticket wirklich gelöscht werden?",
                isPresented: $isPresentingConfirmDeleteTicket) {
                Button("Ticket löschen", role: .destructive) {
                    do {
                        try FileManager.default.removeItem(at: TicketView.ticketUrl)
                    } catch {
                    }
                 }
               }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
