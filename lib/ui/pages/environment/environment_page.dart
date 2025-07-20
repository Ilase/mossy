import 'package:flutter/material.dart';

class EnvironmentPage extends StatefulWidget {
  const EnvironmentPage({super.key});

  @override
  State<EnvironmentPage> createState() => _EnvironmentPageState();
}

class _EnvironmentPageState extends State<EnvironmentPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: Icon(Icons.g_mobiledata),
          title: Text('Global'),
          onTap: () {},
          style: ListTileStyle.drawer,
        ),
        Divider(),
        Expanded(
          child: ListView.builder(
            itemCount: 4,
            itemBuilder: (context, index) {
              bool isActive = false;
              return ListTile(
                onTap: () {},
                title: Text('Env $index'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          isActive = !isActive;
                        });
                      },
                      icon: Icon(
                        Icons.check_circle_outline,
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
