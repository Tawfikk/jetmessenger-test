//
//  RxSwift+UIScrollView.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    public var reachedBottom: Observable<Void> {
        let scrollView = self.base as UIScrollView
        return self.contentOffset.flatMap{ [weak scrollView] (contentOffset) -> Observable<Void> in
            guard let scrollView = scrollView else { return Observable.empty() }
            let visibleHeight = scrollView.frame.height - self.base.contentInset.top - scrollView.contentInset.bottom
            let y = contentOffset.y + scrollView.contentInset.top
            let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
            return (y > threshold - (threshold / 4)) ? Observable.just(()) : Observable.empty()
        }
    }
}
