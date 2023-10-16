import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/extensions/string_validators.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;

  void _obscurePassword() {
    setState(() {
      obscurePassword = !obscurePassword;
    });
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final logged = await ref.read(authenticationProvider.notifier).login(
          usernameController.text,
          passwordController.text,
        );

    if (logged && context.mounted) {
      context.goNamed(RouterRoute.projects.name);
    } else {
      SnackBarManager().show(getErrorSnackBar(localizations.error_login));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: ScrollConfiguration(
              behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
              child: SingleChildScrollView(
                child: Center(
                  child: SizedBox(
                    width: 512,
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                          Image.asset(
                            Asset.cpm.path,
                            filterQuality: FilterQuality.medium,
                            fit: BoxFit.fitWidth,
                            width: 192,
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 32.0)),
                          TextFormField(
                            controller: usernameController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            onEditingComplete: () {
                              FocusScope.of(context).nextFocus();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return localizations.error_required;
                              } else if (!value.isValidEmail()) {
                                return localizations.error_invalid_email;
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.mail),
                              hintText: localizations.login_username,
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceVariant,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                          TextFormField(
                            controller: passwordController,
                            enableSuggestions: false,
                            autocorrect: false,
                            obscureText: obscurePassword,
                            keyboardType: obscurePassword ? null : TextInputType.visiblePassword,
                            onEditingComplete: () {
                              FocusScope.of(context).unfocus();
                              _login();
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return localizations.error_required;
                              }

                              return null;
                            },
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: localizations.login_password,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right: 4.0),
                                child: IconButton(
                                  icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                                  onPressed: _obscurePassword,
                                ),
                              ),
                              filled: true,
                              fillColor: Theme.of(context).colorScheme.surfaceVariant,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.secondary,
                                ),
                              ),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide.none,
                              ),
                              focusedErrorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(64.0),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 32.0)),
                          SizedBox(
                            width: double.infinity,
                            child: FilledButton(
                              onPressed: () => _login(),
                              child: Text(localizations.login_log_in),
                            ),
                          ),
                          const Padding(padding: EdgeInsets.symmetric(vertical: 8.0)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
