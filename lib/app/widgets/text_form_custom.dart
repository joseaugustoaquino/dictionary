import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart' as il;

class TextFormCustom extends StatefulWidget {
  final TextEditingController? controller;
  final FormFieldValidator? validator;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final double borderRadius;
  final bool obscureText;
  final String? hintText;
  final String? labelText;
  final String? errorText;
  final Color? focusColor;
  final Color? hoverColor;
  final Color? fillColor;
  final Color? defocusColor;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextStyle? labelStyle;
  final EdgeInsetsGeometry? padding;
  final bool? enable;
  final ValueChanged<String>? onChange;
  final Function(String?)? onSaved;
  final String? initialValue;
  final bool visible;
  final bool clearButton;
  final bool clearButtonAlwaysShow;
  final int? maxLines;
  final bool? isLogin;
  final bool? readOnly;
  final TextCapitalization textCapitalization;
  final InputBorder? border;
  final EdgeInsetsGeometry? contentPadding;
  final Color? textStyleColor;
  final TextStyle? style;
  final bool autofocus;
  final TextDirection? textDirection;
  final TextAlign? textAlign;
  final Function()? onEditingComplete;
  final Function(String)? onFieldSubmitted;
  final AutovalidateMode? autovalidateMode;
  final Iterable<String>? autofillHints;
  final EdgeInsets? scrollPadding;
  final TextAlignVertical? textAlignVertical;

  const TextFormCustom({Key? key,
    this.textDirection,
    this.textAlign,
    this.onEditingComplete,
    this.onFieldSubmitted,
    this.autovalidateMode,
    this.autofillHints,
    this.scrollPadding,
    this.textAlignVertical, 
    this.labelStyle,
    
    this.isLogin,
    this.controller,
    this.autofocus = true,
    this.textStyleColor,
    this.contentPadding,
    this.textCapitalization = TextCapitalization.none,
    this.validator,
    this.style,
    this.border,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.borderRadius = 10.0,
    this.obscureText = false,
    this.labelText,
    this.hintText,
    this.errorText,
    this.focusColor,
    this.hoverColor,
    this.fillColor,
    this.defocusColor,
    this.prefixIcon,
    this.suffixIcon,
    this.padding,
    this.enable,
    this.onChange,
    this.onSaved,
    this.initialValue,
    this.visible = true,
    this.clearButton = false,
    this.maxLines = 1,
    this.clearButtonAlwaysShow = false, this.readOnly,
  }) : super(key: key);

  @override
  State<TextFormCustom> createState() => _TextFormCustomState();
}
class _TextFormCustomState extends State<TextFormCustom> {
  FocusNode _focusNode = FocusNode();
  late bool _passwordVisible;
  bool _focused = false;

  @override
  void initState() {
    _passwordVisible = widget.obscureText;

    super.initState();

    _focusNode = FocusNode(debugLabel: 'Button');
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus != _focused) {
      setState(() {
        _focused = _focusNode.hasFocus;
      });
    }
  }

  Widget _getSuffix(){
    if(widget.suffixIcon is Icon){
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Icon(
          (widget.suffixIcon as Icon).icon,
          color: Theme.of(context).primaryColor,
        ),
      );
    }

    if(widget.suffixIcon is IconButton){
      return Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: IconButton(
          focusColor: Colors.transparent,
          hoverColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(
            ((widget.suffixIcon as IconButton).icon as Icon).icon,
            color: Theme.of(context).primaryColor,
          ),

          onPressed: (widget.suffixIcon as IconButton).onPressed,
        ),
      );
    }

    return const SizedBox(width: 0, height: 0);
  }

  @override
  Widget build(BuildContext context) {
    final List<TextInputFormatter> formatters = widget.inputFormatters ?? <TextInputFormatter>[];

    return Visibility(
      visible: widget.visible,

      child: Padding(
        padding: (widget.padding ?? const EdgeInsets.fromLTRB(8.5, 5.0, 8.5, 5.0)),

        child: TextFormField(
          maxLines: widget.maxLines,
          textCapitalization: widget.textCapitalization,
          autofocus: widget.autofocus,
          readOnly: widget.readOnly ?? false,
          controller: widget.controller,
          validator: widget.validator,
          obscureText: (widget.obscureText ? _passwordVisible : widget.obscureText),
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          inputFormatters: formatters,
          enabled: (widget.enable ?? true),
          onChanged: widget.onChange,
          onSaved: widget.onSaved,
          style: widget.style ?? GoogleFonts.roboto(color: widget.textStyleColor ?? Colors.black),
          textDirection: widget.textDirection,
          textAlign: widget.textAlign ?? TextAlign.start,
          onEditingComplete: widget.onEditingComplete,
          onFieldSubmitted: widget.onFieldSubmitted,
          autovalidateMode: widget.autovalidateMode,
          autofillHints: widget.autofillHints,
          textAlignVertical: widget.textAlignVertical,
          scrollPadding: widget.scrollPadding ?? const EdgeInsets.all(20.0),
          initialValue: widget.controller != null ? null : widget.initialValue,

          decoration: InputDecoration(
            focusColor: (widget.focusColor ?? Theme.of(context).focusColor),
            hoverColor: (widget.hoverColor ?? Theme.of(context).primaryColor),
            fillColor: (widget.fillColor ?? Theme.of(context).primaryColor),
            contentPadding: widget.contentPadding ?? const EdgeInsets.only(left: 15.0),
            labelText: widget.labelText,
            labelStyle: widget.labelStyle ?? GoogleFonts.roboto(color: Colors.grey),
            hintText: widget.hintText,
            errorText: widget.errorText,
            prefixIcon: (widget.prefixIcon == null ? null : FocusScope(
              canRequestFocus: false,
              child: widget.prefixIcon!,
            )),

            suffixIcon: FocusScope(
              canRequestFocus: false,
              child: Padding(
                padding: const EdgeInsetsDirectional.only(end: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    (widget.obscureText ? Container(
                      padding: const EdgeInsets.all(0.0),
                      width: 40.0,
                      child: IconButton(
                        icon: Icon(
                          (_passwordVisible ? Icons.visibility_off : Icons.visibility),
                          color: Theme.of(context).primaryColor,
                        ), 
                        focusColor: Colors.transparent,
                        hoverColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ) : const SizedBox(width: 0, height: 0)),

                    _getSuffix(),
                  ],
                ),
              ),
            ),

            enabledBorder: widget.border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: (widget.focusColor ?? Theme.of(context).primaryColor)
              ),
            ),

            border: widget.border ?? OutlineInputBorder(
              borderRadius: BorderRadius.circular(widget.borderRadius),
              borderSide: BorderSide(
                color: (widget.defocusColor ?? Theme.of(context).primaryColor)
              ),
            ),
          ),
        ),
      ),
    );
  }
}
class CurrencyPtBrFormatter extends TextInputFormatter {
  CurrencyPtBrFormatter({this.maxDigits});
  final int? maxDigits;
  double? _uMaskValue;
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }
    if (maxDigits != null && newValue.selection.baseOffset > maxDigits!) {
      return oldValue;
    }
    String valueText = newValue.text.replaceAll("R\$", "").replaceAll(",", ".");
    double value = double.parse(valueText);
    final formatter = il.NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ ${formatter.format(value / 100)}";
    //setting the umasked value
    _uMaskValue = value / 100;
    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
  //here the method
  double? getUnmaskedDouble() {
    return _uMaskValue;
  }
}
class CurrencyInputFormatter extends TextInputFormatter {
   @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {

        if(newValue.selection.baseOffset == 0){
            return newValue;
        }

        double value = double.parse(newValue.text);

        final formatter = il.NumberFormat.simpleCurrency(locale: "pt_Br");

        String newText = formatter.format(value/100);

        return newValue.copyWith(
            text: newText,
            selection: TextSelection.collapsed(offset: newText.length));
  }
}
class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

/// WIDGET ///
InputDecoration bgInputDecoration({
  required BuildContext context,
  Widget? suffixIcon,
  Widget? prefixIcon,
  double borderRadius = 10,
  String? hintText,
  String? labelText,
  Color? focusColor,
  Color? hoverColor,
  Color? fillColor,
  Color? defocusColor,
  Color? disabledColor,
}) {
  return InputDecoration(
    hintText: hintText,
    labelText: labelText,
    fillColor: (fillColor ?? Theme.of(context).primaryColor),
    focusColor: (focusColor ?? Theme.of(context).focusColor),
    hoverColor: (hoverColor ?? Theme.of(context).primaryColor),
    contentPadding: const EdgeInsets.only(left: 15.0),

    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,

    disabledBorder: disabledColor == null ? null : OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: disabledColor
      ),
    ),

    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: (focusColor ?? Theme.of(context).primaryColor)
      ),
    ),

    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(borderRadius),
      borderSide: BorderSide(
        color: (defocusColor ?? Theme.of(context).primaryColor)
      ),
    ),
  );
}

Widget selectAutoComplete({
  required void Function()? onPressed,
  required bool enable,

  required String title,
  String? subtitle,
  Widget? leading,

  EdgeInsetsGeometry? padding,
  Color color = const Color(0xFF000000),
}) {
  return Padding(
    padding: padding ?? const EdgeInsets.fromLTRB(0, 5, 0, 5), 
    child: Container(
      decoration: BoxDecoration(
        color: Colors.transparent,
        border: Border.all(color: enable ? color : Colors.black12),
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: ListTile(
        dense: true,
        leading: leading,
        visualDensity: VisualDensity.comfortable,

        title: Text(
          title.toUpperCase(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: subtitle == null ? FontWeight.normal : FontWeight.w700
          ),
        ),

        subtitle: subtitle == null ? null : Text(
          subtitle.toUpperCase(),
          style: const TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),

        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, size: 22),
          color: enable ? color : Colors.black12,
          onPressed: onPressed,
        ),
      ),
    ),
  );
}