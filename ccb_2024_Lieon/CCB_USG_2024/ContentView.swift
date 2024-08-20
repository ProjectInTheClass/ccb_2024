//
//  ContentView.swift
//  CCB_USG_2024
//
//  Created by jun on 8/7/24.
//

import SwiftUI

struct Profile: Identifiable {
    let id = UUID()
    let name: String
    let interest: String
}

struct ContentView: View {
    @State private var profiles: [Profile] = []
    
    @State private var showingAddProfileSheet = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(profiles) { profile in
                        VStack(alignment: .leading) {
                            Text("이름: \(profile.name)")
                                .font(.headline)
                            Text("관심사: \(profile.interest)")
                        }
                        .swipeActions {
                            Button(role: .destructive) {
                                deleteProfile(profile)
                            } label: {
                                Label("삭제", systemImage: "trash")
                            }
                        }
                    }
                }
                
                Button(action: {
                    showingAddProfileSheet.toggle()
                }) {
                    Text("+")
                        .font(.largeTitle)
                        .frame(width: 60, height: 60)
                        .background(Color.gray)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .shadow(radius: 10)
                }
                .padding()
            }
            .navigationTitle("캐릭터를 선택하세요")
            .sheet(isPresented: $showingAddProfileSheet) {
                AddProfileView(profiles: $profiles)
            }
        }
    }
    
    private func deleteProfile(_ profile: Profile) {
        if let index = profiles.firstIndex(where: { $0.id == profile.id }) {
            profiles.remove(at: index)
        }
    }
}

struct AddProfileView: View {
    @State private var name: String = ""
    @State private var interest: String = ""
    
    @Binding var profiles: [Profile]
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("프로필 정보")) {
                    TextField("이름을 입력하세요", text: $name)
                    
                    TextField("관심사를 입력하세요", text: $interest)
                }
                
                Button(action: {
                    if !name.isEmpty && !interest.isEmpty {
                        let newProfile = Profile(name: name, interest: interest)
                        profiles.append(newProfile)
                        dismiss()
                    }
                }) {
                    Text("저장")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationTitle("새 프로필 추가")
            .navigationBarItems(trailing: Button("닫기") {
                dismiss()
            })
        }
    }
    
    @Environment(\.dismiss) private var dismiss
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
