//
//  GlobalFunctions.swift
//  EpifiAssignment
//
//  Created by Saalis Umer on 09/05/20.
//  Copyright © 2020 Saalis Umer. All rights reserved.
//

import Foundation
import Toast
func runAsyncOnMainQueue(block:@escaping ()->()){
    if Thread.current.isMainThread{
        block()
    }
    else{
        DispatchQueue.main.async {
            block()
        }
    }
}


func showToast(_ text:String, on view:UIView){
    runAsyncOnMainQueue {
        let style = CSToastStyle(defaultStyle: ())
        style?.messageAlignment = .center
        view.makeToast(text,duration: 1.0,position: CSToastPositionBottom,style: style)
    }
}
