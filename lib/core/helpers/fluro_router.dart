import 'dart:developer';

import 'package:biz_card/features/authModule/screens/login_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

import '../../features/authModule/screens/sign_up_screen.dart';

class FluroRoute {
  static FluroRouter fluroRouter = FluroRouter();

  static var loginHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const LoginScreen();
  });

  static var signUpHandler = Handler(
      handlerFunc: (BuildContext? context, Map<String, dynamic> params) {
    return const SignUpScreen();
  });

  static initRoute() {
    fluroRouter.define("/",
        handler: loginHandler, transitionType: TransitionType.cupertino);
    fluroRouter.define("/signUp",
        handler: signUpHandler, transitionType: TransitionType.cupertino);
  }
}

class Path {
  const Path(this.pattern, this.builder);

  final String pattern;
  final Widget Function(BuildContext, String) builder;
}

class RouteConfiguration {
  static List<Path> paths = [
    Path(
      r'^/article/([\w-]+)$',
      (context, match) => Article.getArticlePage(match),
    ),
    Path(
      r'^' + RouteNames.overviewRoute,
      (context, match) => OverviewPage(
        id: match,
      ),
    ),
    Path(
      r'^' + RouteNames.userPage,
      (context, match) => Users.getUserPage(match),
    ),
    Path(
      r'^' + RouteNames.home,
      (context, match) => const HomePageMain(),
    ),
  ];

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    for (Path path in paths) {
      final regExpPattern = RegExp(path.pattern);
      if (regExpPattern.hasMatch(settings.name.toString())) {
        final firstMatch = regExpPattern.firstMatch(settings.name.toString());
        final match =
            (firstMatch?.groupCount == 1) ? firstMatch?.group(1) : null;
        return MaterialPageRoute<void>(
          builder: (context) => path.builder(context, match.toString()),
          settings: settings,
        );
      }
    }
    // If no match is found, [WidgetsApp.onUnknownRoute] handles it.
    return null;
  }
}

const List<Article> articles = [
  Article(
    title: 'A very interesting article',
    slug: 'a-very-interesting-article',
  ),
  Article(
    title: 'Newsworthy news',
    slug: 'newsworthy-news',
  ),
  Article(
    title: 'RegEx is cool',
    slug: 'regex-is-cool',
  ),
];

class Article {
  const Article({required this.title, required this.slug});

  final String title;
  final String slug;

  static Widget getArticlePage(String slug) {
    for (Article article in articles) {
      if (article.slug == slug) {
        return ArticlePage(article: article);
      }
    }
    return const UnknownArticle();
  }
}

class Users {
  const Users({required this.title, required this.slug});

  final String title;
  final String slug;

  static Widget getUserPage(String slug) {
    if (slug.isNotEmpty) {
      return const UserPage();
    }
    return const UnknownArticle();
  }
}

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, required this.article}) : super(key: key);

  static String Function(String slug) routeFromSlug =
      (String slug) => '${RouteNames.articleBaseRoute}/$slug';

  final Article article;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(article.title),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class UserPage extends StatelessWidget {
  const UserPage({
    Key? key,
  }) : super(key: key);

  static String Function(String slug) routeFromSlug =
      (String slug) => '${RouteNames.userPage}/$slug';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("user profile"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("user data "),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class UnknownArticle extends StatelessWidget {
  const UnknownArticle({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unknown article'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Unknown article'),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewPage extends StatelessWidget {
  final String? id;
  const OverviewPage({super.key, this.id});

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    log("Arguments Data : ${arguments['id']}");
    return Scaffold(
      appBar: AppBar(
        title: Text('Overview Page user id :${arguments['id']}'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Article article in articles)
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    ArticlePage.routeFromSlug(article.slug),
                  );
                },
                child: Text(article.title),
              ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed(
                  UserPage.routeFromSlug("amirnazir"),
                );
              },
              child: const Text("go to user profile"),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate back to the home screen by popping the current route
                // off the stack.
                Navigator.pop(context);
              },
              child: const Text('Go back!'),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageMain extends StatelessWidget {
  const HomePageMain({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Overview page'),
          onPressed: () {
            // Navigate to the overview page using a named route.
            Navigator.pushNamed(context, RouteNames.overviewRoute,
                arguments: {'id': "amirnazirchachar"});
          },
        ),
      ),
    );
  }
}

///
class RoutingApp extends StatelessWidget {
  const RoutingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Custom Named Routes Example',
      debugShowCheckedModeBanner: false,
      initialRoute: RouteNames.home,
      onGenerateRoute: RouteConfiguration.onGenerateRoute,
    );
  }
}

class RouteNames {
  static const String home = '/';
  static const String overviewRoute = '/overview';
  static const String articleBaseRoute = '/article';
  static const String userPage = '/userProfile';
}
