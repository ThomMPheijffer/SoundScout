//
//  ReplaceKeyWindow.swift
//  SoundScout
//
//  Created by Thom Pheijffer on 01/06/2023.
//

import UIKit

func replaceKeyWindow(with viewController: UIViewController) {
    let allScenes = UIApplication.shared.connectedScenes
    let scene = allScenes.first { $0.activationState == .foregroundActive }
    
    if let windowScene = scene as? UIWindowScene {
        windowScene.keyWindow?.rootViewController = viewController
    }
}
