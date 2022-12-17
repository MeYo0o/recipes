import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/app_state_manager.dart';
import '../models/grocery_manager.dart';
import '../models/profile_manager.dart';
import '../screens/screens.dart';

class AppRouter {
  final AppStateManager appStateManager;
  final ProfileManager profileManager;
  final GroceryManager groceryManager;

  AppRouter(
    this.appStateManager,
    this.profileManager,
    this.groceryManager,
  );

  late final router = GoRouter(
    debugLogDiagnostics: true,
    refreshListenable: appStateManager,
    initialLocation: LoginScreen.route,
    routes: [
      GoRoute(
        name: 'login',
        path: LoginScreen.route,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: 'onboarding',
        path: OnboardingScreen.route,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: 'home',
        // 1
        path: '/:tab',
        builder: (context, state) {
          // 2
          final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;
          // 3
          return Home(
            key: state.pageKey,
            currentTab: tab,
          );
        },
        // 3
        routes: [
          GoRoute(
            name: 'item',
            path: 'item/:id',
            builder: (context, state) {
              final itemId = state.params['id'] ?? '';

              final item = groceryManager.getGroceryItem(itemId);

              return GroceryItemScreen(
                originalItem: item,
                onCreate: (item) {
                  groceryManager.addItem(item);
                },
                onUpdate: (item) {
                  groceryManager.updateItem(item);
                },
              );
            },
          ),
          GoRoute(
            name: 'profile',
            path: 'profile',
            builder: (context, state) {
              final tab = int.tryParse(state.params['tab'] ?? '') ?? 0;

              return ProfileScreen(
                user: profileManager.getUser,
                currentTab: tab,
              );
            },
            routes: [
              GoRoute(
                name: 'rw',
                path: 'rw',
                builder: (context, state) => const WebViewScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorPageBuilder: (context, state) {
      return MaterialPage(
        key: state.pageKey,
        child: Scaffold(
          body: Center(
            child: Text(
              state.error.toString(),
            ),
          ),
        ),
      );
    },
    redirect: (state) {
      //Login handle redirection
      final loggedIn = appStateManager.isLoggedIn;
      final atLoginScreen = state.subloc == LoginScreen.route;
      if (!loggedIn) return atLoginScreen ? null : LoginScreen.route;

      //Onboarding handle redirection
      final isOnboardingComplete = appStateManager.isOnboardingComplete;
      final atOnboardingScreen = state.subloc == OnboardingScreen.route;
      if (!isOnboardingComplete) {
        return atOnboardingScreen ? null : OnboardingScreen.route;
      }

      //Home handle redirection
      if (atLoginScreen || atOnboardingScreen) {
        return '/${FooderlichTab.explore}';
      }

      //Default Redirection
      return null;
    },
  );
}
