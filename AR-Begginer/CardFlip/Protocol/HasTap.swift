//
//  HasTap.swift
//  CardFlipSample
//
//  Created by ミズキ on 2022/05/24.
//

protocol HasTap {
    var tapAction: (() -> Void)? { get set }
}
