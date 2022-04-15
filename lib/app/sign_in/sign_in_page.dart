import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_tracker_flutter/app/sign_in/email_sign_in.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_bloc.dart';
import 'package:time_tracker_flutter/app/sign_in/sign_in_button.dart';
import 'package:time_tracker_flutter/app/sign_in/social_sign_in_button.dart';
import 'package:time_tracker_flutter/services/auth.dart';
import 'package:time_tracker_flutter/widget/show_exception_alert_dialog.dart';

class SingInPage extends StatelessWidget {
  const SingInPage({Key? key, required this.bloc}) : super(key: key);
  final SignInBloc bloc;

  static Widget create(BuildContext context) {
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<SignInBloc>(
      create: (_) => SignInBloc(auth: auth),
      dispose: (_, bloc) => bloc.dispose(),
      child: Consumer<SignInBloc>(
        builder: (_, bloc, child) => SingInPage(bloc: bloc),
      ),
    );
  }

  void _showSignInError(BuildContext context, Exception exception) {
    if (exception is FirebaseException &&
        exception.code == 'ERROR_ABORTED_BY_USER') {
      return;
    }
    showExceptionAlertDialog(context,
        title: 'Sign in failed', exception: exception);
  }

  Future<void> _signInAnonumously(BuildContext context) async {
    try {
      await bloc.signInAnonymously();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await bloc.signInWithGoogle();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  Future<void> _signInWithFacebook(BuildContext context) async {
    try {
      await bloc.signInWithFacebook();
    } on Exception catch (e) {
      _showSignInError(context, e);
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (context) => EmailSignInPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<SignInBloc>(
      context,
      listen: false,
    );
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        elevation: 2,
        title: const Center(
          child: Text("Time Tracker"),
        ),
      ),
      body: StreamBuilder<bool>(
        stream: bloc.isLoadingStream,
        initialData: false,
        builder: (context, snapShot) {
          return _buildContent(context, snapShot.data);
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, bool? isLoading) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: _builderHeader(isLoading!),
          ),
          const SizedBox(
            height: 48,
          ),
          SocialSignInButton(
            assetName: "assets/images/google-logo.png",
            text: "Sign with Google",
            color: Colors.white,
            textColor: Colors.black,
            onPressed: () => _signInWithGoogle(context),
            borderRadius: 16,
            height: 50,
          ),
          const SizedBox(
            height: 8,
          ),
          SocialSignInButton(
            assetName: "assets/images/facebook-logo.png",
            text: "Sign in wtih Facebook",
            color: const Color(0xFF334D92),
            textColor: Colors.white,
            onPressed: () => _signInWithFacebook(context),
            borderRadius: 16,
            height: 50,
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Sign in wtih E-mail",
            color: Colors.teal.shade700,
            textColor: Colors.white,
            onPressed: () => _signInWithEmail(context),
            borderRadius: 16,
            height: 50,
          ),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'or',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 8,
          ),
          SignInButton(
            text: "Go Anonymous",
            color: Colors.lime.shade500,
            textColor: Colors.black,
            onPressed: () => _signInAnonumously(context),
            borderRadius: 16,
            height: 50,
          ),
        ],
      ),
    );
  }

  Widget _builderHeader(bool isLoading) {
    if (isLoading == true) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return const Text(
      'Sing in',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 32,
      ),
    );
  }
}
