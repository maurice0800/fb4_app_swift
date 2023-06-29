//
//  AddOfficialScheduleForm.swift
//  fb4app
//
//  Created by Maurice Hennig on 16.04.23.
//

import SwiftUI

struct AddOfficialScheduleForm: View {
    let store = CourseOfStudyStore()
    @State var courses: [CourseOfStudy] = []
    
    @State var selectedCourse: CourseOfStudy?
    @State var selectedGrade: Grade?
    
    var body: some View {
        if (courses.isEmpty) {
                ProgressView()
                    .onAppear {
                        store.getAvailableCourses { courses in
                            self.courses = courses.sorted(by: { e1, e2 in
                                e1.name < e2.name
                            })
                            self.selectedCourse = self.courses[0]
                            self.selectedGrade = self.selectedCourse!.grades[0]
                        }
                    }
        } else {
                Section("Stundenplaninformationen") {
                    Picker("Kurs", selection: $selectedCourse) {
                        ForEach (courses) { course in
                            Text(course.name).tag(course as CourseOfStudy?)
                        }
                    }
                    Picker("Semester", selection: $selectedGrade) {
                        ForEach (selectedCourse?.grades ?? []) { grade in
                            Text(grade.grade).tag(grade as Grade?)
                        }
                    }
                }
                
                NavigationLink(destination: NavigationLazyView(SelectScheduleItems(sname: selectedCourse!.sname, grade: selectedGrade!.grade))) {
                    Text("Stundenplan abrufen")
                        .foregroundColor(.blue)
                }
        }
    }
}

struct AddOfficialScheduleForm_Previews: PreviewProvider {
    static var previews: some View {
        AddOfficialScheduleForm()
    }
}
