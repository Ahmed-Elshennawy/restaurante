import 'package:restaurante/user_screens/home.dart';
import 'package:restaurante/admin_screens/home_admin.dart';
import 'package:restaurante/user_screens/navigation.dart';
import 'package:restaurante/user_screens/login.dart';
import 'package:restaurante/user_screens/signup.dart';
import 'package:restaurante/widgets/provider.dart';
import 'package:restaurante/user_screens/onboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'widgets/dark_theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'widgets/theme_data.dart';

late SharedPreferences sharedPref;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeChangeProvider = DarkThemeProvider();

  void getCurrentAppTheme() async {
    themeChangeProvider.setDarkTheme =
        await themeChangeProvider.darkThemePrefs.getTheme();
  }

  @override
  void initState() {
    getCurrentAppTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return themeChangeProvider;
        })
      ],
      child: ChangeNotifierProvider(
        create: (context) => WalletProvider(),
        child: Consumer<DarkThemeProvider>(
            builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Restaurante',
            initialRoute:
                sharedPref.getString("id") == null ? "login" : "home_admin",
            routes: {
              'login': (context) => const Login(),
              'navigation': (context) => const Navigation(),
              'onboard': (context) => const Onboard(),
              'signup': (context) => const SignUp(),
              'home': (context) => const Home(),
              'home_admin': (context) => const HomeAdmin(),
            },
            theme: Styles.themeData(themeProvider.getDarkTheme, context),
            home: const Onboard(),
          );
        }),
      ),
    );
  }
}
