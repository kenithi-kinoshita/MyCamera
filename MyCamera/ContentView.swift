//
//  ContentView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/22.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        // 縦方向にレイアウト
        VStack {
            Spacer()
            // 「カメラを起動する」ボタン
            Button(action: {
                // ボタンをタップした時のアクション
                // カメラが利用可能かチェック
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    print("カメラは利用できます")
                } else {
                    print("カメラは利用できません")
                }

            }) {
                Text("カメラを起動する")
                    // 横いっぱい
                    .frame(maxWidth: .infinity)
                    // 高さ50ポイントを指定
                    .frame(height: 50)
                    // 文字列をセンタリング指定
                    .multilineTextAlignment(.center)
                    // 背景を青色に指定
                    .background(Color.blue)
                    // 文字色を白色に指定
                    .foregroundColor(Color.white)
            } // Button end
        } // VStack end
    } // body end
} // ContentView end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
