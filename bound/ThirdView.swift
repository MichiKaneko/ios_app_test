//
//  ThirdView.swift
//  bound
//
//  Created by KANEKO Michihito on 2022/12/12.
//

import SwiftUI

struct ThirdView: View {
    @Binding var isShowNextView: Bool
    var body: some View {
        ZStack {
            Color(.green)
            VStack {
                Text("NextView")
                Button(action: {
                    isShowNextView = false
                    print("ボタンが押されたよ")
                }) {
                    Text("ボタン")
                }
            }
        }
    }
}
