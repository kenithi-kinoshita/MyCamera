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
    // シェア画面のsheet
    @State var isShowActivity = false
    // フォトライブラリーかカメラかを保持する状態変数
    @State var isPhotolibrary = false
    // ActionSheetモディファイアでの表示有無を管理する状態変数
    @State var isShowAction = false
    
    var body: some View {
        // 縦方向にレイアウト
        VStack {
            Spacer()
            // 「カメラを起動する」ボタン
            Button(action: {
                // ボタンをタップした時のアクション
                // 撮影写真を初期化する
                captureImage = nil
                // ActionSheet を表示する
                isShowAction = true

            }) {
                Text("投稿画像を選択する")
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
                if let unwrapCaptureImage = captureImage{
                    // 撮影した写真がある→EffectViewを表示する
                    EffectView(isShowSheet: $isShowSheet, captureImage: unwrapCaptureImage)
                    
                } else {
                // フォトライブラリーが選択された
                    if isPhotolibrary {
                    // PHPickerViewController（フォトライブラリー）を表示
                        PHPickerView (
                            isShowSheet: $isShowSheet,
                            captureImage: $captureImage)
                    } else {
                        // UIImagePickerController（写真撮影）を表示
                        ImagePickerView(
                            isShowSheet: $isShowSheet,
                            captureImage: $captureImage)
                    }
                }
            }// カメラ起動Button sheet end
            
            // 状態変数：$isShowActionに変化があったら実行
            .actionSheet(isPresented: $isShowAction) {
                // ActionSheet を表示する
                ActionSheet(title: Text("画像選択確認"),
                            message: Text("カメラで撮影するか\nフォトライブラリーから画像を選択してください"),
                            buttons: [
                                .default(Text("カメラ"), action: {
                                    // カメラを選択
                                    isPhotolibrary = false
                                    // カメラが利用可能がチェック
                                    if UIImagePickerController.isSourceTypeAvailable(.camera){
                                        print("カメラが利用できます")
                                        // カメラが使えるなら、isShowSheetを true
                                        isShowSheet = true
                                    } else {
                                        print("カメラが利用できません")
                                    }
                                        
                                }),
                                .default(Text("フォトライブラリー"), action:  {
                                    // フォトライブラリーを選択
                                    isPhotolibrary = true
                                    // isShowSheetをtrue
                                    isShowSheet = true
                                }),
                                // キャンセル
                                .cancel(),
                            ]) // ActionSheet end
            } // .actionSheet end
        } // VStack end
    } // body end
} // ContentView end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
