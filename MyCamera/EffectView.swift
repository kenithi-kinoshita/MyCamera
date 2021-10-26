//
//  EffectView.swift
//  MyCamera
//
//  Created by 木下健一 on 2021/10/26.
//

import SwiftUI

struct EffectView: View {
    // エフェクト編集画面（シート）の表示有無を管理する状態変数
    @Binding var isShowSheet: Bool
    // 撮影した写真
    let captureImage: UIImage
    // 表示する写真
    @State var showImage: UIImage?
    // シェア画面（UIActivityViewController)
    // 表示有無を管理する状態変数
    @State var isShowActivity = false
    
    var body: some View {
        VStack{
            Spacer()
            if let unwrapShowImage = showImage {
                // 表示する写真がある場合は画面に表示
                Image(uiImage: unwrapShowImage)
                // リサイズする
                    .resizable()
                // アスペクト比を維持して画面内に収まるようにする
                    .aspectRatio(contentMode: .fit)
            }
            Spacer()
            // エフェクトボタン
            Button(action: {
                // ボタンをタップした時のアクション
                
            }) {
                Text("エフェクト")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // エフェクトButton end
            .padding()
            // シェアボタン
            Button(action: {
                // ボタンをタップした時のアクション
            }) {
                Text("シェア")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // シェアボタン end
            .padding()
            // 閉じるボタン
            Button(action: {
                // ボタンをタップした時のアクション
            }) {
                Text("閉じる")
                    .frame(maxWidth: .infinity)
                    .frame(height: 50)
                    .multilineTextAlignment(.center)
                    .background(Color.blue)
                    .foregroundColor(Color.white)
            } // シェアボタン end
            .padding()
        } // VStack end
        // 写真が表示される時に実行される
        .onAppear {
            // 撮影した写真を表示する写真に設定
            showImage = captureImage
        } // .onAppear end
    } // body end
} // EffectView end

struct EffectView_Previews: PreviewProvider {
    static var previews: some View {
        EffectView(
            isShowSheet: Binding.constant(true),
            captureImage: UIImage(named:  "preview_use")!)
    }
}
