import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habit/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:habit/bloc/authentication_bloc/authentication_event.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  BlocProvider.of<AuthenticationBloc>(context)..add(LoggedOut());
                },
                child: Text(
                  'Log out'
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
