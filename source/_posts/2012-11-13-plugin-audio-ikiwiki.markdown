---
layout: post
title: "Plugin Audio Ikiwiki"
date: 2012-11-13 13:59
comments: true
categories: hacks perl audio
tags: [web, hacks, perl, audio]
---
{% img right http://flujos.org/media/360player.png Foto de Ejemplo %}
Hace poco tiempo hicimos un *plugin* de audio para ikiwiki. Esto se encuentra en [nuestra bifurcación de ikiwiki](https://github.com/kyv/ikiwiki). El *plugin* vive en [la carpeta Ikiwiki/Plugin](https://github.com/kyv/ikiwiki/blob/master/IkiWiki/Plugin/audio.pm). Pero depende también de [un *underlay* en que hemos copiado el 360° player](https://github.com/kyv/ikiwiki/tree/master/underlays/360-player/ikiwiki "360° Player") desde el proyecto [soundmanager2](http://www.schillmania.com/projects/soundmanager2/ "SoundManager2").

Para ver el *plugin* en acción visita [flujos.org](http://flujos.org).

Unos ejemplos de sintaxis:
{% codeblock lang:bash %}
[[!audio http://radio.flujos.org:8000/rockola.oga text="La Rockola"]]
{% endcodeblock %}
o para un fichero hospedado en la sistema de ficheros:
{% codeblock lang:bash %}
[[!audio /ruta/a/audio.oga text="Mi audio"]]
{% endcodeblock %}
Aparte tenemos una plantilla para hacer un listado automático de audios *inline*. Hay un [ejemplo de su funcionamiento en la pagina de radio yaxhil](http://yaxhil.flujos.org/audio/biz_band/ "Biz Band") y la utilizamos conjuntamente con el [plugin *inline* de ikiwiki](http://ikiwiki.info/plugins/inline/ "Inline Plugin"):
{% codeblock lang:bash %}
[[!inline  template="inlineaudio" pages="audio/biz_band/* and !*/Discussion" show="10"]]
{% endcodeblock %}
<!-- more -->

Para su instalación copia estos ficheros de nuestro repo a sus equivalentes carpetas en su instalación de ikiwiki. O, alternativamente, a su código fuente de ikiwiki y recompila. 
