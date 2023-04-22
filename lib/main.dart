import 'package:fake_store/data/model/user_cart.dart';
import 'package:fake_store/data/response/product_response.dart';
import 'package:fake_store/screen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'data/bloc/UserBloc/user_bloc.dart';
import 'data/bloc/cart_bloc/cart_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //init firebase
  await Firebase.initializeApp();

  //init Hive

  await Hive.initFlutter();
  // await Hive.close();

  Hive.registerAdapter(ProductAdapter());
  Hive.registerAdapter(RateAdapter());
  Hive.registerAdapter(UserCartAdapter());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UserBloc(),
        ),
        BlocProvider(
          create: (context) => CartBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Fake Store',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
              backgroundColor: Colors.deepPurple.shade50,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.black),
              centerTitle: false,
              titleTextStyle: GoogleFonts.poppins(color: Colors.black, fontSize: 22)),
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: Colors.deepPurple.shade50,
          textTheme: GoogleFonts.poppinsTextTheme(),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
