//
//  AddOfficialSchedulePage.swift
//  fb4app
//
//  Created by Maurice Hennig on 22.03.23.
//

import SwiftUI

enum EntryType : Int, CaseIterable {
    case official = 0
    case custom = 1
    
    func getLabel() -> String {
        switch(self) {
        case .official:
            return "Offiziell"
        case .custom:
            return "Benutzerdefiniert"
        }
    }
}

struct AddOfficialSchedulePage: View {
    @Environment(\.dismiss) var dismiss
    @State var selectedType: EntryType = .official
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Section("Eintragstyp") {
                        Picker("Typ", selection: $selectedType) {
                            ForEach(EntryType.allCases, id: \.self) { type in
                                Text(type.getLabel()).tag(type)
                            }
                        }
                    }
                    if (selectedType == .official) {
                        AddOfficialScheduleForm()
                    } else {
                        AddCustomScheduleForm()
                    }
                }
            }
            .navigationBarTitle("Neuer offizieller Stundenplan")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddOfficialSchedulePage_Previews: PreviewProvider {
    static var previews: some View {
        AddOfficialSchedulePage()
    }
}
