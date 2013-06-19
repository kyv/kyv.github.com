---
layout: post
title: "Comparación‎ de Duración de Audios"
date: 2013-06-19 09:38
comments: true
categories: hacks audio python
---

Estaba editando video. Grabamos el audio aparte del imagen.
Ahora al momento de editar, lo encontré algo tedioso buscar cual audio de todos
combinaba con cada scena de video. Pensaba que deberia existir un utilidad que
al menos compara el duracion de audios, pero no encontré. Entonces
escribí uno en python que compara dos carpetas de ficheros .wav. Demuestra cuales
ficheros entre las dos carpetas se aproximan más en terminos de duración en segundos.

{% codeblock %}
TASCAM_0011.wav: 12, CANON_1080.wav: 15
TASCAM_0013.wav: 13, CANON_1080.wav: 15
TASCAM_0004.wav: 25, CANON_1069.wav: 27
TASCAM_0006.wav: 34, CANON_1095.wav: 38
TASCAM_0007.wav: 38, CANON_1095.wav: 38
TASCAM_0012.wav: 40, CANON_1095.wav: 38
TASCAM_0009.wav: 48, CANON_1121.wav: 56
TASCAM_0005.wav: 63, CANON_1071.wav: 62
TASCAM_0003.wav: 64, CANON_1071.wav: 62
TASCAM_0015.wav: 65, CANON_1071.wav: 62
TASCAM_0008.wav: 129, CANON_1068.wav: 151
TASCAM_0014.wav: 409, CANON_1068.wav: 151
TASCAM_0016.wav: 948, CANON_1068.wav: 151
{% endcodeblock %}

<!-- more -->

Es unicamente un punto de partida. Pero así podemos ver cuales audio tienen
mayor probabilidad de coresponder a un video. Se ejecuta así: ``` python2 wavecmp carpeta1 carpeta2 ```.


{% gist 5814824 %}
