import 'package:flutter/material.dart';
import 'package:hadirio/utils/function.dart';

class ImageDialog extends StatelessWidget {
  const ImageDialog({super.key, required this.base64});

  final String base64;

  @override
  Widget build(BuildContext context) {
    final bytes = toImage(base64);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        child: bytes != null
            ? Image.memory(
                bytes,
              )
            : const SizedBox(
              height: 150,
                child: Center(
                  child: Icon(Icons.image_not_supported_outlined),
                ),
              ),
      ),
    );
  }
}
