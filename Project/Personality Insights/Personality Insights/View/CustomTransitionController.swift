//
// Created by Niklas Rammerstorfer on 22.03.18.
// Copyright (c) 2018 Niklas Rammerstorfer. All rights reserved.
//

import UIKit

class CustomTransitionController {

    static func transition(from: UIView, to: UIView, animation: TransitionAnimation, duration: TimeInterval, completion: @escaping () -> Void = {}){
        let multiplier: CGFloat = (animation == .rightToLeft ? 1 : -1)

        // Move destination view out of the view frame.
        to.frame.origin.x += to.frame.size.width * multiplier
        to.isHidden = false

        UIView.animate(withDuration: duration, animations: {
            // Define final state of animation.
            from.frame.origin.x -= from.frame.size.width * multiplier
            to.frame.origin.x = 0
        }, completion: {
            finished in

            from.isHidden = true
            completion()
        })
    }
}
