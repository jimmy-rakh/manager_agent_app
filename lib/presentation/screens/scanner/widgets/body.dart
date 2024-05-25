import 'package:bingo/core/assets/assets.dart';
import 'package:bingo/core/custom_widgets/app_button.dart';
import 'package:bingo/core/utils/mediaquery.dart';
import 'package:bingo/core/utils/spaces.dart';
import 'package:bingo/presentation/screens/scanner/scanner_viewmodel.dart';
import 'package:bingo/presentation/screens/scanner/widgets/actions.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:iconly/iconly.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:stacked/stacked.dart';

class ScannerBody extends ViewModelWidget<ScannerViewModel> {
  const ScannerBody({super.key});

  @override
  Widget build(BuildContext context, ScannerViewModel viewModel) {
    return Stack(
      children: [
        MobileScanner(
          controller: viewModel.scannerController,
          onDetect: viewModel.onDetect,
          onScannerStarted: viewModel.onScannerStarted,
          placeholderBuilder: (p0, p1) =>
              const Center(child: CupertinoActivityIndicator()),
          errorBuilder: (p0, p1, p2) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  IconlyBold.info_square,
                  size: 32,
                ),
                verticalSpace12,
                Text(p1.errorDetails?.message ?? p1.errorCode.name),
                ...[
                  verticalSpace16,
                  if (p1.errorCode == MobileScannerErrorCode.permissionDenied)
                    AppButton(
                      text: 'common.accept'.tr(),
                      onPressed: () => viewModel.onError(p1.errorCode),
                      fillColor: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    )
                ]
              ],
            ),
          ),
        ),
        if (viewModel.scannerController.hasTorch) ...[
          Align(
              alignment: Alignment.center,
              child: TranslationAnimatedWidget(
                enabled: viewModel.isActive,
                //update this boolean to forward/reverse the animation
                values: [
                  Offset(0, viewModel.animationArea), // disabled value value
                  const Offset(0, 0), //intermediate value
                  Offset(0, -viewModel.animationArea) //enabled value
                ],
                duration: const Duration(milliseconds: 500),
                curve: Curves.decelerate,
                child: Container(
                  decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).primaryColor.withOpacity(.5),
                          spreadRadius: 2,
                          blurRadius: 10,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ]),
                  height: 5,
                  margin:
                      EdgeInsets.symmetric(horizontal: ScreenSize.width * 0.26),
                ),
              )),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset(AppAssets.qr),
          )
        ],
        if (viewModel.scannerController.hasTorch) const ScannerActions()
      ],
    );
  }
}

class TranslationAnimatedWidget extends StatefulWidget {
  final List<Offset> _values;
  final Duration duration;
  final Duration delay;
  final bool enabled;
  final Curve curve;
  final Widget child;
  final Function(bool)? animationFinished;

  /// An translation animation using 2 values : enabled - disabled
  ///
  /// duration : the duration of the animation, including intermediate values
  /// delay : the delay before the animation starts
  /// enabled : determine if the animation is stopped or fired
  /// curve : An easing curve, see [Curve]
  ///
  /// translationDisabled : the default value of the widget
  /// translationEnabled : the animated value of the widget
  ///
  /// animationFinished : a callback called when the animation is finished
  TranslationAnimatedWidget.tween({
    Duration duration = const Duration(milliseconds: 500),
    Duration delay = const Duration(),
    Offset translationDisabled = const Offset(0, 200),
    Offset translationEnabled = const Offset(0, 0),
    bool enabled = true,
    Function(bool)? animationFinished,
    Curve curve = Curves.linear,
    required Widget child,
  }) : this(
          duration: duration,
          enabled: enabled,
          curve: curve,
          delay: delay,
          child: child,
          animationFinished: animationFinished,
          values: [translationDisabled, translationEnabled],
        );

  /// An translation animation using 2-* values
  ///
  /// duration : the duration of the animation, including intermediate values
  /// delay : the delay before the animation starts
  /// enabled : determine if the animation is stopped or fired
  /// curve : An easing curve, see [Curve]
  ///
  /// values : list of [Offset] used for the animation,
  ///   - the first : will be the translationDisabled value
  ///   - intermediate values : intermediate values between translationDisabled & translationEnabled
  ///   - the last : will be the translationEnabled value
  ///
  /// animationFinished : a callback called when the animation is finished
  TranslationAnimatedWidget({
    this.duration = const Duration(milliseconds: 500),
    this.delay = const Duration(),
    List<Offset> values = const [Offset(0, 0), Offset(0, 200)],
    this.enabled = true,
    this.curve = Curves.linear,
    this.animationFinished,
    required this.child,
  })  : this._values = values,
        assert(values.length > 1);

  List<Offset> get values => _values;

  @override
  createState() => _State();

  //except the boolean `enabled`
  bool isAnimationEqual(TranslationAnimatedWidget other) =>
      listEquals(values, other.values) &&
      duration == other.duration &&
      curve == other.curve &&
      delay == other.delay;
}

class _State extends State<TranslationAnimatedWidget>
    with TickerProviderStateMixin {
  AnimationController? _animationController;
  late Animation<double> _translationXAnim;
  late Animation<double> _translationYAnim;

  @override
  void didUpdateWidget(TranslationAnimatedWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimationEqual(oldWidget)) {
      if (widget.enabled != oldWidget.enabled) {
        _updateAnimationState();
      }
    } else {
      _createAnimations();
      if (widget.enabled != oldWidget.enabled) {
        _updateAnimationState();
      }
    }
  }

  void _updateAnimationState() async {
    if (widget.enabled) {
      await Future.delayed(widget.delay);
      _animationController!.forward();
    } else {
      _animationController!.reverse();
    }
  }

  void _createAnimations() {
    _animationController?.dispose();
    _animationController = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..addStatusListener((status) {
        if (widget.animationFinished != null) {
          widget.animationFinished!(widget.enabled);
        }
      });

    _translationXAnim = chainTweens(
      widget.values.map((it) => it.dx).toList(),
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: widget.curve),
    ) as Animation<double>
      ..addListener(() {
        setState(() {});
      });

    _translationYAnim = chainTweens(
      widget.values.map((it) => it.dy).toList(),
    ).animate(
      CurvedAnimation(parent: _animationController!, curve: widget.curve),
    ) as Animation<double>
      ..addListener(() {
        setState(() {});
      });

    _updateAnimationState();
  }

  @override
  void initState() {
    _createAnimations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: Offset(_translationXAnim.value, _translationYAnim.value),
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }
}

TweenSequence chainTweens(List<double> values) {
  if (values.length < 2) {
    return TweenSequence<double>([]);
  }

  List<TweenSequenceItem<double>> items = <TweenSequenceItem<double>>[];

  var lastValue = values[0];
  for (int i = 1; i < values.length; ++i) {
    double newValue = values[i];
    items.add(TweenSequenceItem<double>(
        tween: Tween(begin: lastValue, end: newValue), weight: 1));
    lastValue = newValue;
  }

  return TweenSequence<double>(items);
}
