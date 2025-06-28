import 'package:flutter/material.dart';
import 'package:news_app/utils/extensions/context_extension.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        actions: const [
          Text("11 July, 2020"),
          SizedBox(width: 15),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: context.screenWidth * 0.1,
          vertical: context.screenHeight * 0.05,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Hey, James!',
                style: Theme.of(context)
                    .textTheme
                    .titleSmall,
              ),
              Text(
                'Discover Latest News',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge
                    ?.copyWith(fontWeight: FontWeight.w900),
              ),
              SearchBar(
                elevation: WidgetStateProperty.all(0),
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
