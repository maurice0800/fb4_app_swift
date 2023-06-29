//
//  ScheduleCard.swift
//  fb4app
//
//  Created by Maurice Hennig on 04.04.23.
//

import SwiftUI

struct ScheduleCard: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var item: ScheduleItem
    
    @State var presentSheet = false
    @State var selectedColor = Color.orange
    
    @State var isSelected = false
    let editable: Bool
    
    init(item: ScheduleItem, editable: Bool = false) {
        self.item = item
        self.editable = editable
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color(hex: item.color ?? "#ffa500"))
            
            HStack {
                if (editable) {
                    ZStack {
                        Circle()
                            .frame(width: 20)
                            .foregroundColor(.white)
                        if (isSelected) {
                            Circle()
                                .frame(width: 12)
                                .foregroundColor(.orange)
                        }
                    }
                }
                VStack(alignment: .leading) {
                    Text(item.timeBegin ?? "")
                        .font(.system(size: 24.0))
                        .fontWeight(.semibold)
                    Text(item.timeEnd ?? "")
                        .font(.system(size: 24.0))
                        .fontWeight(.semibold)
                }
                .padding(.trailing, 7.5)
                VStack(alignment: .leading) {
                    Text("[\(item.courseType ?? "")] \(item.courseTitle ?? "")")
                        .lineLimit(1)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    HStack {
                        Text(item.group ?? "")
                        Text("|")
                        Text(item.teacher ?? "")
                    }
                    Text(item.room ?? "")
                }
                .frame(maxWidth: .infinity)
            }
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 10)
            .foregroundColor(.white)
        }
        .cornerRadius(8)
        .shadow(
            color: Color.gray.opacity(0.7),
            radius: 4,
            x: 0,
            y: 0
        )
        .frame(height: 100)
        .contextMenu {
            Button {
                presentSheet.toggle()
            } label: {
                Label("Farbe ändern", systemImage: "eyedropper")
            }
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    viewContext.delete(item)
                }
            } label: {
                Label("Eintrag Löschen", systemImage: "trash")
            }
        }
        .onTapGesture {
            isSelected.toggle()
        }
        .colorPickerSheet(isPresented: $presentSheet, selection: $selectedColor, supportsAlpha: false, title: "Hintergrundfarbe wählen")
        .onChange(of: selectedColor) { newValue in
            item.color = newValue.getHexString()
            try! viewContext.save()
            presentSheet = false
        }
    }
}

//struct ScheduleCard_Previews: PreviewProvider {
//    static var previews: some View {
//        ScheduleCard()
//    }
//}
