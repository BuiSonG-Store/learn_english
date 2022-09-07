import 'package:flutter/material.dart';
import 'package:learn_english/common/constants/icons_const.dart';
import 'package:learn_english/injector/injector_container.dart';
import 'package:shimmer/shimmer.dart';
import 'package:learn_english/router/navigate_service.dart';

final NavigationService _navigationService = injector<NavigationService>();

class CustomImageNetwork extends StatelessWidget {
  final String? url;
  final double width;
  final double height;
  final BoxFit? fit;
  final double? border;
  final String? userName;
  final String? urlAvt;
  final TextStyle? styleUserName;
  final Decoration? decorationPlaceHolder;
  final Widget? placeHolder;
  final bool isAvatar;

  const CustomImageNetwork({
    Key? key,
    this.url,
    this.width = 40,
    this.height = 40,
    this.fit,
    this.border,
    this.userName,
    this.decorationPlaceHolder,
    this.styleUserName,
    this.placeHolder,
    required this.isAvatar,
    this.urlAvt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (url?.isNotEmpty ?? false) {
      return ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(border ?? 0)),
        child: Image.network(
          url ?? '',
          fit: fit,
          width: width,
          height: height,
          errorBuilder: (
            BuildContext? context,
            Object? error,
            StackTrace? stackTrace,
          ) {
            return _widgetImagePlaceHolder(urlAvt);
          },
          loadingBuilder: (
            BuildContext? context,
            Widget? child,
            ImageChunkEvent? loadingProgress,
          ) {
            if (loadingProgress == null) {
              return child ?? const SizedBox();
            }
            return Shimmer.fromColors(
              baseColor: const Color(0xFFE0E0E0),
              highlightColor: const Color(0xFFF5F5F5),
              enabled: true,
              child: Container(
                width: width,
                height: height,
                color: Theme.of(_navigationService.getContext()).primaryColor,
              ),
            );
          },
        ),
      );
    }
    return _widgetImagePlaceHolder(urlAvt);
  }

  Widget _widgetImagePlaceHolder(String? urlAvt) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(border ?? 0)),
      child: (placeHolder ??
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(_navigationService.getContext()).primaryColor, width: 0.5),
              borderRadius: BorderRadius.all(Radius.circular(border ?? 0)),
            ),
            child: Center(
              child: isAvatar
                  ? Image.asset(
                      urlAvt ?? IconConst.userEmpty,
                      width: 100,
                      height: 100,
                    )
                  : Image.asset(
                      IconConst.imagePlaceHolder,
                      width: width,
                      height: height,
                    ),
            ),
          )),
    );
  }
}
