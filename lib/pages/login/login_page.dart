import 'package:cpm/common/routes/router_route.dart';
import 'package:cpm/common/widgets/input_decorations.dart';
import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/utils/asset.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/sizes.dart';
import 'package:cpm/utils/extensions/validators/string_validators.dart';
import 'package:cpm/utils/snack_bar_manager.dart';
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

  void _toggleObscurePassword() {
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

    if (logged) {
      if (!mounted) {
        return;
      }

      context.go(RouterRoute.projects.path);
    } else {
      SnackBarManager.error(localizations.error_login).show();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: Paddings.custom.pageHorizontal,
        child: Center(
          child: ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
            child: SingleChildScrollView(
              child: Padding(
                padding: Paddings.custom.pageVerticalWithSystemUi,
                child: Center(
                  child: SizedBox(
                    width: Sizes.size512.size,
                    child: Form(
                      key: _formKey,
                      child: AutofillGroup(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image.asset(
                              Asset.cpm.path,
                              filterQuality: FilterQuality.medium,
                              fit: BoxFit.fitWidth,
                              width: Sizes.size128.size,
                            ),
                            Padding(padding: Paddings.padding16.vertical),
                            Text(
                              localizations.app_name_full,
                              style: Theme.of(context).textTheme.displaySmall,
                              textAlign: TextAlign.center,
                            ),
                            Padding(padding: Paddings.padding32.vertical),
                            TextFormField(
                              controller: usernameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              autofillHints: const [AutofillHints.email],
                              onEditingComplete: () {
                                FocusScope.of(context).nextFocus();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return localizations.error_required;
                                } else if (!value.validEmail) {
                                  return localizations.error_invalid_email;
                                }

                                return null;
                              },
                              decoration: authenticationTextFormFieldDecoration(
                                context,
                                Icons.mail,
                                localizations.login_username,
                              ),
                            ),
                            Padding(padding: Paddings.padding8.vertical),
                            TextFormField(
                              controller: passwordController,
                              enableSuggestions: false,
                              autocorrect: false,
                              obscureText: obscurePassword,
                              keyboardType: obscurePassword ? null : TextInputType.visiblePassword,
                              autofillHints: const [AutofillHints.password],
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
                              decoration: authenticationTextFormFieldDecoration(
                                context,
                                Icons.lock,
                                localizations.login_password,
                                Padding(
                                  padding: Paddings.padding4.right,
                                  child: IconButton(
                                    icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
                                    onPressed: _toggleObscurePassword,
                                  ),
                                ),
                              ),
                            ),
                            Padding(padding: Paddings.padding32.vertical),
                            SizedBox(
                              width: Sizes.custom.infinity,
                              child: FilledButton(
                                onPressed: _login,
                                child: Text(localizations.login_log_in),
                              ),
                            ),
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
      ),
    );
  }
}
