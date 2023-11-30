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

import 'package:flutter/material.dart';

Widget homeDrawer({
  required BuildContext context,
  EdgeInsetsGeometry padding = EdgeInsets.zero,
}) {
  return Padding(
    padding: padding,
    child: Transform.rotate(
      angle: 22 / 7 * 2,
      child: Container(
        width: 42, // Ancho del contenedor
        height: 42, // Alto del contenedor
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // Para un contenedor completamente redondo, utiliza la mitad del ancho o alto
          color: Colors.black.withOpacity(0.7), // Color negro con opacidad del 50%
        ),
        child:ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Ajusta los valores de sigmaX y sigmaY según tu preferencia
            child: Container(
              color: Colors.transparent,

          child: IconButton(
            icon: const Icon(
              Icons.horizontal_split_rounded,
              color: Colors.white,
            ),
            // color: Theme.of(context).iconTheme.color,
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          ),
        ),
      ),
    ),
  ),
    ),

  );
}
