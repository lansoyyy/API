import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sample_app/screens/auth/login_screen.dart';
import 'package:sample_app/screens/auth/register_screen.dart';
import 'package:sample_app/screens/home_screen.dart';
import 'package:sample_app/screens/products/product_screen.dart';
import 'package:get_storage/get_storage.dart';

GoRouter routes = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        final box = GetStorage();
        if (box.read("token") == "") {
          return LoginPage();
        } else {
          return LoginPage();
        }
      },
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/signup',
      builder: (BuildContext context, GoRouterState state) {
        return RegisterPage();
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
