# animations_flutter

Flutter 动画的基本使用

![](https://github.com/dlgchg/animations_flutter/blob/master/animtions.gif?raw=true)


在使用Flutter动画的时候,我们通常使用这几个组件.
* `AnimationController`,控制动画的抽象类
* `Animation`,给定值,转换为动画
*  `Tween`, 执行范围
* `AnimatedBuilder`, 处理动画的Widget

## 简单平移

首先使用有状态的`StatefulWidget`,创建`AnimationController`和`Animation`,并在`initState`中初始化这两个对象.
在`initState`方法中,声明这个动画执行时间为2秒.给`animation`添加一个监听事件,在动画完成后,将移除这个简单,并将`AnimationController`还原为初始状态,在执行一次动画.
```dart
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener(_handler);
  }

  _handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(_handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _controller, curve: Curves.fastOutSlowIn),
      )..addStatusListener(
          (status) {
            if (status == AnimationStatus.completed) {
              Navigator.pop(context);
            }
          },
        );
      _controller.forward();
    }
  }
```

在`build`方法,使用`AnimatedBuilder`控件来对动画进行控制和处理,其中`animation`绑定之前定义的`AnimationController`.
`Transform`控件可以将动画执行中的变量值处理反馈在子控件上.
`Matrix4.translationValues`这里将子控件在x轴上进行平移.

```dart
  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    _controller.forward();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.toString()),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.translationValues(
              _animation.value * width,
              0.0,
              0.0,
            ),
            child: Center(
              child: Container(
                width: 200.0,
                height: 200.0,
                color: Colors.blue,
              ),
            ),
          );
        },
      ),
    );
  }
```

最后一定要将`AnimationController`进行销毁.
```dart
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
```

![easing](https://github.com/dlgchg/animations_flutter/blob/master/easing.gif?raw=true)

