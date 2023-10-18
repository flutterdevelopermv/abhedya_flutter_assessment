
import 'package:flutter/material.dart';



class TextW extends StatelessWidget {
  final String data;
  final double? fontSize;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final bool? softWrap;
  final TextOverflow? overflow;
  final int? maxLines;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? decoration;
  final bool isBold;
  final bool isItalic;
  final bool isWhite;

  final double? textScaleFactor;
  final bool isHeading;
  final bool isSubtitle;
  final double? minFontSize;
  final double? maxFontSize;
  final EdgeInsetsGeometry? padding;
  final double? height;
  final double? letterSpacing;

  //
  const TextW(
    this.data, {
    this.fontSize,
    this.minFontSize,
    this.color,
    this.fontWeight,
    this.maxLines,
    this.overflow,
    this.softWrap,
    this.textAlign,
    this.textDirection,
    this.decoration,
    this.isBold = false,
    this.isItalic = false,
    this.isWhite = false,
    this.textScaleFactor,
    this.isHeading = false,
    this.isSubtitle = false,
    this.padding,
    this.height,
    this.maxFontSize,
    this.letterSpacing,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final textW = Text(
      data,
      textAlign: textAlign,
      textDirection: textDirection,
      softWrap: softWrap,
      overflow: overflow,
      maxLines: maxLines,
      textScaleFactor:
          textScaleFactor ?? (isHeading ? 1.1 : (isSubtitle ? 0.9 : 1)),
      style: TextStyle(
        fontSize: fontSize,
        letterSpacing: letterSpacing,
        fontWeight: isBold ? FontWeight.w500 : fontWeight,
        color: color ?? (isWhite ? Colors.white : null),
        decoration: decoration,
        fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
      ),
    );

    if (height != null) {
      return SizedBox(
        height: height,
        child: Align(alignment: Alignment.centerLeft, child: textW),
      );
    }

    if (padding != null) {
      return Padding(
        padding: padding!,
        child: textW,
      );
    } else {
      return textW;
    }
  }
}
