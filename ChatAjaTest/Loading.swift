//
//  Loading.swift
//  ChatAjaTest
//
//  Created by Nico Prasasty S on 03/03/20.
//  Copyright © 2020 Nico Prasasty Sembiring. All rights reserved.
//

import UIKit

class Loading: UIView {
    let animatorActivity = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = true
        
        let transparan = UIView()
        transparan.frame = self.frame
        transparan.alpha = 0.7
        transparan.backgroundColor = .black
        addSubview(transparan)
        
        animatorActivity.center = self.center
        
        animatorActivity.style = .large
        animatorActivity.color = .white
        addSubview(animatorActivity)
        self.bringSubviewToFront(animatorActivity)
        
        isHidden = true
    }
    
    override var isHidden: Bool{
        didSet{
            if isHidden{
                animatorActivity.stopAnimating()
            }else{
                animatorActivity.startAnimating()
            }
        }
    }
}
