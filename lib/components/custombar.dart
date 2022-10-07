import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.title, this.onInvoke});

  final String title;
  final void Function()? onInvoke;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xfff1a13f),
      foregroundColor: Colors.black,
      centerTitle: true,
      title: Text(title),
      actions: onInvoke == null
          ? []
          : [
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  if (onInvoke != null) {
                    onInvoke!();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Сохранено в файл"),
                    ));
                  }
                },
              ),
            ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
