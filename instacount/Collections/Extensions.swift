//
//  Extensions.swift
//  instacount
//
//  Created by Atom - Sachin on 9/25/17.
//  Copyright © 2017 Sachin Ahuja. All rights reserved.
//

import UIKit

enum Result<T> {
    case Success(T)
    case Failure(String)
}

func delay(_ delay: Double, closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: closure)
}

