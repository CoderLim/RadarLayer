# RadarLayer

This demo shows Radar effect using layer's animation.

# Demo 

![image](https://github.com/CoderGLM/RadarLayer/blob/master/screenshots/radar.gif)

I found a new simpler way recently, like this: 
----------------------
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

