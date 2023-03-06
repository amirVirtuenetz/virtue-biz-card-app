import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class AppTextField extends StatelessWidget {
  //  CustomTextField();

  const AppTextField({
    Key? key,
    this.width,
    this.height,
    this.placeHolder,
    this.borderColor,
    this.borderRadius,
    this.keyboardType,
    this.controller,
    required this.onChangeText,
    this.prefixIcon,
    this.prefixImage,
    this.suffixIcon,
    this.isPrefixEnabled,
    this.isSuffixEnabled,
    this.obscureText,
    this.changeObscureText,
    this.autoFillHints,
    this.autoValidateMode,
    this.enableBorder = false,
    this.fillColor,
    this.autoFocus,
    this.focusNode,
    this.errorText,
    this.onTap,
    this.textInputAction,
    this.textInputFormatter,
    required this.onSubmit,
    this.onEditingComplete,
    this.isSuffixIconWidget = false,
    this.suffixWidget,
    this.onPrefixTap,
    this.prefixIconDatColor,
    this.prefixIconSize,
  }) : super(key: key);

  final FocusNode? focusNode;
  final bool? autoFocus;
  final ValueChanged<String> onChangeText;
  final ValueChanged<String> onSubmit;
  final void Function()? onEditingComplete;
  final String? placeHolder;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? borderRadius;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? textInputFormatter;
  final IconData? prefixIcon;
  final String? prefixImage;
  final String? suffixIcon;
  final bool? obscureText;
  final VoidCallback? changeObscureText;
  final void Function()? onPrefixTap;
  final TextEditingController? controller;
  final bool? isSuffixEnabled;
  final bool? isPrefixEnabled;
  final List<String>? autoFillHints;
  final AutovalidateMode? autoValidateMode;
  final bool? enableBorder;
  final Color? fillColor;
  final String? errorText;
  final void Function()? onTap;
  final bool? isSuffixIconWidget;
  final Widget? suffixWidget;
  final Color? prefixIconDatColor;
  final double? prefixIconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      // mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        TextFormField(
          // cursorHeight: 20,
          onTap: onTap,
          focusNode: focusNode,
          autofocus: autoFocus ?? false,
          autofillHints: autoFillHints,
          autovalidateMode: autoValidateMode,
          textAlign: TextAlign.start,
          cursorColor: Colors.black,
          // cursorHeight: 15,
          // cursorWidth: 2,
          // cursorRadius: const Radius.circular(500),
          controller: controller,
          obscureText: obscureText ?? false,
          keyboardType: keyboardType ?? TextInputType.text,
          textInputAction: textInputAction,
          inputFormatters: textInputFormatter,
          onChanged: onChangeText,
          onFieldSubmitted: onSubmit,
          onEditingComplete: onEditingComplete,
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(
            // height: 1,
            fontSize: 16,
            fontFamily: 'InterRegular',
            // color: const Color(0XFF111827),
          ),
          decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 5,
              ),
              hintText: placeHolder ?? '',
              alignLabelWithHint: true,
              // hintMaxLines: 1,
              hintStyle: const TextStyle(
                fontSize: 16,
                // height: 1.4,
                fontFamily: "InterRegular",
                fontWeight: FontWeight.w400,
              ),
              filled: true,
              isDense: false,
              fillColor: fillColor,
              prefixIconConstraints: isPrefixEnabled == false
                  ? const BoxConstraints(
                      minWidth: 45,
                      minHeight: 35,
                      maxWidth: 50,
                      maxHeight: 35,
                      // Align the icon and the text vertically.
                    )
                  : const BoxConstraints(
                      minWidth: 45,
                      minHeight: 35,
                      maxWidth: 50,
                      maxHeight: 35,
                    ),
              prefixIcon: isPrefixEnabled == true
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: prefixImage!.contains('svg')
                          ? SizedBox(
                              width: 30,
                              height: 30,
                              child: SvgPicture.asset(
                                prefixImage.toString(),
                                fit: BoxFit.contain,
                              ),
                            )
                          : SizedBox(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                prefixImage.toString(),
                                fit: BoxFit.contain,
                              ),
                            ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 9),
                      child: Icon(
                        prefixIcon,
                        color: prefixIconDatColor ?? Colors.black,
                        size: prefixIconSize ?? 20,
                      ),
                    ),
              suffixIconConstraints: isSuffixEnabled == false
                  ? const BoxConstraints(maxWidth: 0)
                  : const BoxConstraints(
                      maxWidth: 60,
                    ),
              suffixIcon: isSuffixIconWidget == true
                  ? suffixWidget
                  : isSuffixEnabled == true
                      ? IconButton(
                          onPressed: changeObscureText,
                          icon: suffixIcon.toString().contains('svg')
                              ? SvgPicture.asset(
                                  suffixIcon.toString(),
                                  fit: BoxFit.cover,
                                  width: 20,
                                )
                              : Image.asset(
                                  suffixIcon.toString(),
                                  color: obscureText == true
                                      ? const Color(0xFF807A7A)
                                      : const Color(0xFFDD9966),
                                  width: 20,
                                ),
                        )
                      : const SizedBox.shrink(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 12),
                ),
                borderSide: BorderSide(
                    width: borderColor != null ? 1 : 0,
                    color: borderColor ?? Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 12),
                ),
                borderSide: BorderSide(
                  width: borderColor != null ? 1 : 0,
                  color: const Color(0xff111827).withOpacity(0.2),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius ?? 12),
                ),
                borderSide: BorderSide(
                    width: borderColor != null ? 1 : 0,
                    color: borderColor ?? Colors.white),
              )

              // fillColor: Colors.yellow
              ),
        ),
        errorText == null
            ? const SizedBox.shrink()
            : Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                child: Text(
                  '$errorText',
                  style: const TextStyle(
                    color: Colors.red,
                    fontSize: 16,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
      ],
    );
  }
}
