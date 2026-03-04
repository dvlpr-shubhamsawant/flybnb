import 'package:flutter/material.dart';
import 'package:flybnb/constant/global.dart';
import 'package:flybnb/constant/router_path.dart';
import 'package:flybnb/pages/auth/login_page.dart';
import 'package:flybnb/pages/booking_success_page/booking_success_page.dart';
import 'package:flybnb/pages/flight_detail/flight_detail_page.dart';
import 'package:flybnb/pages/flight_listing/flight_listing_page.dart';
import 'package:flybnb/pages/flight_search/flight_search_page.dart';
import 'package:flybnb/pages/splash/splash_page.dart';
import 'package:go_router/go_router.dart';

class Routers {
  static final GoRouter router = GoRouter(
    initialLocation: "/",
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: "/",
        name: RouterPath.splash.name,
        pageBuilder: (context, state) => fadeScreen(state, SplashPage()),
      ),
      GoRoute(
        path: "/login",
        name: RouterPath.login.name,
        pageBuilder: (context, state) => fadeScreen(state, LoginPage()),
      ),
      GoRoute(
        path: "/flightsearch",
        name: RouterPath.flightsearch.name,
        pageBuilder: (context, state) => fadeScreen(state, FlightSearchPage()),
        routes: [
          GoRoute(
            path: "flightlisting",
            name: RouterPath.flightlisting.name,
            pageBuilder: (context, state) =>
                fadeScreen(state, FlightListingPage()),
          ),
          GoRoute(
            path: "flightdetails",
            name: RouterPath.flightdetails.name,
            pageBuilder: (context, state) =>
                fadeScreen(state, FlightDetailPage()),
            routes: [
              /// BOOKING SUCCESS
              GoRoute(
                path: "bookingsuccess",
                name: RouterPath.bookingsuccess.name,
                pageBuilder: (context, state) =>
                    fadeScreen(state, BookingSuccessPage()),
              ),
            ],
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage<dynamic> fadeScreen(
    GoRouterState state,
    Widget screen,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: screen,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final fadeTween = Tween<double>(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut));

        return FadeTransition(
          opacity: animation.drive(fadeTween),
          child: child,
        );
      },
    );
  }
}
