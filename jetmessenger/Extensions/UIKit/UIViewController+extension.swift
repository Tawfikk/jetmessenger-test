//
//  UIViewController+extension.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SVProgressHUD

extension UIViewController {
    
    func isLoading(for view: UIView) -> AnyObserver<Bool> {
        return Binder(view, binding: { (hud, isLoading) in
            switch isLoading {
            case true:
                SVProgressHUD.setDefaultStyle(.dark)
                SVProgressHUD.show()
            case false:
                SVProgressHUD.dismiss()
                break
            }
        }).asObserver()
    }

}
