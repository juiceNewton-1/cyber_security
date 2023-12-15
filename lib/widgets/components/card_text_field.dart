import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  final String? prefix;
  final String hint;
  final int maxLength;
  final List<TextInputFormatter>? formatters;
  const CardTextField({
    super.key,
    required this.textEditingController,
    required this.maxLength,
    this.formatters,
    this.prefix,
    this.onChanged,
    required this.hint,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      inputFormatters: formatters,
      controller: textEditingController,
      keyboardType: TextInputType.number,
      onChanged: onChanged,
      maxLength: maxLength,
      style: Theme.of(context).textTheme.displaySmall,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(top: 5, left: 10),
        counterText: '',
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: Color(0xFF939393),
            ),
        prefixIcon: prefix != null
            ? Padding(
                padding: EdgeInsets.only(left: 10, top: 7),
                child: Text(
                  prefix!,
                  style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: Color(0xFF939393),
                      ),
                ),
              )
            : null,
        constraints: BoxConstraints(maxHeight: 36),
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide:
              BorderSide(color: Theme.of(context).colorScheme.secondary),
        ),
      ),
    );
  }
}
