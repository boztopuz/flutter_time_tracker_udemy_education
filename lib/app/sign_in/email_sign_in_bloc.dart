import 'dart:async';

import 'package:time_tracker_flutter/app/sign_in/email_sign_in_model.dart';

class EmailSignInBloc {
  final StreamController<EmailSignInModels> _modelController =
      StreamController<EmailSignInModels>();

  Stream<EmailSignInModels> get modelStream => _modelController.stream;
  EmailSignInModels _model = EmailSignInModels();

  void dispose() {
    _modelController.close();
  }

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);
    _modelController.add(_model);
  }
}
