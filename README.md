# animations_flutter

Flutter 动画的基本使用

![easing](https://github.com/dlgchg/animations_flutter/blob/master/easing.gif?raw=true)
![offset](https://github.com/dlgchg/animations_flutter/blob/master/offset.gif?raw=true)
![parent](https://github.com/dlgchg/animations_flutter/blob/master/parent.gif?raw=true)
![trans](https://github.com/dlgchg/animations_flutter/blob/master/trans.gif?raw=true)
![value](https://github.com/dlgchg/animations_flutter/blob/master/value.gif?raw=true)


在使用Flutter动画的时候,我们通常使用这几个组件.
* `AnimationController`,控制动画的抽象类
* `Animation`,给定值,转换为动画
*  `Tween`, 执行范围
* `AnimatedBuilder`, 处理动画的Widget

## 简单平移

首先使用有状态的`StatefulWidget`,创建`AnimationController`和`Animation`,并在`initState`中初始化这两个对象.
`vsync`需要使用`with TickerProviderStateMixin`,这样才是正常的进行动画的操作.
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
通过`AnimationController`的`forward()`方法来执行动画.

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
下面就是刚刚的效果.
![easing](https://github.com/dlgchg/animations_flutter/blob/master/easing.gif?raw=true)


## 偏移和延迟

偏移和延迟代码还是按照上面的代码来,执行三个控件,并将其中一个延迟执行.
实现延迟操作,需要使用`Interval`来进行操作,`Interval`是一个可以返回`CurveAnimation`的一个类,设置`begin`和`end`的值,让动画知道在哪个点才开始执行.
```dart
  AnimationController _controller;
  Animation _animation, _lateAnimation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    )..addStatusListener(_handler);
    _lateAnimation = Tween(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
      ),
    );
  }

  _handler(status) {
    if (status == AnimationStatus.completed) {
      _animation.removeStatusListener(_handler);
      _controller.reset();
      _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Curves.fastOutSlowIn,
        ),
      );
      _lateAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(0.2, 1.0, curve: Curves.fastOutSlowIn),
        ),
      )..addStatusListener((status) {
          if (status == AnimationStatus.completed) {
            Navigator.pop(context);
          }
        });
      _controller.forward();
    }
  }

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
          return Center(
            child: Column(
              children: <Widget>[
                Transform(
                  transform: Matrix4.translationValues(
                      _animation.value * width, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      _animation.value * width, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      _lateAnimation.value * width, 0.0, 0.0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 50,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
```

来看看效果.

![easing](https://github.com/dlgchg/animations_flutter/blob/master/offset.gif?raw=true)


## 转换

这里使用`BorderRadiusTween`来完成一个空间的转换动画,圆形转方形.
这里将初始化设为50的一个圆,`BorderRadiusTween`设置圆的弧度.

```dart
AnimationController controller;
  Animation animation, borderAnimation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 2000),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        }
        if (status == AnimationStatus.dismissed) {
          Navigator.pop(context);
        }
      });

    animation = Tween(begin: 50.0, end: 200.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.ease,
      ),
    );

    borderAnimation = BorderRadiusTween(
      begin: BorderRadius.circular(75.0),
      end: BorderRadius.circular(0.0),
    ).animate(CurvedAnimation(
      parent: controller,
      curve: Curves.ease,
    ));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.toString()),),
      body: AnimatedBuilder(animation: controller, builder: (context, child) {
        return Center(
          child: Container(
            width: animation.value,
            height: animation.value,
            decoration: BoxDecoration(
              borderRadius: borderAnimation.value,
              color: Colors.pink,
            ),
          ),
        );
      }),
    );
  }
```

![trans](https://github.com/dlgchg/animations_flutter/blob/master/trans.gif?raw=true)


