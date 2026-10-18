import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/responsive.dart';
import 'app_button.dart';

/// Form input nama beserta tombol mulai.
///
/// StatefulWidget karena memegang [TextEditingController] dan [FormState]
/// yang harus dibuang (dispose) dan dipertahankan selama widget hidup.
class NameField extends StatefulWidget {
  const NameField({
    super.key,
    required this.onSubmit,
    this.buttonLabel = 'Mulai Kuis',
  });

  /// Dipanggil dengan nama yang sudah valid dan dipangkas.
  final ValueChanged<String> onSubmit;
  final String buttonLabel;

  @override
  State<NameField> createState() => _NameFieldState();
}

class _NameFieldState extends State<NameField> {
  final _formKey = GlobalKey<FormState>();
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String? _validate(String? value) {
    final name = value?.trim() ?? '';
    if (name.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    if (name.length < 2) {
      return 'Nama minimal 2 karakter';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      widget.onSubmit(_controller.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _controller,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.done,
            inputFormatters: [LengthLimitingTextInputFormatter(30)],
            validator: _validate,
            onFieldSubmitted: (_) => _submit(),
            decoration: InputDecoration(
              labelText: 'Nama kamu',
              hintText: 'Contoh: Budi Santoso',
              prefixIcon: const Icon(Icons.person_outline),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(context.radius),
              ),
            ),
          ),
          SizedBox(height: context.gapM),
          AppButton(
            label: widget.buttonLabel,
            icon: Icons.play_arrow_rounded,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}
