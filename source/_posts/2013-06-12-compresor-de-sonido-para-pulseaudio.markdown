---
layout: post
title: "Compresor de Sonido para Pulseaudio"
date: 2013-06-12 10:19
comments: true
categories: audio hacks
tags: [audio, hacks, ladspa, compresor, pulseaudio, eq]
---
Del [wikipedia](https://es.wikipedia.org/wiki/Compresor_%28sonido%29), *En el campo del sonido profesional, un compresor es un procesador electrónico de sonido destinado a reducir el margen dinámico de la señal sin que se note demasiado su presencia. Esta tarea, se realiza reduciendo la ganancia del sistema, cuando la señal supera un determinado umbral.*

[Pulseaudio](http://es.wikipedia.org/wiki/PulseAudio) es la capa de audio a lo cual conecta los varios applicaciones que reproducen sonido en la mayoria de los *nix contemporaneos. Porque permite el uso de los procesadores y filtros [ladspa](http://www.ladspa.org/), con un pequeño configución podemos aplicar cualcuiera de ellos. Uno de los usos más utiles podria ser el compresor de rango dinamico, para mantener toda la musica y video que reproducimos a un amplitud constante. Hemos de agregar estas lineas al configuracion de pulseaudio, en nuestro caso **~/.pulse/default.pa**

``` bash sc4 plugin para pulseaudio
load-module module-ladspa-sink sink_name=compressor master=alsa_output.pci-0000_00_1e.2.analog-stereo plugin=sc4_1882 label=sc4 control=1,1.5,401,-30,20,5,12
set-default-sink compressor
```

El primer linea carga el sc4, un compresor estereo ladspa. **Control=** son los parámetros del efecto. Detalles al respecto se encuetra en [la documentación del plugin](http://plugin.org.uk/ladspa-swh/docs/ladspa-swh.html#tth_sEc2.91).

<!-- more -->

Vale mencionar que es possible encadenar estos plugins. En nuestro caso, primer pasamos el audio por un equalizador de 15 canales, para quitar algunas frequencias que causan vibraciones no-deseables en las bocinitas del lap. El señal equalizado entonces pasa al compresor. Agregamos otra sección al config despues del anterior.

``` bash equalizador para pulseaudio
load-module module-ladspa-sink sink_name=ladspa_output.mbeq_1197.mbeq master=compressor plugin=mbeq_1197 label=mbeq control=-30.0,-19.7,-15.6,-12.0,-3.9,-1.3,0.0,0.0,0.0,0.0,0.0,0.0,-1.3,-4.6,-5.7
```

De hecho este seccion del equalizador se agrega automaticamente al instalar el paquete [pulseaudio-equalizer](https://aur.archlinux.org/packages/pulseaudio-equalizer/), que tiene un bonito interfaz grafica. Pero es necesario su modificación si vamos a acompañarlo con compression.

Este información originalmente encontramos en [las ayudas de ubuntu](http://askubuntu.com/questions/31580/is-there-a-way-of-leveling-compressing-the-sound-system-wide).

Punto y aparte, el [version más recien de pulseaudio](http://www.freedesktop.org/wiki/Software/PulseAudio/Notes/4.0/) tiene un modulo de [ducking](http://en.wikipedia.org/wiki/Ducking) ( bajar un fuente de audio cuando entra otro). Seria intersante para unos experimientos más adelante.
