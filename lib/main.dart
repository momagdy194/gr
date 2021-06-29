import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:untitled2/bloc/news/news_bloc.dart';
import 'package:untitled2/bloc/portfolio/portfolio_bloc.dart';
import 'package:untitled2/bloc/profile/profile_bloc.dart';
import 'package:untitled2/bloc/search/search_bloc.dart';
import 'package:untitled2/bloc/sector_performance/sector_performance_bloc.dart';

import 'package:untitled2/widgets/about/about.dart';
import 'package:untitled2/widgets/home.dart';
import 'package:untitled2/widgets/portfolio/portfolio.dart';

import 'Screens/Login/login_screen.dart';
import 'Screens/Signup/signup_screen.dart';
import 'Screens/Welcome/welcome_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<PortfolioBloc>(
          create: (context) => PortfolioBloc(PortfolioInitial()),
        ),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(ProfileInitial()),
        ),
        BlocProvider<SearchBloc>(
          create: (context) => SearchBloc(SearchInitial()),
        ),
        BlocProvider<SectorPerformanceBloc>(
          create: (context) =>
              SectorPerformanceBloc(SectorPerformanceInitial()),
        ),
        BlocProvider<NewsBloc>(
          create: (context) => NewsBloc(NewsInitial()),
        ),
      ],
      child: MaterialApp(
        title: 'Stock Market App',
        theme: ThemeData(brightness: Brightness.dark),

        debugShowCheckedModeBanner: false,
        // initialRoute: '/welcome',
        home: StockMarketAppHome(),
        routes: {
          '/about': (context) => AboutSection(),
          '/signup': (context) => SignUpScreen(),
          '/login': (context) => LoginScreen(),
          '/welcome': (context) => WelcomeScreen(),
        },
      )));
}
