//
//  CanteenOverview.swift
//  fb4app
//
//  Created by Maurice Hennig on 21.03.23.
//

import SwiftUI
import ShuffleIt
import Combine

struct CanteenInfosForDate : Hashable {
    let date: Date
    var infos: [Canteen: [Meal]]
    
    init(date: Date) {
        self.date = date
        infos = [:]
    }
}

struct CanteenOverview: View {
    let store = CanteenStore()
    let dateFormatter = DateFormatter()
    var weekDays = [Date]()
    @State var infoForDate: [CanteenInfosForDate]
    @State var selectedPage = 0
    @State var selectedCanteen: Canteen = .hauptmensa
    
    init() {
        dateFormatter.dateFormat = "EEEE (dd.MM.yyyy)"
        var weedayList = [CanteenInfosForDate]()
        for index in 0...13 {
            let day = Calendar.current.date(byAdding: .day, value: index, to: Date.today().get(.previous, .monday))!
            
            weekDays.append(day)
            weedayList.append(CanteenInfosForDate(date: day))
        }
        
        _infoForDate = State(initialValue: weedayList)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach (weekDays, id: \.self) { day in
                            if Calendar.current.component(.weekday, from: day) == 1 || Calendar.current.component(.weekday, from: day) == 7 {
                                Spacer()
                            } else {
                                ZStack {
                                    Rectangle()
                                        .fill(weekDays[selectedPage] == day ? .orange : Color(UIColor.secondarySystemBackground))
                                        .cornerRadius(5.0)
                                        .foregroundColor(.white)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 5.0)
                                                .stroke(weekDays[selectedPage] == day ? .orange : Color(UIColor.secondaryLabel), lineWidth: 1.0)
                                        )
                                    VStack {
                                        Text(DateFormatter().shortWeekdaySymbols[Calendar.current.component(.weekday, from: day) - 1])
                                            .fontWeight(.semibold)
                                            .padding(.bottom, 2)
                                        Text(String("\(Calendar.current.component(.day, from: day))."))
                                            .fontWeight(.bold)
                                    }
                                    .foregroundColor(weekDays[selectedPage] == day ? .white : .gray)
                                    .padding(5.0)
                                }
                                .frame(width: 40, height: 50)
                                .onTapGesture {
                                    withAnimation {
                                        selectedPage = weekDays.lastIndex(of: day) ?? 0
                                    }
                                    
                                    if (infoForDate[selectedPage].infos[selectedCanteen] == nil) {
                                        getMealsForDate(date: day)
                                    }
                                }
                                .padding(.trailing, 10.0)
                            }
                        }
                    }
                    .padding(.vertical, 12.0)
                    .padding(.horizontal)
                }
                
                VStack(alignment: .leading) {
                    Menu {
                        ForEach(Canteen.allCases, id: \.self) { canteen in
                                Button(canteen.getFriendlyName()) {
                                    selectedCanteen = canteen
                                }
                            }
                        } label: {
                            HStack {
                                Text(selectedCanteen.getFriendlyName())
                                    .font(.system(size: 26))
                                    .fontWeight(.bold)
                                    .foregroundColor(.orange)
                                HStack {
                                    Image(systemName: "chevron.down")
                                        .foregroundColor(.orange)
                                }
                            }
                        }
                        .onChange(of: selectedCanteen, perform: { newValue in
                            if (infoForDate[selectedPage].infos[selectedCanteen] == nil) {
                                getMealsForDate(date: weekDays[selectedPage])
                            }
                        })
                        .padding(.horizontal)
                        SnapCarousel(index: $selectedPage, items: infoForDate) { value in
                            if (value.infos[selectedCanteen] == nil) {
                                ProgressView()
                                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
                            } else {
                                if (value.infos[selectedCanteen]!.count == 0) {
                                    Text("Keine Informationen für diesen Tag verfügbar")
                                } else {
                                    ScrollView {
                                        VStack(alignment: .leading) {
                                            Text("Hauptspeisen")
                                                .font(.system(size: 20))
                                                .fontWeight(.bold)
                                                .foregroundColor(.orange)
                                            ForEach(value.infos[selectedCanteen]!.filter({ meals in return meals.type != "Beilagen"})) { meal in
                                                CanteenCard(meal: meal)
                                                    .shadow(
                                                        color: Color.gray.opacity(0.7),
                                                        radius: 4,
                                                        x: 0,
                                                        y: 0
                                                    )
                                            }

                                            if (value.infos[selectedCanteen]!.contains(where: { meal in
                                                meal.type == "Beilagen"
                                            })) {
                                                Rectangle()
                                                    .fill(Color.orange)
                                                    .frame(height: 1)
                                                Text("Beilagen  ")
                                                    .font(.system(size: 20))
                                                    .fontWeight(.bold)
                                                    .foregroundColor(.orange)
                                                ForEach(value.infos[selectedCanteen]!.filter({ meals in return meals.type == "Beilagen"})) { meal in
                                                    CanteenCard(meal: meal)
                                                        .shadow(
                                                            color: Color.gray.opacity(0.7),
                                                            radius: 4,
                                                            x: 0,
                                                            y: 0
                                                        )
                                                }
                                            }
                                        }
                                        .padding([.leading, .trailing])
                                    }
                                    .refreshable {
                                        getMealsForDate(date: weekDays[selectedPage])
                                    }
                                }
                            }
                        }
                        .onPageChanged {
                            if (infoForDate[selectedPage].infos[selectedCanteen] == nil) {
                                getMealsForDate(date: weekDays[selectedPage])
                            }
                        }
                    }
            }
            .navigationBarTitle("Mensa")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(UIColor.systemBackground))
            .onAppear {
                if (infoForDate[selectedPage].infos[selectedCanteen] == nil) {
                    getMealsForDate(date: weekDays[selectedPage])
                }
            }
        }
    }
    
    func getMealsForDate(date: Date) {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        store.getMealsForDay(dayString: dateFormatter.string(from: date), canteen: selectedCanteen) { meals in
            let targetItem = infoForDate.firstIndex { info in
                info.date == date
            }!
            
            infoForDate[targetItem].infos[selectedCanteen] = meals.meals
        }
    }
}

struct CanteenOverview_Previews: PreviewProvider {
    static var previews: some View {
        CanteenOverview()
    }
}
