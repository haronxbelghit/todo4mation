//
//  ContentView.swift
//  todo4mation
//
//  Created by Belghit Haron on 6/4/2023.
//

import SwiftUI

import SwiftUI

struct TopicsView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Task.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Task.date, ascending: true)], animation: .default)
    private var tasks: FetchedResults<Task>

    @State private var topics: [String] = []

    @State private var showingAddTopicView = false
    @State private var newTopic = ""
    
    var body: some View {

        NavigationView {
            List {
                ForEach(topics, id: \.self) { topic in
                    NavigationLink(destination: TasksView(topic: topic)) {
                        HStack {
                            Text(topic)
                                .font(.headline)
                        }
                    }
                }
                Button(action: {
                    showingAddTopicView = true
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                            .font(.title2)
                        Text("Add Topic")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
                }
            }
            .id(UUID())
            .onAppear {
                topics = Array(Set(tasks.map { $0.topic ?? "" })).sorted()
            }
            .navigationTitle("Topics")
            .sheet(isPresented: $showingAddTopicView) {
                NavigationView {
                    ZStack {
                        Form {
                            Section(header: Text("Details")) {
                                TextField("New Topic", text: $newTopic)
                            }
                        }
                        VStack {
                            Spacer()
                            HStack {
                                Spacer()
                                Button("Save") {
                                    topics.append(newTopic)
                                    newTopic = ""
                                    showingAddTopicView = false
                                }
                                .frame(width: 150, height: 50)
                                .foregroundColor(.white)
                                .background(Color.blue)
                                .cornerRadius(8)
                                .disabled(newTopic.isEmpty)
                                .padding()
                            }
                        }
                    }
                    .navigationTitle("Add Topic")
                    .navigationBarItems(trailing: Button("Cancel") {
                        showingAddTopicView = false
                    })
                }
            }
        }
        .accentColor(.blue)
    }
}

struct TopicsView_Previews: PreviewProvider {
    static var previews: some View {
        TopicsView()
    }
}
