//
//  LayoutCalculator.swift
//  MultiProgressView
//
//  Created by Mac Gallagher on 3/5/19.
//

protocol LayoutCalculatable {
    func trackFrame(forProgressView progressView: MultiProgressView) -> CGRect
    func trackImageViewFrame(forProgressView progressView: MultiProgressView) -> CGRect
    func sectionFrame(forProgressView progressView: MultiProgressView, section: Int) -> CGRect
    func sectionImageViewFrame(forSection section: ProgressViewSection) -> CGRect
    func cornerRadius(forProgressView progressView: MultiProgressView) -> CGFloat
    func trackCornerRadius(forProgressView progressview: MultiProgressView) -> CGFloat
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
}
