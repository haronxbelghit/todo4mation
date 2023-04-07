//
//  NewTaskView.swift
//  todo4mation
//
//  Created by Belghit Haron on 6/4/2023.
//

import SwiftUI

struct NewTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) private var viewContext

    @State private var title = ""

    let topic: String
    
    var body: some View {
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("Details")) {
                            TextField("Title", text: $title)
                            DatePicker("Deadline", selection: .constant(Date()), displayedComponents: [.date])
                        }
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: addNewTask) {
                                Text("Save")
                            }
                            .frame(width: 150, height: 50)
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .cornerRadius(8)
                            .disabled(title.isEmpty)
                            .padding()
                        }
                    }
                }
                .navigationTitle("Add Task")
                .navigationBarItems(trailing: Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                })
            }
        }

    private func addNewTask() {
        if !title.isEmpty {
            let newTask = Task(context: viewContext)
            newTask.id = UUID()
            newTask.title = title
            newTask.date = Date()
            newTask.topic = topic

            do {
                try viewContext.save()
                presentationMode.wrappedValue.dismiss()
            } catch {
                print("Error saving task: \(error)")
            }
        }
    }
}
struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(topic: "Home")
    }
}
