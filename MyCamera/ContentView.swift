//
//  ContentView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/22.
//

import SwiftUI

struct ContentView: View {
    // 撮影する写真を保持する状態変数
    @State var captureImage: UIImage? = nil
    // 撮影画面のsheet
    @State var isShowSheet = false
    
    var body: some View {
        // 縦方向にレイアウト
        VStack {
            Spacer()
            // 撮影した写真がある時
            if let unwrapCaptureImage = captureImage {
                // 撮影写真を表示
                Image(uiImage: unwrapCaptureImage)
                    // リサイズ
                    .resizable()
                    // アスペクト比を維持して画面内に
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            // 「カメラを起動する」ボタン
            Button(action: {
                // ボタンをタップした時のアクション
                // カメラが利用可能かチェック
                if UIImagePickerController.isSourceTypeAvailable(.camera){
                    print("カメラは利用できます")
                    // カメラが使えるなら、isShowSheetをtrue
                    isShowSheet = true
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
            } // カメラ起動Button end
            .padding()
            // sheetを表示
            // isPresentedで指定した状態変数がtrueのとき実行
            .sheet(isPresented: $isShowSheet) {
                // UIImagePickerControllerをsheetを表示
                ImagePickerView(isShowSheet: $isShowSheet,
                                captureImage: $captureImage)
            }// カメラ起動Button sheet end
        } // VStack end
    } // body end
} // ContentView end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
