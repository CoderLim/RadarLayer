# RadarLayer
雷达效果Demo

通过添加一组layer并添加动画实现；

最近发现使用CAReplicatorLayer实现更简便，以下为swift实例，没有处理其他细节（比如透明度）：

方法ViewDidLoad：
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        let replicatorLayer = CAReplicatorLayer()
        replicatorLayer.frame = self.view.bounds
        self.view.layer.addSublayer(replicatorLayer)
        //
        let bar = CALayer()
        bar.frame = CGRectMake(self.view.center.x-100, self.view.center.y-100, 200, 200)
        bar.cornerRadius = 0.5 * bar.bounds.width
        bar.borderColor = UIColor.redColor().CGColor
        bar.borderWidth = 1.0
        replicatorLayer.addSublayer(bar)
        // 需要将scale先设置成0
        bar.transform = CATransform3DMakeScale(0, 0, 0)
        // 添加动画
        let animation = CABasicAnimation(keyPath: "transform.scale")
        animation.fromValue = 0
        animation.toValue = 1.0
        animation.duration = 3
        animation.autoreverses = false
        animation.repeatCount = Float.infinity
        bar.addAnimation(animation, forKey: nil)
        // 设置replicatorLayer
        replicatorLayer.instanceCount = 5;
        //replicatorLayer.instanceTransform = CATransform3DMakeScale(0, 0, 0)
        replicatorLayer.instanceDelay = animation.duration / Double(replicatorLayer.instanceCount)
    }

