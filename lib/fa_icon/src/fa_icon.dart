library base_bloc_project;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

enum IconType {
  solid('FontAwesomeSolid'),
  sharpSolid('FontAwesomeSharpSolid'),
  duoTone('FontAwesomeDuoTone'),
  brand('FontAwesomeBrand'),
  regular('FontAwesomeRegular'),
  light('FontAwesomeLight'),
  thin('FontAwesomeThin');
  final String fontFamily;
  const IconType(this.fontFamily);
}

class FaIcon extends StatelessWidget {
  final int codePoint;
  final IconType type;
  final double? size;
  final Color? color;
  final String? semanticLabel;
  final TextDirection? textDirection;
  final List<Shadow>? shadows;

  const FaIcon(
      this.codePoint, {
        super.key,
        this.type = IconType.solid,
        this.size,
        this.color,
        this.semanticLabel,
        this.textDirection,
        this.shadows,
      });

  @override
  Widget build(BuildContext context) {
    assert(this.textDirection != null || debugCheckHasDirectionality(context));
    final TextDirection textDirection = this.textDirection ?? Directionality.of(context);

    final IconThemeData iconTheme = IconTheme.of(context);

    final double? iconSize = size ?? iconTheme.size;

    final List<Shadow>? iconShadows = shadows ?? iconTheme.shadows;

    final double iconOpacity = iconTheme.opacity ?? 1.0;
    Color iconColor = color ?? iconTheme.color!;
    if (iconOpacity != 1.0) {
      iconColor = iconColor.withOpacity(iconColor.opacity * iconOpacity);
    }

    Widget iconWidget = RichText(
      overflow: TextOverflow.visible, // Never clip.
      textDirection: textDirection, // Since we already fetched it for the assert...
      text: TextSpan(
        text: String.fromCharCode(codePoint),
        style: TextStyle(
          inherit: false,
          color: iconColor,
          fontSize: iconSize,
          fontFamily: type.fontFamily,
          package: 'base_bloc_project',
          shadows: iconShadows,
        ),
      ),
    );

    return Semantics(
      label: semanticLabel,
      child: ExcludeSemantics(
        child: SizedBox(
          width: iconSize,
          height: iconSize,
          child: Center(
            child: iconWidget,
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IconDataProperty('icon', IconData(codePoint, fontFamily: type.fontFamily, fontPackage: 'base_bloc_project'), ifNull: '<empty>', showName: false));
    properties.add(DoubleProperty('size', size, defaultValue: null));
    properties.add(ColorProperty('color', color, defaultValue: null));
    properties.add(IterableProperty<Shadow>('shadows', shadows, defaultValue: null));
  }
}

class FontAwesomeIcon extends IconData {
  const FontAwesomeIcon(super.codePoint)
      : super(fontFamily: 'FontAwesomeSolid');

  const FontAwesomeIcon.solid(super.codePoint)
      : super(fontFamily: 'FontAwesomeSolid');

  const FontAwesomeIcon.sharpSolid(super.codePoint)
      : super(fontFamily: 'FontAwesomeSharpSolid');

  const FontAwesomeIcon.duoTone(super.codePoint)
      : super(fontFamily: 'FontAwesomeDuoTone');

  const FontAwesomeIcon.brand(super.codePoint)
      : super(fontFamily: 'FontAwesomeBrand');

  const FontAwesomeIcon.regular(super.codePoint)
      : super(fontFamily: 'FontAwesomeRegular');

  const FontAwesomeIcon.light(super.codePoint)
      : super(fontFamily: 'FontAwesomeLight');

  const FontAwesomeIcon.thin(super.codePoint)
      : super(fontFamily: 'FontAwesomeThin');
}
