//
//  LayoutCalculator.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 3/5/19.
//  Copyright © 2019 Mac Gallagher. All rights reserved.
//

protocol LayoutCalculatable {
    func trackFrame(forProgressView progressView: MultiProgressView) -> CGRect
    func trackImageViewFrame(forProgressView progressView: MultiProgressView) -> CGRect
    func sectionFrame(forProgressView progressView: MultiProgressView, section: Int) -> CGRect
    func sectionImageViewFrame(forSection section: ProgressViewSection) -> CGRect
    func cornerRadius(forProgressView progressView: MultiProgressView) -> CGFloat
    func trackCornerRadius(forProgressView progressview: MultiProgressView) -> CGFloat
    func anchorToSuperview(_ view: UIView, withAlignment alignment: AlignmentType, insets: UIEdgeInsets) -> [NSLayoutConstraint]
}

struct LayoutCalculator: LayoutCalculatable {
    static let shared: LayoutCalculator = LayoutCalculator()
    
    func trackFrame(forProgressView progressView: MultiProgressView) -> CGRect {
        switch progressView.lineCap {
        case .butt:
            return CGRect(x: 0,
                          y: progressView.trackInset,
                          width: progressView.frame.width,
                          height: progressView.frame.height - 2 * progressView.trackInset)
        case .round, .square:
            return CGRect(x: progressView.trackInset,
                          y: progressView.trackInset,
                          width: progressView.frame.width - 2 * progressView.trackInset,
                          height: progressView.frame.height - 2 * progressView.trackInset)
        }
    }
    
    func sectionFrame(forProgressView progressView: MultiProgressView, section: Int) -> CGRect {
        let trackBounds: CGRect = progressView.track.bounds
        let width: CGFloat = trackBounds.width * CGFloat(progressView.progress(forSection: section))
        let size: CGSize = CGSize(width: width, height: trackBounds.height)
        
        var origin: CGPoint = trackBounds.origin
        for index in 0..<progressView.progressViewSections.count {
            if index < section {
                origin.x += progressView.progressViewSections[index].frame.width
            }
        }
        
        return CGRect(origin: origin, size: size)
    }
    
    func trackImageViewFrame(forProgressView progressView: MultiProgressView) -> CGRect {
        return progressView.track.bounds
    }
    
    func sectionImageViewFrame(forSection section: ProgressViewSection) -> CGRect {
        return section.bounds
    }
    
    func cornerRadius(forProgressView progressView: MultiProgressView) -> CGFloat {
        switch progressView.lineCap {
        case .round:
            return progressView.cornerRadius == 0 ? progressView.bounds.height / 2 : progressView.cornerRadius
        case .butt, .square:
            return 0
        }
    }
    
    func trackCornerRadius(forProgressView progressView: MultiProgressView) -> CGFloat {
        let cornerRadiusFactor: CGFloat = progressView.cornerRadius / progressView.bounds.height
        let trackHeight: CGFloat = progressView.track.bounds.height
        
        switch progressView.lineCap {
        case .round:
            return progressView.cornerRadius == 0 ? trackHeight / 2 : cornerRadiusFactor * trackHeight
        case .butt, .square:
            return 0
        }
    }
    
    func anchorToSuperview(_ view: UIView, withAlignment alignment: AlignmentType, insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = view.superview else { return [] }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        switch alignment {
        case .bottom:
            constraints.append(view.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                            constant: -insets.bottom))
            constraints.append(view.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                                             constant: insets.left - insets.right))
            
        case .bottomLeft:
            constraints.append(view.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                            constant: -insets.bottom))
            constraints.append(view.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                          constant: insets.left))
            
        case .bottomRight:
            constraints.append(view.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                            constant: -insets.bottom))
            constraints.append(view.rightAnchor.constraint(equalTo: superview.rightAnchor,
                                                           constant: -insets.right))
            
        case .center:
            constraints.append(view.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                                             constant: insets.left - insets.right))
            constraints.append(view.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                                             constant: insets.top - insets.bottom))
            
        case .left:
            constraints.append(view.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                          constant: insets.left))
            constraints.append(view.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                                             constant: insets.top - insets.bottom))
            
        case .right:
            constraints.append(view.rightAnchor.constraint(equalTo: superview.rightAnchor, 
                                                           constant: -insets.right))
            constraints.append(view.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                                             constant: insets.top - insets.bottom))
            
        case .top:
            constraints.append(view.topAnchor.constraint(equalTo: superview.topAnchor,
                                                         constant: insets.top))
            constraints.append(view.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                                             constant: insets.left - insets.right))
            
        case .topLeft:
            constraints.append(view.topAnchor.constraint(equalTo: superview.topAnchor,
                                                         constant: insets.top))
            constraints.append(view.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                          constant: insets.left))
            
        case .topRight:
            constraints.append(view.topAnchor.constraint(equalTo: superview.topAnchor,
                                                         constant: insets.top))
            constraints.append(view.rightAnchor.constraint(equalTo: superview.rightAnchor,
                                                           constant: -insets.right))
        }
        
        constraints.forEach { $0.isActive = true }
        
        return constraints
    }
}
