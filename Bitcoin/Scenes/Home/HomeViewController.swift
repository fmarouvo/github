//
//  HomeViewController.swift
//  Bitcoin
//
//  Created by Fausto Castagnari Marouvo on 10/18/20.
//

import UIKit
import RxSwift
import Charts
import SkeletonView

class HomeViewController: UIViewController {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var chartView: LineChartView!
    @IBOutlet private weak var lastQuoteCard: UIView!
    @IBOutlet private weak var lastQuoteTileLabel: UILabel!
    @IBOutlet private weak var lastQuoteValueLabel: UILabel!
    @IBOutlet private weak var lastQuoteUpdatedAtLabel: UILabel!
    @IBOutlet private weak var lastQuoteView: UIView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    private let viewModel: HomeViewModelType
    private let disposeBag = DisposeBag()
    
    private var entries: [ChartDataEntry] = []
    private var shouldHideData: Bool = false

    init(withViewModel viewModel: HomeViewModelType) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareViewModel()
        fetchData()
        prepareChart()
        prepareLabels()
        prepareViews()
    }

    func prepareViewModel() {
        viewModel.output.onMarketPriceFetched
            .drive(onNext: { [weak self] marketPriceResponse in
                guard let self = self else { return }
                self.lastQuoteValueLabel.text = NSLocalizedString("Home.LastQuoteView.Label.Value", comment: "")
                    .localizeWithFormat(arguments: marketPriceResponse.marketPrice.convertToMoneyWithTwoDecimals())
                self.lastQuoteUpdatedAtLabel.text = NSLocalizedString("Home.LastQuoteView.Label.UpdatedAt", comment: "")
                    .localizeWithFormat(arguments: marketPriceResponse.updatedAt.dateFromTimestamp().formatted(using: .dateAndTime))
                self.lastQuoteView.hideSkeleton()
            }).disposed(by: disposeBag)
        
        viewModel.output.onMarketPriceVariationFetched
            .drive(onNext: { [weak self] variation in
                guard let self = self else { return }
                self.entries = Array(variation.map { value in
                    ChartDataEntry(x: value.date, y: value.value)
                }.suffix(60))
                self.setDataCount(self.entries)
                self.updateChartData()
            }).disposed(by: disposeBag)
    }
    
    func fetchData() {
        viewModel.input.fetchMarketPrice.onNext(())
        viewModel.input.fetchMarketPriceVariation.onNext(())
    }
    
    func prepareChart() {
        chartView.delegate = self
        
        chartView.chartDescription.enabled = false
        
        chartView.dragEnabled = true
        chartView.setScaleEnabled(true)
        chartView.pinchZoomEnabled = false
        chartView.highlightPerDragEnabled = true
        
        chartView.backgroundColor = .white
        
        chartView.legend.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bottom
        xAxis.labelFont = .systemFont(ofSize: 8, weight: .light)
        xAxis.labelTextColor = .darkGray
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.centerAxisLabelsEnabled = true
        xAxis.granularity = 7
        xAxis.valueFormatter = DateValueFormatter() as? AxisValueFormatter
        
        let leftAxis = chartView.leftAxis
        leftAxis.labelPosition = .outsideChart
        leftAxis.labelFont = .systemFont(ofSize: 8, weight: .light)
        leftAxis.drawGridLinesEnabled = true
        leftAxis.granularityEnabled = true
        leftAxis.axisMinimum = 10000
        leftAxis.axisMaximum = 12000
        leftAxis.yOffset = 0
        leftAxis.labelTextColor = .darkGray
        
        chartView.rightAxis.enabled = false
        
        chartView.legend.form = .line
        chartView.animate(xAxisDuration: 2.5)
    }
    
    func prepareLabels() {
        titleLabel.text = NSLocalizedString("Home.Label.Title", comment: "")
        lastQuoteTileLabel.text = NSLocalizedString("Home.LastQuoteView.Label.LastQuote", comment: "")
        lastQuoteValueLabel.text = NSLocalizedString("", comment: "")
        lastQuoteUpdatedAtLabel.text = NSLocalizedString("Home.LastQuoteView.Label.UpdatedAt", comment: "")
    }
    
    func prepareViews() {
        lastQuoteCard.layer.cornerRadius = 12
        
        lastQuoteView.isSkeletonable = true
        lastQuoteView.showAnimatedSkeleton()
    }
    
}

extension HomeViewController: ChartViewDelegate {
    func updateChartData() {
        if self.shouldHideData {
            chartView.data = nil
            return
        }
        self.setDataCount(self.entries)
    }
    
    func setDataCount(_ entries: [ChartDataEntry]) {
        let set1 = LineChartDataSet(entries: entries, label: "DataSet 1")
        set1.axisDependency = .left
        set1.setColor(.blue)
        set1.lineWidth = 1.5
        set1.drawCirclesEnabled = false
        set1.drawValuesEnabled = false
        set1.fillAlpha = 0.26
        set1.fillColor = UIColor(red: 51/255, green: 181/255, blue: 229/255, alpha: 1)
        set1.highlightColor = UIColor(red: 244/255, green: 117/255, blue: 117/255, alpha: 1)
        set1.drawCircleHoleEnabled = false
        
        let data = LineChartData(dataSet: set1)
        data.setValueTextColor(.white)
        data.setValueFont(.systemFont(ofSize: 9, weight: .light))
        
        chartView.data = data
    }

}
