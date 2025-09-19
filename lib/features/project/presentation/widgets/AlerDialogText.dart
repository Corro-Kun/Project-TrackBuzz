import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:trackbuzz/utils/l10n/app_localizations.dart';

class Alerdialogtext extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function() save;
  final TextInputType? keyboardType;

  const Alerdialogtext({
    super.key,
    required this.title,
    required this.controller,
    required this.save,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);

    return AlertDialog(
      title: Center(child: Text(title)),
      content: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20),
          child: Column(
            children: [
              TextField(
                controller: controller,
                keyboardType: keyboardType ?? TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                      width: 1,
                    ),
                  ),
                ),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  save();
                  Navigator.pop(context);
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 1,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      loc?.translate('accept') ?? 'Accept',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
