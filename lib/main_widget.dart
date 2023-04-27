import 'package:dio/dio.dart';
import 'package:ecomm_app/base/base_consumer_state.dart';
import 'package:ecomm_app/common/error/no_internet_connection.dart';
import 'package:ecomm_app/core/auth/local_auth.dart';
import 'package:ecomm_app/core/providers/app_background_state_provider.dart';
import 'package:ecomm_app/core/providers/internet_connection_observer.dart';
import 'package:ecomm_app/core/remote/network_service.dart';
import 'package:ecomm_app/core/route/go_router_provider.dart';
import 'package:ecomm_app/i18n/i18n.dart';
import 'package:flutter/material.dart';
/// auto generated after you run `flutter pub get`
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainWidget extends ConsumerStatefulWidget {
  const MainWidget({super.key});

  @override
  ConsumerState<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends BaseConsumerState<MainWidget> {
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();
  

  @override
  void initState() {
    super.initState();
    _isNetworkConnected();
    _networkConnectionObserver();
  }

  void _isNetworkConnected() async {
    final isConnected =
        await ref.read(internetConnectionObserverProvider).isNetworkConnected();
    if (!isConnected) {
      if (!mounted) return;
      navigatorKey.currentState?.push(
        MaterialPageRoute(
          builder: (_) => const NoInternetConnectionScreen(),
        ),
      );
    }
  }

  void _networkConnectionObserver() {
    final connectionStream =
        ref.read(internetConnectionObserverProvider).hasConnectionStream.stream;
    connectionStream.listen((isConnected) {
      if (!isConnected) {
        _showSnackBar();
      }
    });
  }

  void _showSnackBar() {
    scaffoldMessengerKey.currentState?.clearSnackBars();
    scaffoldMessengerKey.currentState?.showSnackBar(
      const SnackBar(
        content: Text('No internet connection'),
        duration: Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //final isAppInBackground = ref.watch(appBackgroundStateProvider);
    final router = ref.watch(gorouterProvider);

    return MaterialApp.router(
      title: 'Flutter Demo',
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      scaffoldMessengerKey: scaffoldMessengerKey,
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocales.supportedLocales,
      locale: AppLocales.en.locale,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: isAppInBackground
      //     ? const ColoredBox(color: Colors.black)
      //     : const SettingScreen(),
      // //HomePage(title: 'Flutter Demo Home Page'),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    switch (state) {
      case AppLifecycleState.inactive:
        ref.read(appBackgroundStateProvider.notifier).state = true;
        break;
      case AppLifecycleState.resumed:
        ref.read(appBackgroundStateProvider.notifier).state = false;
        break;

      default:
    }
  }
}

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseConsumerState<HomePage> {
  int _counter = 0;
  late Dio _dio;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _dio = ref.read(networkServiceProvider);
      // getSomeData();
    });
  }

  void getSomeData() async {
    final response = await _dio.get('api/v1/banner/getHomeBannerSlider');
    log.info(response);
  }

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              translation.buttonPushMsg(_counter),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
              onPressed: () async {
                final didAuthenticate =
                    await ref.read(localAuthProvider).authenticate();
                if (didAuthenticate) {
                  debugPrint('successful auth');
                }
              },
              child: const Text('Authenticate to unlock'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: translation.increment,
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
