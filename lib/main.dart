import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/MainBlocDelegate.dart';
import 'package:habit/screens/splash_screen.dart';
import 'package:habit/bloc/authentication_bloc/bloc.dart';
import 'package:habit/repository/repositories.dart';

void main () {
  WidgetsFlutterBinding.ensureInitialized();
  BlocSupervisor.delegate = SimpleBlocDelegate();

  final UserRepository userRepository = UserRepository();
  runApp(
    BlocProvider(
      create: (context) => AuthenticationBloc(userRepository: userRepository)
        ..add(AppStarted()),
      child: App(userRepository: userRepository,),
    )
  );
}

class App extends StatelessWidget {
  final UserRepository _userRepository;

  App({Key key, @required UserRepository userRepository})
      : assert(userRepository != null),
        _userRepository = userRepository,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Color.fromRGBO(229, 229, 229, 1),
        primaryColor: Color.fromRGBO(245, 112, 58, 1),
        primaryColorDark: Color.fromRGBO(40, 42, 53, 1,),
        accentColor: Color.fromRGBO(255, 242, 208, 1),
        fontFamily: 'CircularStd',
      ),
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is Uninitialized) {
            return SplashScreen();
          }
          return Container();
        },
      ),
    );
  }
}

