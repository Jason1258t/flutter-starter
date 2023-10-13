// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:starter/utils/utils.dart';

class BaseTextFormField extends StatefulWidget {
  const BaseTextFormField(
      {Key? key,
      required this.controller,
      required this.keyboardType,
      this.height = 70,
      this.width = double.infinity,
      this.padding = const EdgeInsets.all(10),
      this.maxLines = 1,
      this.hintText = '',
      this.obscureText = false,
      this.suffixIcon,
      this.onChange,
      this.error = false})
      : super(key: key);

  final TextEditingController controller;
  final TextInputType keyboardType;
  final double height;
  final double width;
  final EdgeInsets padding;
  final int maxLines;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final Function(String?)? onChange;
  final bool error;

  @override
  State<BaseTextFormField> createState() => _BaseTextFormFieldState();
}

class _BaseTextFormFieldState extends State<BaseTextFormField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      width: widget.width,
      child: Padding(
        padding: widget.padding,
        child: TextFormField(
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          autofocus: false,
          obscureText: widget.obscureText,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
            hintStyle:
                AppTypography.font16w400.copyWith(color: AppColors.border),
            suffixIcon: widget.suffixIcon,
            hintText: widget.hintText,
            //label: widget.controller.text != '' ? Text(widget.hintText) : null,
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              borderSide: BorderSide(
                color: widget.error ? AppColors.error : AppColors.border,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(12.0),
              ),
              borderSide: BorderSide(
                color: widget.error ? AppColors.error : AppColors.border,
              ),
            ),
          ),
          style: AppTypography.font16w400.copyWith(color: Colors.black),
          onChanged: widget.onChange,
          controller: widget.controller,
        ),
      ),
    );
  }
}
