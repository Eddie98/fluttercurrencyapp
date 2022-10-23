import 'package:flutter/widgets.dart';

import 'ui/pages/auth/auth.dart';
import 'ui/pages/home/home.dart';

class Routes {
  static const String mainLink = '/';
  static const String homeLink = '/home';
  static const String authLink = '/auth';

  static Route<T> fadeThrough<T>(
    WidgetBuilder page, {
    RouteSettings? settings,
    int duration = 200,
  }) {
    return PageRouteBuilder<T>(
      settings: settings,
      transitionDuration: Duration(milliseconds: duration),
      pageBuilder: (context, animation, secondaryAnimation) => page(context),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    return fadeThrough((context) {
      if (settings.name == homeLink) {
        return const HomePage();
      }
      if (settings.name == authLink) {
        final Map<String, bool>? args =
            (settings.arguments as Map<String, bool>?);
        return AuthPage(
          isShowPeanutAuthPage:
              args != null ? args['isShowPeanutAuthPage']! : true,
          isShowPartnerAuthPage:
              args != null ? args['isShowPartnerAuthPage']! : true,
        );
      }
      return Container();
    }, settings: settings);
  }
}
