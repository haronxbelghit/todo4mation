//
//  TasksView.swift
//  todo4mation
//
//  Created by Belghit Haron on 6/4/2023.
//

import SwiftUI
import CoreData

struct TasksView: View {
    let topic: String
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)], animation: .default)
    private var fetchedTasks: FetchedResults<Task>

    @State private var showingNewTaskView = false

    init(topic: String) {
        self.topic = topic
        let fetchRequest: NSFetchRequest<Task> = Task.fetchRequest()
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Task.date, ascending: true)]
        fetchRequest.predicate = NSPredicate(format: "topic == %@", topic)
        _fetchedTasks = FetchRequest(fetchRequest: fetchRequest, animation: .default)
    }
    
    var body: some View {
        List {
            ForEach(fetchedTasks) { task in
                TaskRowView(task: task)
            }
            .onDelete(perform: deleteTasks)
        }
        .navigationTitle(topic)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing: Button(action: {
                showingNewTaskView = true
            }) {
                Image(systemName: "plus")
                    .foregroundColor(.blue)
                    .imageScale(.large)
            }
        )
        .sheet(isPresented: $showingNewTaskView) {
            NewTaskView(topic: topic)
                .environment(\.managedObjectContext, viewContext)
        }
    }
    
    private func deleteTasks(at offsets: IndexSet) {
        offsets.forEach { index in
            let task = fetchedTasks[index]
            viewContext.delete(task)
        }
        do {
            try viewContext.save()
        } catch {
            print("Error deleting tasks: \(error.localizedDescription)")
        }
    }
}


struct TasksView_Previews: PreviewProvider {
    static var previews: some View {
        TasksView(topic: "Home")
    }
}
