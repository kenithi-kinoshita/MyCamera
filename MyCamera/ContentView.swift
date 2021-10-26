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
                // ActionSheet を表示する
                isShowAction = true

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
            }// カメラ起動Button sheet end
            
            // 状態変数：$isShowActionに変化があったら実行
            .actionSheet(isPresented: $isShowAction) {
                // ActionSheet を表示する
                ActionSheet(title: Text("確認"),
                            message: Text("選択してください"),
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
            
            // 「SNSに投稿する」ボタン
            Button(action: {
                // ボタンをタップしたときのアクション
                // 撮影した写真があるときだけ
                if let _ = captureImage {
                    isShowActivity = true
                }
                
            }) {
                Text("SNSに投稿する")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // 「SNSに投稿する」Button end
            .padding()
            // sheetを表示
            // isPresentedで指定した状態変数がtrueのとき実行
            .sheet(isPresented: $isShowActivity) {
                // UIActivityViewController（シェア機能）を表示
                ActivityView(shareItems: [captureImage!])
            }
        } // VStack end
    } // body end
} // ContentView end

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
