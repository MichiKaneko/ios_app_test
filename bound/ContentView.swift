//
//  ContentView.swift
//  bound
//
//  Created by KANEKO Michihito on 2022/12/12.
//

import SwiftUI

struct ContentView: View {
    @State var isShowNextView = false
    @State var isShowAlert = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, world!")
                    .padding()
                NavigationLink(destination: SecondView().navigationTitle("画面2")) {
                    Text("SecondViewへ")
                }
                Button(action: {
                    isShowNextView = true
                }) {
                    Text("モーダル遷移")
                        .padding()
                }
                .sheet(isPresented: $isShowNextView) {
                    ThirdView(isShowNextView: $isShowNextView)
                }
                
                Button(action: {
                    isShowAlert = true
                }) {
                    Text("アラートを表示")
                }
                .alert("タイトル", isPresented: $isShowAlert) {
                    Button("キャンセル") {
                    }
                    Button("OK") {
                    }
                } message: {
                    Text("ここに詳細メッセージを書きます。")
                }
                Button(action: {
                    
                }) {
                    Text("ダイアログを表示")
                        .padding()
                }
                
                
            }
            .navigationTitle("画面1")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
