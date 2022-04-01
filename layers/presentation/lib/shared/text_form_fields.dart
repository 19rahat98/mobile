import 'package:flutter/material.dart';

mixin AutoValidateMixin<T extends StatefulWidget> on State<T> {
  FocusNode? focusNode;
  late AutovalidateMode autovalidateMode;

  @override
  void initState() {
    super.initState();
    if (focusNode == null) {
      autovalidateMode = AutovalidateMode.onUserInteraction;
    } else {
      autovalidateMode = AutovalidateMode.disabled;
      focusNode!.addListener(() {
        if (!focusNode!.hasFocus) {
          setState(() {
            autovalidateMode = AutovalidateMode.onUserInteraction;
          });
        }
      });
    }
  }
}

class EmailTextFormField extends StatefulWidget {
  const EmailTextFormField({
    Key? key,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final TextInputAction? textInputAction;

  @override
  State<EmailTextFormField> createState() => _EmailTextFormFieldState();
}

class _EmailTextFormFieldState extends State<EmailTextFormField>
    with AutoValidateMixin {
  @override
  FocusNode? get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      decoration: const InputDecoration(
        labelText: 'Email',
      ),
      autofillHints: const {AutofillHints.email},
      keyboardType: TextInputType.emailAddress,
      autovalidateMode: autovalidateMode,
      textInputAction: widget.textInputAction,
      onEditingComplete: () {
        widget.nextFocusNode?.requestFocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your email';
        }

        if (!value.contains('@') || !value.contains('.')) {
          return 'Please enter a valid email';
        }

        return null;
      },
    );
  }
}

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    Key? key,
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.autoFocus = false,
    this.validator,
    this.label = 'Password',
    this.textInputAction,
  }) : super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool autoFocus;
  final String? Function(String)? validator;
  final String label;
  final TextInputAction? textInputAction;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField>
    with AutoValidateMixin {
  @override
  FocusNode? get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(
        labelText: widget.label,
      ),
      autofillHints: const {AutofillHints.password},
      keyboardType: TextInputType.visiblePassword,
      autocorrect: false,
      obscureText: true,
      textInputAction: widget.textInputAction,
      autovalidateMode: autovalidateMode,
      onEditingComplete: () {
        widget.nextFocusNode?.requestFocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your password';
        }

        if (widget.validator != null) {
          return widget.validator!(value);
        }

        if (value.length < 8) {
          return 'Password must be at least 8 characters';
        }

        return null;
      },
    );
  }
}

class NameTextFormField extends StatefulWidget {
  const NameTextFormField.first({
    Key? key,
    this.label = 'First Name',
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.autoFocus = false,
    this.textInputAction,
  })  : isLast = false,
        super(key: key);

  const NameTextFormField.last({
    Key? key,
    this.label = 'Last Name',
    this.controller,
    this.focusNode,
    this.nextFocusNode,
    this.autoFocus = false,
    this.textInputAction,
  })  : isLast = true,
        super(key: key);

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocusNode;
  final bool autoFocus;
  final String label;
  final bool isLast;
  final TextInputAction? textInputAction;

  @override
  State<NameTextFormField> createState() => _FirstNameTextFormFieldState();
}

class _FirstNameTextFormFieldState extends State<NameTextFormField>
    with AutoValidateMixin {
  @override
  FocusNode? get focusNode => widget.focusNode;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      autofocus: widget.autoFocus,
      decoration: InputDecoration(labelText: widget.label),
      autofillHints: widget.isLast
          ? const {AutofillHints.familyName}
          : const {AutofillHints.givenName},
      keyboardType: TextInputType.text,
      textInputAction: widget.textInputAction,
      autovalidateMode: autovalidateMode,
      onEditingComplete: () {
        widget.nextFocusNode?.requestFocus();
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter your first name';
        }

        return null;
      },
    );
  }
}
