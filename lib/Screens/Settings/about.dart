import 'dart:io';

import 'package:blackhole/CustomWidgets/copy_clipboard.dart';
import 'package:blackhole/CustomWidgets/gradient_containers.dart';
import 'package:blackhole/CustomWidgets/snackbar.dart';
import 'package:blackhole/Helpers/github.dart';
import 'package:blackhole/Helpers/update.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:glass_kit/glass_kit.dart';
import 'package:hive/hive.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({super.key});

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  String? appVersion;

  @override
  void initState() {
    main();
    super.initState();
  }

  Future<void> main() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    appVersion = packageInfo.version;
    setState(
      () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Container(
        decoration: BoxDecoration(
          image: Theme.of(context).brightness == Brightness.dark
              ? const DecorationImage(
            image: AssetImage("assets/splash.png"),
            fit: BoxFit.cover,
          ) // Imagen de fondo para tema oscuro
              : Theme.of(context).brightness == Brightness.light
              ? const DecorationImage(
            image: AssetImage("assets/fondo_theme.png"),
            fit: BoxFit.cover,
          ) // Imagen de fondo para tema oscuro
              : null, // Color sólido para tema claro
        ),

        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            centerTitle: true,
            title: Text(
              AppLocalizations.of(
                context,
              )!
                  .about,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Theme.of(context).iconTheme.color,
                fontSize: 24,
                shadows: [
                  Shadow(
                    blurRadius: 2.0,
                    color: Colors.black87,
                    offset: Offset(1.0, 1.0),
                  ),
                ],
              ),
            ),
            iconTheme: IconThemeData(
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverList(
                delegate: SliverChildListDelegate([
                  Padding(
                    padding: const EdgeInsets.fromLTRB(
                      10.0,
                      10.0,
                      10.0,
                      10.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                      Center(
                        child: GlassContainer(
                        height: 60,
                        width: 340,
                        gradient: LinearGradient(
                          colors: [Colors.black87.withOpacity(0.20), Colors.white.withOpacity(0.10)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderGradient: LinearGradient(
                          colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightGreenAccent.withOpacity(0.05), Colors.lightGreenAccent.withOpacity(0.6)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          stops: [0.0, 0.39, 0.40, 1.0],
                        ),
                        blur: 18.0,
                          borderRadius: BorderRadius.circular(16.0),
                          borderWidth: 1.0,

                        elevation: 2.0,

                        shadowColor: Colors.black.withOpacity(0.20),
                        alignment: Alignment.center,

                        margin: EdgeInsets.all(3.0),
                        padding: EdgeInsets.all(2.0),

                            child: Center(
                              child: ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .version,
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .versionSub,
                                ),
                                onTap: () {
                                  ShowSnackBar().showSnackBar(
                                    context,
                                    AppLocalizations.of(
                                      context,
                                    )!
                                        .checkingUpdate,
                                    noAction: true,
                                  );

                                  GitHub.getLatestVersion().then(
                                    (String latestVersion) async {
                                      if (compareVersion(
                                        latestVersion,
                                        appVersion!,
                                      )) {
                                        ShowSnackBar().showSnackBar(
                                          context,
                                          AppLocalizations.of(context)!.updateAvailable,
                                          duration: const Duration(seconds: 15),
                                          action: SnackBarAction(
                                            textColor:
                                                Theme.of(context).colorScheme.secondary,
                                            label: AppLocalizations.of(context)!.update,
                                            onPressed: () async {
                                              String arch = '';
                                              if (Platform.isAndroid) {
                                                List? abis = await Hive.box('settings')
                                                    .get('supportedAbis') as List?;

                                                if (abis == null) {
                                                  final DeviceInfoPlugin deviceInfo =
                                                      DeviceInfoPlugin();
                                                  final AndroidDeviceInfo
                                                      androidDeviceInfo =
                                                      await deviceInfo.androidInfo;
                                                  abis =
                                                      androidDeviceInfo.supportedAbis;
                                                  await Hive.box('settings')
                                                      .put('supportedAbis', abis);
                                                }
                                                if (abis.contains('arm64')) {
                                                  arch = 'arm64';
                                                } else if (abis.contains('armeabi')) {
                                                  arch = 'armeabi';
                                                }
                                              }
                                              Navigator.pop(context);
                                              launchUrl(
                                                Uri.parse(
                                                  '',
                                                ),
                                                mode: LaunchMode.externalApplication,
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        ShowSnackBar().showSnackBar(
                                          context,
                                          AppLocalizations.of(
                                            context,
                                          )!
                                              .latest,
                                        );
                                      }
                                    },
                                  );
                                },
                                trailing: Text(
                                  'v$appVersion',
                                  style: const TextStyle(fontSize: 12),
                                ),
                                dense: true,
                              ),
                            ),
                          ),
                      ),
                        Center(
                          child: GlassContainer(
                            height: 57,
                            width: 340,
                            gradient: LinearGradient(
                              colors: [Colors.black87.withOpacity(0.20), Colors.white.withOpacity(0.10)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderGradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightGreenAccent.withOpacity(0.05), Colors.lightGreenAccent.withOpacity(0.6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.39, 0.40, 1.0],
                            ),
                            blur: 18.0,
                            borderRadius: BorderRadius.circular(16.0),
                            borderWidth: 1.0,

                            elevation: 2.0,

                            shadowColor: Colors.black.withOpacity(0.20),
                            alignment: Alignment.center,

                            margin: EdgeInsets.all(3.0),
                            padding: EdgeInsets.all(2.0),

                            child: Center(
                              child: ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .shareApp,
                                ),
                                subtitle: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .shareAppSub,
                                ),
                                onTap: () {
                                  Share.share(
                                    '${AppLocalizations.of(
                                      context,
                                    )!.shareAppText}: https://play.google.com/store/apps/details?id=com.godimexico.gomusic',
                                  );
                                },
                                dense: true,
                              ),
                            ),
                          ),
                        ),
                      //  Center(
                        //  child: GlassContainer(
                          //  height: 57,
                           // width: 340,
                       //     gradient: LinearGradient(
                        //      colors: [Colors.black87.withOpacity(0.20), Colors.white.withOpacity(0.10)],
                          //    begin: Alignment.topLeft,
                           //   end: Alignment.bottomRight,
                        //    ),
                          //7  borderGradient: LinearGradient(
                           //   colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightGreenAccent.withOpacity(0.05), Colors.lightGreenAccent.withOpacity(0.6)],
                           //   begin: Alignment.topLeft,
                           //   end: Alignment.bottomRight,
                          //    stops: [0.0, 0.39, 0.40, 1.0],
                          //  ),
                          //  blur: 18.0,
                           // borderRadius: BorderRadius.circular(15.0),
                         //   borderWidth: 1.0,

                           // elevation: 2.0,

                          //  shadowColor: Colors.black.withOpacity(0.20),
                          //  alignment: Alignment.center,

                         //   margin: EdgeInsets.all(3.0),
                           // padding: EdgeInsets.all(2.0),

                          //  child: Center(
                            //  child: ListTile(
                              //  title: Text(
                                //  AppLocalizations.of(
                                  //  context,
                                //  )!
                                  //    .likedWork,
                              //  ),
                              // subtitle: Text(
                                //  AppLocalizations.of(
                                  //  context,
                                 // )!
                                   //   .buyCoffee,
                               // ),
                          //      dense: true,
                            //    onTap: () {
                              //    launchUrl(
                                //    Uri.parse(
                                  //    'https://gomusic.grwebsite.com/',
                                  //  ),
                                   // mode: LaunchMode.externalApplication,
                              //    );
                            //    },
                          //    ),
                          //  ),
                        //  ),
                      //  ),



                        Center(
                          child: GlassContainer(
                            height: 50,
                            width: 340,
                            gradient: LinearGradient(
                              colors: [Colors.black87.withOpacity(0.20), Colors.white.withOpacity(0.10)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderGradient: LinearGradient(
                              colors: [Colors.white.withOpacity(0.60), Colors.white.withOpacity(0.10), Colors.lightGreenAccent.withOpacity(0.05), Colors.lightGreenAccent.withOpacity(0.6)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              stops: [0.0, 0.39, 0.40, 1.0],
                            ),
                            blur: 18.0,
                            borderRadius: BorderRadius.circular(15.0),
                            borderWidth: 1.0,

                            elevation: 2.0,

                            shadowColor: Colors.black.withOpacity(0.20),
                            alignment: Alignment.center,

                            margin: EdgeInsets.all(3.0),
                            padding: EdgeInsets.all(2.0),

                            child: Center(
                              child: ListTile(
                                title: Text(
                                  AppLocalizations.of(
                                    context,
                                  )!
                                      .moreInfo,
                                ),
                                dense: true,
                                onTap: () {
                                  Navigator.pushNamed(context, '/about');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
