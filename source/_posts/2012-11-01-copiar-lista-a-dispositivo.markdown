---
layout: post
title: "Copiar .m3u a dispositivo"
date: 2012-11-01 12:35
comments: true
categories: hacks perl
tags: [hacks, perl, audio]
---
Si tienes una lista de reproducción de formato sencillo .m3u, este *script* copia los contenidos de la lista a una carpeta. Mi ha sido útil, por ejemplo, para copiar mis rolas preferidas a mi celular antes de salir a la calle. Si en la lista tienes varias formatos, el *script* los convertirá a **mp3**. Obviamente prefería tener un teléfono que reproduciera **ogg-vorbis**, pero la triste verdad es que no tengo. **Ojo**: *para que funciona la conversión de formatos es necesario que mplayer y lame estan instalados*.

### Si ejecute así
{% codeblock como lang:bash %}
$ cpm3u.pl /ruta/a/lista.m3u /ruta/a/destinto/
{% endcodeblock %}

### Codigo

{% codeblock cpm3u.pl lang:perl %}
#!/usr/bin/perl

# Copyright 2012, kev@flujos.org
# Licensed under the GPL Version 2 license.

use File::Copy;
use File::Basename;

my $PLS="$ARGV[0]";
my $DEST="$ARGV[1]";
my $tmp='/tmp/out.wav';
my @exts=qw(.ogg .oga .wma .m4a);
open($p, $PLS);
for (<$p>) {
	chomp;
	my $orig = $ENV{HOME}. "/". $_;
   	if ($orig =~ /.mp3$/i) {
       		copy("$orig", "$DEST") or die "Copy Failed $!"; 
   	}
   	else {
       		$out_file=$DEST. basename($_, @exts) . '.mp3';
       		system('/usr/bin/mplayer', '-ao', "pcm:file=$tmp", "$orig");

       # Use lame to make an mp3
       system('/usr/bin/lame', "$tmp", "$out_file");

       if (unlink($tmp) == 0) {
            print "$tmp deleted successfully.\n";
        } else {
            print "$tmp was not deleted.\n";
       }
   }

}
{% endcodeblock %}
