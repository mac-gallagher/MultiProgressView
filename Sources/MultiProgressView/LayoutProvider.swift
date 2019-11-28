import UIKit

protocol LayoutProvidable {
    static var trackFrame: (MultiProgressView) -> CGRect { get }
    static var trackImageViewFrame: (MultiProgressView) -> CGRect { get }
    static var cornerRadius: (MultiProgressView) -> CGFloat { get }
    static var trackCornerRadius: (MultiProgressView) -> CGFloat { get }
    
    static var sectionFrame: (MultiProgressView, Int) -> CGRect { get }
    static var sectionImageViewFrame: (ProgressViewSection) -> CGRect { get }
    
    static func anchorToSuperview(_ view: UIView,
                                  withAlignment alignment: AlignmentType,
                                  insets: UIEdgeInsets) -> [NSLayoutConstraint]
}

struct LayoutProvider: LayoutProvidable {
    
    static var trackFrame: (MultiProgressView) -> CGRect {
        return { progressView in
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
    }
    
    static var trackImageViewFrame: (MultiProgressView) -> CGRect {
        return { progressView in
            return progressView.track.bounds
        }
    }
    
    static var cornerRadius: (MultiProgressView) -> CGFloat {
        return { progressView in
            switch progressView.lineCap {
            case .round:
                return progressView.cornerRadius == 0 ?
                    progressView.bounds.height / 2 : progressView.cornerRadius
            case .butt, .square:
                return 0
            }
        }
    }
    
    static var trackCornerRadius: (MultiProgressView) -> CGFloat {
        return { progressView in
            let cornerRadiusFactor = progressView.cornerRadius / progressView.bounds.height
            let trackHeight = progressView.track.bounds.height
            
            switch progressView.lineCap {
            case .round:
                return progressView.cornerRadius == 0 ?
                    trackHeight / 2 : cornerRadiusFactor * trackHeight
            case .butt, .square:
                return 0
            }
        }
    }
    
    static var sectionFrame: (MultiProgressView, Int) -> CGRect {
        return { progressView, section in
            let trackBounds = progressView.track.bounds
            let width = trackBounds.width * CGFloat(progressView.progress(forSection: section))
            let size = CGSize(width: width, height: trackBounds.height)
            
            var origin: CGPoint = trackBounds.origin
            for (bar, index) in progressView.progressViewSections {
                if index < section {
                    origin.x += bar.frame.width
                }
            }
            
            return CGRect(origin: origin, size: size)
        }
    }
    
    static var sectionImageViewFrame: (ProgressViewSection) -> CGRect {
        return { section in
            return section.bounds
        }
    }
    
    static func anchorToSuperview(_ view: UIView,
                                  withAlignment alignment: AlignmentType,
                                  insets: UIEdgeInsets) -> [NSLayoutConstraint] {
        guard let superview = view.superview else { return [] }
        view.translatesAutoresizingMaskIntoConstraints = false
        
        var constraints = [NSLayoutConstraint]()
        
        let topConstraint = view.topAnchor.constraint(equalTo: superview.topAnchor,
                                                      constant: insets.top)
        let leftConstraint = view.leftAnchor.constraint(equalTo: superview.leftAnchor,
                                                        constant: insets.left)
        let rightConstraint = view.rightAnchor.constraint(equalTo: superview.rightAnchor,
                                                          constant: -insets.right)
        let bottomConstraint = view.bottomAnchor.constraint(equalTo: superview.bottomAnchor,
                                                            constant: -insets.bottom)
        let centerXConstraint = view.centerXAnchor.constraint(equalTo: superview.centerXAnchor,
                                                              constant: insets.left - insets.right)
        let centerYConstraint  = view.centerYAnchor.constraint(equalTo: superview.centerYAnchor,
                                                               constant: insets.top - insets.bottom)
        
        switch alignment {
        case .bottom:
            constraints.append(bottomConstraint)
            constraints.append(centerXConstraint)
            
        case .bottomLeft:
            constraints.append(bottomConstraint)
            constraints.append(leftConstraint)
            
        case .bottomRight:
            constraints.append(bottomConstraint)
            constraints.append(rightConstraint)
            
        case .center:
            constraints.append(centerXConstraint)
            constraints.append(centerYConstraint)
            
        case .left:
            constraints.append(leftConstraint)
            constraints.append(centerYConstraint)
            
        case .right:
            constraints.append(rightConstraint)
            constraints.append(centerYConstraint)
            
        case .top:
            constraints.append(topConstraint)
            constraints.append(centerXConstraint)
            
        case .topLeft:
            constraints.append(topConstraint)
            constraints.append(leftConstraint)
            
        case .topRight:
            constraints.append(topConstraint)
            constraints.append(rightConstraint)
        }
        
        constraints.forEach { $0.isActive = true }
        
        return constraints
    }
}
