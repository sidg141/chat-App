import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );

  final bool isLoading;
  final void Function(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  String _userEmail = '';
  String _userName = '';
  String _userPass = '';
  bool isLogin = true;

  void _trySubmit() {
    print('h1');
    final isValid = _formKey.currentState.validate();
    print('h2');
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPass.trim(),
        _userName.trim(),
        isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email Address',
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                    validator: (value) {
                      print('v1');
                      if (value.isEmpty || !value.contains('@'))
                        return 'please enter a valid email address';

                      return null;
                    },
                  ),
                  if(!isLogin)
                  TextFormField(
                    validator: (value) {
                      print('v2');
                      if (value.isEmpty || value.length < 4) {
                        return 'please enter atleast four characters';
                      }

                      return null;
                    },
                    onSaved: (value) {
                      _userName = value;
                    },
                    decoration: InputDecoration(labelText: 'user name'),
                  ),
                  TextFormField(
                    validator: (value) {
                      print('v3');
                      if (value.isEmpty || value.length < 7) {
                        return 'Please must be atleast 7 characters Long';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _userPass = value;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text('login'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      onPressed: (){
                        setState(() {
                          isLogin=!isLogin;
                        });
                      },
                      child: isLogin ? Text(
                        'Create new Account',
                        style: TextStyle(color: Colors.amber),
                      ):
                      Text('I already have account'),
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
