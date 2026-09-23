import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tatbiqa/core/helper/spacer.dart';
import 'package:tatbiqa/core/style/app_color.dart';
import 'package:tatbiqa/core/style/textstyles.dart';

class CustomTextFormField extends StatefulWidget {
  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
    this.focusNode,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.onSubmitted,
    this.onTap,
    this.suffixIcon,
    this.onSuffixTap,
    this.suffixTooltip,
    this.isPassword = false,
    this.showPasswordCopyIcon = true,
    this.isRequired = false,
    this.enabled = true,
    this.readOnly = false,
    this.maxLines = 1,
    this.minLines,
    this.maxLength,
    this.textDirection = TextDirection.rtl,
    this.autofillHints,
    this.autovalidateMode = AutovalidateMode.disabled,
    this.prefixIcon,
    this.obscureText = false,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextStyle? labelStyle; 
  final TextStyle? hintStyle; 

  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  final List<TextInputFormatter>? inputFormatters;
  final FormFieldValidator<String>? validator;

  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? suffixTooltip;

  final bool isPassword;
  final bool showPasswordCopyIcon;
  final bool isRequired;
  final bool enabled;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final int? minLines;
  final int? maxLength;

  final TextDirection textDirection;
  final Iterable<String>? autofillHints;
  final AutovalidateMode autovalidateMode;

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  final GlobalKey<FormFieldState<String>> _fieldKey =
      GlobalKey<FormFieldState<String>>();

  bool _skipNextValidation = false;

  OutlineInputBorder _buildBorder({
    required Color color,
    required double width,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(color: color, width: width.w),
    );
  }

  String? _validate(String? value) {
    if (_skipNextValidation) {
      _skipNextValidation = false;
      return null;
    }

    final text = value?.trim() ?? '';

    if (widget.isRequired && text.isEmpty) {
      return 'هذا الحقل مطلوب';
    }

    return widget.validator?.call(value);
  }

  void _clearValidationError() {
    final fieldState = _fieldKey.currentState;

    if (fieldState == null || !fieldState.hasError) {
      return;
    }

    _skipNextValidation = true;
    fieldState.validate();
  }

  void _handleTap() {
    _clearValidationError();
    widget.onTap?.call();
  }

  void _handleChanged(String value) {
    _clearValidationError();
    widget.onChanged?.call(value);
  }

  Widget? _buildSuffixIcon() {
    Widget? icon;
    VoidCallback? onTap;
    String? tooltipMessage;

    if (widget.suffixIcon != null) {
      icon = widget.suffixIcon;
      onTap = widget.onSuffixTap ;
      tooltipMessage = widget.suffixTooltip;
    } else if (widget.isPassword && widget.showPasswordCopyIcon) {
      icon = Icon(
        Icons.copy_rounded,
        color: ColorPalette.gray,
        size: 20.sp,
      );
      onTap = widget.onSuffixTap ;
      tooltipMessage = widget.suffixTooltip ;
    }

    if (icon == null) {
      return null;
    }

    Widget suffixWidget;

    if (onTap == null) {
      suffixWidget = Padding(padding: EdgeInsets.all(12.r), child: icon);
    } else {
      suffixWidget = InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(padding: EdgeInsets.all(12.r), child: icon),
      );
    }

    if (tooltipMessage == null) {
      return suffixWidget;
    }

    return Tooltip(message: tooltipMessage, child: suffixWidget);
  }

  @override
  Widget build(BuildContext context) {
    final currentTheme = Theme.of(context);
    final errorColor = ColorPalette.error;

    final textField = Theme(
      data: currentTheme.copyWith(
        colorScheme: currentTheme.colorScheme.copyWith(
          primary: ColorPalette.primary,
          surface: ColorPalette.blackColor,
          onSurface: ColorPalette.whiteColor,
        ),
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: ColorPalette.primary,
          selectionColor: ColorPalette.primary.withOpacity(0.3),
          selectionHandleColor: ColorPalette.primary,
        ),
      ),
      child: Directionality(
        textDirection: widget.textDirection,
        child: TextFormField(
          key: _fieldKey,
          controller: widget.controller,
          focusNode: widget.focusNode,
          obscureText: widget.obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: widget.inputFormatters,
          enabled: widget.enabled,
          readOnly: widget.readOnly,
          maxLines: widget.maxLines,
          minLines: widget.minLines,
          maxLength: widget.maxLength,
          textAlign: TextAlign.right,
          textDirection: widget.textDirection,
          cursorColor: ColorPalette.primary,
          autofillHints: widget.autofillHints,
          autovalidateMode: widget.autovalidateMode,
          style: AppTextStyle.fontReadexPro14MediumWhiteColor,
          validator: _validate,
          onTap: _handleTap,
          onChanged: _handleChanged,
          onFieldSubmitted: widget.onSubmitted,
          decoration: InputDecoration(
            prefixIcon: widget.prefixIcon,
            hintText: widget.hintText,
            hintStyle: widget.hintStyle ??
                AppTextStyle.fontReadexPro14RegularWhiteColor,
              
            filled: true,
            fillColor: const Color(0xFF130F1F),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 14.h,
            ),
            suffixIcon: _buildSuffixIcon(),
            enabledBorder: _buildBorder(
              color: Colors.white.withOpacity(0.1),
              width: 1,
            ),
            focusedBorder: _buildBorder(
              color: ColorPalette.primary,
              width: 1.5,
            ),
            disabledBorder: _buildBorder(
              color: Colors.white.withOpacity(0.05),
              width: 1,
            ),
            errorBorder: _buildBorder(color: errorColor, width: 1),
            focusedErrorBorder: _buildBorder(color: errorColor, width: 1.5),
          ),
        ),
      ),
    );

    if (widget.labelText == null || widget.labelText!.trim().isEmpty) {
      return textField;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          widget.labelText!,
          textAlign: TextAlign.right,
          textDirection: TextDirection.rtl,
          style: widget.labelStyle ??
              AppTextStyle.fontReadexPro12MediumGrayColor
        ),
        verticalSpace(6),
        textField,
      ],
    );
  }
}