/*
 *  This file is part of BlackHole (https://github.com/Sangwan5688/BlackHole).
 * 
 * BlackHole is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * BlackHole is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with BlackHole.  If not, see <http://www.gnu.org/licenses/>.
 * 
 * Copyright (c) 2021-2023, Ankit Sangwan
 */

import 'package:blackhole/CustomWidgets/gradient_containers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  @override
  _AboutScreenState createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  String? appVersion;

  @override
  void initState() {
    main();
    super.initState();
  }

  Future<void> main() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      appVersion = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {

    return GradientContainer(
      child: Stack(
        children: [
          Positioned(
            left: MediaQuery.sizeOf(context).width / 2,
            top: MediaQuery.sizeOf(context).width / 5,
            child: const Image(
              fit: BoxFit.fitWidth,
              image: AssetImage(
                'assets/ic_launcher.png',
              ),
            ),
          ),
          const GradientContainer(
            child: null,
            opacity: true,
          ),
          Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? const Color(0xFF10111E)
                  : const Color(0xFFFFFFFF),
              elevation: 10,
              title: Text(
                AppLocalizations.of(context)!.about,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
              centerTitle: true,
            ),
            backgroundColor: Colors.transparent,
            body: Stack(
              fit: StackFit.expand,
              children: [
                Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/fondo_ap_settings.png'), // Ruta de tu imagen
    fit: BoxFit.cover, // Ajusta la imagen para cubrir el contenedor
    ),
    ),
    ),
                 SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Card(
                            elevation: 15,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: const SizedBox(
                              width: 160,
                              child: Image(
                                image: AssetImage('assets/logo.png'),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.appTitle,
                            style: const TextStyle(
                              fontSize: 39,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('v$appVersion'),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 0.0),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.of(context)!.aboutLine1,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 16),
                            ),
                            TextButton(
                              onPressed: () {
                                launchUrl(
                                  Uri.parse(
                                    'https://gomusic.grwebsite.com/',
                                  ),
                                  mode: LaunchMode.externalApplication,
                                );
                              },
                              child: SizedBox(
                                width: MediaQuery.sizeOf(context).width / 4,
                                child: Image(
                                  image: Theme.of(context).brightness ==
                                          Brightness.dark
                                      ? const AssetImage(
                                          'assets/google.png',
                                        )
                                      : const AssetImage('assets/google.png'),
                                ),
                              ),
                            ),
                            Text(
                              AppLocalizations.of(context)!.aboutLine2,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Column(
                        children: [
                          TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              launchUrl(
                                Uri.parse(
                                  'https://play.google.com/store/apps/details?id=com.godimexico.gomusic',
                                ),
                                mode: LaunchMode.externalApplication,
                              );
                            },
                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width / 2,
                              child: const Image(
                                image: AssetImage('assets/play_white.png'),
                              ),
                            ),
                          ),
                         const SizedBox(height: 10),
                          TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.zero,
                              backgroundColor: Colors.transparent,
                              foregroundColor: Colors.transparent,
                            ),
                            onPressed: () {
                              const String upiUrl =
                                  'https://www.apple.com/mx/app-store/';
                              launchUrl(
                                Uri.parse(upiUrl),
                                mode: LaunchMode.externalApplication,
                              );
                            },

                            child: SizedBox(
                              width: MediaQuery.sizeOf(context).width / 2,
                              child: Image(
                                image: AssetImage(
                                  Theme.of(context).brightness == Brightness.dark
                                      ? 'assets/store_white.png'
                                      : 'assets/store_black.png',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10,),
                          Text(
                            AppLocalizations.of(context)!.sponsor,
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),

                      SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 30, 5, 20),
                          child: Center(
                            child: Text(
                              AppLocalizations.of(context)!.madeBy,
                              style: const TextStyle(fontSize: 13),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
    ],
              ),

          ),
        ],
      ),
    );
  }
}
