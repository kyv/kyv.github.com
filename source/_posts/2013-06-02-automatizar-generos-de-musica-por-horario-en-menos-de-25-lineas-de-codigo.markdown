---
layout: post
title: "Automatizar Géneros de Música por Horario en Menos de 25 Lineas de Codigo"
date: 2013-06-02 19:35
comments: true
categories: hacks mpd ruby automatización
---
Por un tiempo he automatizado mi collecion de musica con [mpd](http://www.musicpd.org/) y [mpdcron](http://alip.github.io/mpdcron/), de tal forma que [jamás termina](http://www.flujos.org/blog/mpd_la_lista_jamas/) la lista de reproduccion. Sencillamente cuando hay 3 o menos canciones en la cola, automaticamente se elija otro al alzar de la biblioteca y se agrega a la cola. Desde que elaborarmos esta forma de asegurar que jamás acaba la musica quedamos con la idea que hay bastante por mejorar. Pero hasta cierto cumbiabero de la costa chica, que aqui quedaria sin nombrarse, me empiezó gritar grosarias en relacion de una mama de carácter "muy buena" *y su hija tambien* a las **7:30** de una mañana domingera que decidí que ya era hora de enfrentar con esta problematica. "Estas temas mejor para despues del almuerzo", pensé yo y pusé manos a la obra. Así es que nacio este mismo domingo una forma bastante sencilla, por no decir bruto, de automatizar generos de musica por horarios. Ahi les va: 

{% gist 5695560 %}

<!-- more -->

Igual como la forma anterior y aun más brunto de vivir completamente encadenado, se puede decir, al alzar sino del destino entonces de los alogaritmos en existencia actualmente, utilizamos mpdcron para llamar este codigo cada vez que occure un acción en la lista de reproducción.

Hay mucho por mejorar. Por ememplo le voy a hacer para que puedo asignar varios generos a la misma hora. Y seria mejor se fuera más preciso, es decir, se se podria asignar generos por periodos de 15 minutos. Ademas, es muy poco exacto en el sentido que no hay que esperar que cambia el genero precisamente cuando cabmia la hora. Pero, por lo pronto, y para nuestro la problema especifico, funciona bastante bien. Así tomamos un momento para disfruntar un trabajo bien hecho con un mescalito extraido de las mas sabrosos magueys del valle de oaxaca mientras que suena lo que se puede llamar el *soundrack de la vida*.

Más en la misma vaina:
[Locución de la Hora con mpdcron](http://www.flujos.org/blog/Locucion_de_hora-mpdcron/), [Concatenar Audios](http://ki-ai.org/blog/2012/11/25/audio-cat/)

