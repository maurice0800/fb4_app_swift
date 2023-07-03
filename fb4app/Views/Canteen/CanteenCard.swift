//
//  CanteenCard.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import SwiftUI

struct CanteenCard: View {
    @State var infoSheetVisible = false
    let meal: Meal
    var body: some View {
        VStack(alignment: .leading) {
                HStack {
                    Image(systemName: getIcon(meal: meal))
                        .padding(.leading, 18)
                        .padding(.trailing, 6)
                        .font(.system(size: 22))
                    Rectangle()
                        .fill(.orange)
                        .frame(width: 2)
                    Text(meal.title)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 5)
                        .font(.system(size: 16))
                    Spacer()
                }
                .background(Color(UIColor.tertiarySystemBackground))
                .cornerRadius(5)
                .padding(.bottom)
                .onTapGesture {
                    infoSheetVisible.toggle()
                }
                .sheet(isPresented: $infoSheetVisible) {
                    ScrollView {
                        VStack(alignment: .leading) {
                            HStack(alignment: .center) {
                                Image(systemName: getIcon(meal: meal))
                                    .font(.system(size: 24))
                                Text(meal.title)
                                    .font(.system(size: 20.0))
                                    .fontWeight(.bold)
                                    .padding(.bottom, 12)
                            }
                            Text("Preise")
                                .fontWeight(.bold)
                            Text(String(format: "Studierende: %.2f€", meal.priceStudent))
                            Text(String(format: "Mitarbeitende: %.2f€", meal.priceEmployee))
                            Text(String(format: "Gäste: %.2f€", meal.priceGuests))
                                .padding(.bottom, 12)
                            
                            Text("Typ")
                                .fontWeight(.bold)
                            Text(meal.type)
                                .padding(.bottom, 12)
                            
                            Text("Zusätzliches")
                                .fontWeight(.bold)
                            ForEach(meal.supplies, id: \.self) { supply in
                                Text(supply)
                            }
                        }
                        .padding()
                    }
                    .presentationDetents([.height(370.0)])
                }
        }
    }
}

func getIcon(meal: Meal) -> String {
    if (meal.type.contains("Vegetarisch")) {
        return "leaf"
    }
    
    if (meal.type.contains("1")) {
        return "1.circle"
    }
    
    if (meal.type.contains("2")) {
        return "2.circle"
    }
    
    if (meal.type.contains("Tag")) {
        return "calendar"
    }
    
    if (meal.type.contains("Beilage")) {
        return "plus";
    }
    
    return "fork.knife.circle"
}

//struct CanteenCard_Previews: PreviewProvider {
//    static var previews: some View {
//        // CanteenCard(meal: nil)
//    }
//}
