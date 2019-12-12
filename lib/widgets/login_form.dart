import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:habit/bloc/authentication_bloc/authentication_bloc.dart';
import 'package:habit/bloc/authentication_bloc/authentication_event.dart';
import 'package:habit/bloc/login/bloc.dart';
import 'package:habit/repository/repositories.dart';

class LoginForm extends StatefulWidget {
  final UserRepository _userRepository;

  LoginForm({Key key, @required UserRepository userRepository}) : assert(userRepository != null), _userRepository = userRepository, super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  UserRepository get _userRepository => widget._userRepository;

  bool get isPopulated => _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Login Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('Logging In...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            child: Form(
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(top: 80, bottom: 100,),
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 225),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  'Get',
                                  style: Theme.of(context).textTheme.title,
                                ),
                                Text(
                                  'the habits',
                                  style: Theme.of(context).textTheme.title.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Center(
                      child: Container(
                        constraints: BoxConstraints(
                          minWidth: 225,
                        ),
                        child: Text(
                          'Sign in',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      )
                    ),
                  ),
                  SizedBox(height: 40,),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                minWidth: 61,
                              ),
                              child: Text(
                                'Email',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColorDark.withOpacity(0.7),
                                ),
                              ),
                            ),
                            SizedBox(width: 28,),
                            Expanded(
                              child: TextFormField(
                                controller: _emailController,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10,),
                                  hintText: 'Type here...',
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  )
                                ),
                                autovalidate: false,
                                autocorrect: false,
                                validator: (_) {
                                  return !state.isEmailValid ? 'Invalid Email' : null;
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              constraints: BoxConstraints(
                                minWidth: 61,
                              ),
                              child: Text(
                                'Password',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Theme.of(context).primaryColorDark.withOpacity(0.7),
                                ),
                              ),
                            ),
                            SizedBox(width: 28,),
                            Expanded(
                              child: TextFormField(
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  hintText: 'Type here...',
                                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 10,),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Theme.of(context).primaryColorDark),
                                  )
                                ),
                                obscureText: true,
                                autovalidate: false,
                                autocorrect: false,
                                validator: (_) {
                                  return !state.isPasswordValid ? 'Invalid Password' : null;
                                },
                              ),
                            ),
                            Container(
                              width: 94,
                              padding: EdgeInsets.symmetric(vertical: 8.5),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(color: Theme.of(context).primaryColorDark)
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: EdgeInsets.symmetric(vertical: 8.5),
                                    child: Text(
                                      'forget password?',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context).primaryColorDark.withOpacity(0.6),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 225),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Sign in with',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Theme.of(context).primaryColorDark.withOpacity(0.5),
                            ),
                          ),
                          SizedBox(height: 15,),
                          Row(
                            children: <Widget>[
                              Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () {},
                                  child: SvgPicture.asset('assets/google.svg'),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text,),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
        PasswordChanged(password: _passwordController.text,),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
