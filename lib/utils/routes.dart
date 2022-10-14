import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/screens/auth/login_screen.dart';
import 'package:sample_app/screens/auth/register_screen.dart';
import 'package:sample_app/screens/main_screen.dart';

import 'package:sample_app/screens/products/view_single_product.dart';

import '../screens/home_screen.dart';

GoRouter routes = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return MainScreen();
      },
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return LoginScreen();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterScreen();
      },
    ),
    GoRoute(
      path: '/product',
      builder: (BuildContext context, GoRouterState state) {
        return ProductPage();
      },
    ),
  ],
);
