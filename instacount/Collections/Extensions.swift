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

class ReplaceTopSegue: UIStoryboardSegue {
    override func perform() {
        var vcs = source.navigationController?.viewControllers ?? [source]
        vcs.removeLast()
        vcs.append(destination)
        source.navigationController?.setViewControllers(vcs, animated: true)
    }
}
