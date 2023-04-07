//
//  TaskRowView.swift
//  todo4mation
//
//  Created by Belghit Haron on 6/4/2023.
//

import SwiftUI

struct TaskRowView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)])
    private var tasks: FetchedResults<Task>
    
    private func updateTask(_ task: Task) {
        task.done = !task.done
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    let task: Task
    
    var body: some View {
        HStack {
            Text(task.title ?? "Untitled")
            Spacer()
            Button(action: { updateTask(task) }) {
                Image(systemName: task.done ? "checkmark.square.fill" : "square")
                    .resizable()
                    .frame(width: 22, height: 22)
                    .foregroundColor(task.done ? .blue : .gray)
            }
        }
    }
}



struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task())
    }
}

