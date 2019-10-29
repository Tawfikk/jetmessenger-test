//
//  String+Kingfisher.swift
//  jetmessenger
//
//  Created by Abdul Tawfik on 29.10.2019.
//  Copyright © 2019 tawfik. All rights reserved.
//

import Foundation

extension String {
    func getAvatar() -> URL? {
        guard let imageURL = URL(string: "https://open.rocket.chat/avatar/\(self)?format=jpeg") else { return nil }
        return imageURL
    }
}
