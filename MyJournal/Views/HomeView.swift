//
//  ContentView.swift
//  MyJournal
//
//  Created by DaiTran on 17/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @State var posts: [Post] = []
    @State var errorMessage: String?
    
    var body: some View {
        VStack {
            HStack {
                Group {
                    Text("Logout")
                    Spacer()
                    Text("New Post")
                }.font(.system(size: 17, weight: .semibold, design: .default))
            }
            
            HStack {
                Text("Posts")
                    .font(.system(size: 35, weight: .bold, design: .default))
                Spacer()
            }.padding(.vertical,8)
            ScrollView {
                Text("\(self.errorMessage ?? "none")")
                postsView
            }
            .onAppear(perform: {
                loadPosts()
            })
            Spacer()
            
        }
        .padding()
        .background(Color(.init(white: 0.9, alpha: 0.9)))
    }
    private var postsView : some View {
        
        ForEach(posts, id: \.self) { post in
            VStack(alignment: .leading) {
                Text(post.title)
                    .font(.system(size: 25, weight: .semibold))
                Text("Posted 15s ago")
                    .font(.system(size: 15, weight: .light))
                    .italic()
                    .foregroundStyle(Color(.lightGray))
                    .padding(.bottom,10)
                Text(post.content)
                    .font(.system(size: 20,weight: .semibold))
                    .foregroundStyle(Color(.lightGray))
                Image(post.imageUrl)
                    .resizable()
                    .scaledToFit()
                        
                Divider().padding(.vertical)
                    
                HStack {
                    Button {
                            
                    } label: {
                        Spacer()
                        Text("Open")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color(.black))
                    }
                    Button {
                            
                    } label: {
                        Text("Delete")
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundStyle(Color(.red))
                    }

                }
            }
            
            
            .padding()
            .background(.white)
            .cornerRadius(10)
            .padding(.vertical, 8)
        }
    }
    func loadPosts() {
        APIService.shared.fetchPosts { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let posts):
                    self.posts = posts
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
