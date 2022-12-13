//
//  SecondView.swift
//  bound
//
//  Created by KANEKO Michihito on 2022/12/12.
//

import SwiftUI

struct Course: Hashable, Codable {
    let name: String
    let image: String
}

class ViewModel: ObservableObject {
    @Published var courses: [Course] = []
    func fetch(){
        guard let url = URL(string: "https://iosacademy.io/api/v1/courses/index.php") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){[weak self] data, _, error in guard let data = data, error == nil else {
                return
            }
            
            do {
                let courses = try JSONDecoder().decode([Course].self, from: data)
                DispatchQueue.main.async {
                    self?.courses = courses
                }
            }
            catch {
                print(error)
            }
        }
        task.resume()
    }
    
}

struct URLImage: View {
    let urlString: String
    @State var data: Data?
    
    var body: some View {
        if let data = data, let uiimage = UIImage(data: data) {
            Image(uiImage: uiimage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                    
        }
        else {
            Image(systemName: "video")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 130, height: 70)
                .background(Color.gray)
                .onAppear {
                    fetchData()
                }
        }
    }
    
    private func fetchData(){
        guard let url = URL(string: urlString) else {
            return
        }
        let task = URLSession.shared.dataTask(with: url){
            data,_,_ in self.data = data
        }
        task.resume()
    }
}

struct SecondView: View {
    @StateObject var viewModel = ViewModel()
    var body: some View {
        NavigationView{
            List {
                ForEach(viewModel.courses, id: \.self) {
                    course in HStack {
                        URLImage(urlString: course.image, data: nil)
                        Text(course.name)
                            .bold()
                    }
                    .padding(3)
                }
            }.navigationTitle("courses")
                .onAppear{
                    viewModel.fetch()
                }
        }
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        SecondView()
    }
}
