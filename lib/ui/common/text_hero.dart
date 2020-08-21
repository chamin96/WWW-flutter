import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class TextHeroFrom extends StatelessWidget {
  TextHeroFrom({
    Key key,
    String tag,
    TextStyle startTextStyle,
    TextStyle endTextStyle,
    String text,
  }) : this._(
          key: key,
          tag: tag,
          startTextStyle: startTextStyle,
          text: text,
          tween: TextStyleTween(begin: startTextStyle, end: endTextStyle),
        );

  const TextHeroFrom._({
    Key key,
    this.tag,
    this.startTextStyle,
    this.text,
    TextStyleTween tween,
  })  : this._tween = tween,
        super(key: key);

  final String tag;
  final TextStyle startTextStyle;
  final String text;

  final TextStyleTween _tween;

  @override
  Widget build(BuildContext context) => Hero(
        tag: tag,
        transitionOnUserGestures: true,
        flightShuttleBuilder:
            (flightContext, animation, direction, fromContext, toContext) =>
                AnimatedBuilder(
          animation: animation,
          builder: (context, child) => DefaultTextStyle(
            style: _tween.lerp(animation.value),
            child: child,
          ),
          child: AutoSizeText(
            text,
            stepGranularity: 0.2,
          ),
        ),
        child: Text(
          text,
          style: startTextStyle,
        ),
      );
}

class TextHeroTo extends StatelessWidget {
  const TextHeroTo({
    Key key,
    this.tag,
    this.text,
    this.style,
  }) : super(key: key);

  final String tag;
  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Hero(
      transitionOnUserGestures: true,
      createRectTween: (begin, end) => MaterialRectArcTween(
          begin: begin,
          end: Rect.fromLTWH(
              end.left,
              end.top,
              (end.width + mediaQuery.textScaleFactor).ceilToDouble(),
              (end.height + mediaQuery.textScaleFactor).ceilToDouble())),
      tag: tag,
      child: Text(text, style: style),
    );
  }
}
