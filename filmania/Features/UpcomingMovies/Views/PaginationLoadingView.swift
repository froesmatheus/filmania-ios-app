import Foundation
import UIKit

protocol PaginationLoadingDelegate: AnyObject {
    func didTapTryAgain()
}

final class PaginationLoadingView: UIView {
    private var contentView: UIView!

    @IBOutlet private var viewError: UIView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private var buttonTryAgain: UIButton!
    
    weak var delegate: PaginationLoadingDelegate?

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        setupView()
    }

    private func setupView() {
        contentView = viewFromNibForClass()
        contentView.frame = bounds
        contentView.clipsToBounds = true

        contentView.autoresizingMask = [
            UIView.AutoresizingMask.flexibleWidth,
            UIView.AutoresizingMask.flexibleHeight
        ]

        addSubview(contentView)

        buttonTryAgain.addTarget(self, action: #selector(didTapTryAgain), for: .touchUpInside)
    }

    @objc private func didTapTryAgain() {
        delegate?.didTapTryAgain()
    }

    func showLoading() {
        viewError.isHidden = true
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        viewError.isHidden = true
        activityIndicator.stopAnimating()
    }

    func showError() {
        viewError.isHidden = false
        activityIndicator.stopAnimating()
    }

    private func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = (nib.instantiate(withOwner: self, options: nil).first as? UIView)!
        return view
    }
}
