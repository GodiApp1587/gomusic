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

import 'dart:ui';

import 'package:blackhole/CustomWidgets/gradient_containers.dart';
import 'package:blackhole/Helpers/backup_restore.dart';
import 'package:blackhole/Helpers/config.dart';
import 'package:blackhole/Models/animated_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController controller = TextEditingController();
  Uuid uuid = const Uuid();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future _addUserData(String name) async {
    await Hive.box('settings').put('name', name.trim());

    final String userId = uuid.v1();
    await Hive.box('settings').put('userId', userId);
  }

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: SafeArea(

          child: Stack(

            children: [


              AnimatingBg1(

              ),




              Column(
                    children: [

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () async {
                              await restore(context);
                              GetIt.I<MyTheme>().refresh();
                              Navigator.popAndPushNamed(context, '/');
                            },
                            child: Text(
                              AppLocalizations.of(context)!.restore,
                              style: TextStyle(
                                color: Colors.grey.withOpacity(0.7),
                              ),
                            ),
                          ),
                          TextButton(
                            onPressed: () async {
                              await _addUserData(
                                AppLocalizations.of(context)!.guest,
                              );
                              Navigator.popAndPushNamed(context, '/pref');
                            },
                            child: Text(
                              AppLocalizations.of(context)!.skip,
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: Center(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(width: 68,),
                                Center(
                                  child: Image.asset(
                                    'assets/logo.png', // Ruta de tu imagen
                                    // Ajusta el ancho y alto según sea necesario
                                    width: 191,

                                    // Puedes agregar más propiedades para personalizar la imagen según tus necesidades
                                  ),
                                ),
const SizedBox(
  height: 37,
),
                                Column(
                                  children: [

                                    Center(
                                      child: GlassmorphicContainer(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                          left: 10,
                                          right: 10,
                                        ),
                                        width: 360,
                                        height: 57,
                                        borderRadius: 12,
                                        blur: 14,
                                        alignment: Alignment.bottomCenter,
                                        border: 0.9,
                                        linearGradient: LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xFFffffff).withOpacity(0.1),
                                              Color(0xFFFFFFFF).withOpacity(0.05),
                                            ],
                                            stops: [
                                              0.1,
                                              1,
                                            ]),
                                        borderGradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xFFffffff).withOpacity(0.27),
                                            Color((0xFFFFFFFF)).withOpacity(0.3),
                                          ],
                                        ),
                                        child: Center(
                                          child: TextField(
                                            controller: controller,
                                            textAlignVertical: TextAlignVertical.center,
                                            textCapitalization:
                                                TextCapitalization.sentences,
                                            keyboardType: TextInputType.name,
                                            decoration: InputDecoration(
                                              focusedBorder: const UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 1.5,
                                                  color: Colors.transparent,
                                                ),
                                              ),
                                              prefixIcon: const Icon(
                                                Icons.person_2_rounded,
                                                color: Colors.lightGreenAccent,
                                              ),
                                              border: InputBorder.none,
                                              hintText: AppLocalizations.of(context)!
                                                  .enterName,
                                              hintStyle: const TextStyle(
                                                color: Colors.white60,
                                              ),
                                            ),
                                            onSubmitted: (String value) async {
                                              if (value.trim() == '') {
                                                await _addUserData(
                                                  AppLocalizations.of(context)!.guest,
                                                );
                                              } else {
                                                await _addUserData(value.trim());
                                              }
                                              Navigator.popAndPushNamed(
                                                context,
                                                '/pref',
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        if (controller.text.trim() == '') {
                                          await _addUserData('Guest');
                                        } else {
                                          await _addUserData(
                                            controller.text.trim(),
                                          );
                                        }
                                        Navigator.popAndPushNamed(context, '/pref');
                                      },



                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                          vertical: 20.0,
                                        ),
                                        height: 58.0,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10.0),
                                          color: Colors.lightGreenAccent,
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.yellowAccent,
                                              blurRadius: 8.0,
                                              offset: Offset(0.3, 0.6),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .getStarted,
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20.0,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 8.0,
                                      ),
                                      child: Text(
                                        '${AppLocalizations.of(context)!.disclaimer} ${AppLocalizations.of(context)!.disclaimerText}',
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.45),
                                        ),
                                      ),

                                    ),

                                  ],

                                ),

                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

            ],
          ),
        ),
      ),
    );
  }
}
