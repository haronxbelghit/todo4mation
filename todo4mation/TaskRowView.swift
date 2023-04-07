//
//  TaskRowView.swift
//  todo4mation
//
//  Created by Belghit Haron on 6/4/2023.
//

import SwiftUI

struct TaskRowView: View {
    let task: Task
    
    var body: some View {
        HStack {
            Text(task.title ?? "Untitled")
            Spacer()
        }
    }
}
struct TaskRowView_Previews: PreviewProvider {
    static var previews: some View {
        TaskRowView(task: Task())
    }
}
