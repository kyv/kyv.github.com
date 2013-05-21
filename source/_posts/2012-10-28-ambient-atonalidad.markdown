---
layout: post
title: "Ambient_Atonalidad"
date: 2012-10-28 11:58
comments: true
categories: hacks supercollider
---

Presentamos el codigo de nuestra participacion en el concerto de musica electronica que dio conclusion al taller [Música por computadora con código, primer parte del serie Laboratorio de arte y nuevos medios, impartido en CASA de los artes San Augustin Etla](http://casanagustin.org.mx/actividades-en-curso/888-laboratorio-de-arte-y-nuevos-medios.html "Laboratorio de arte y nuevos medios").

El codigo es el linguaje [SuperCollider](http://supercollider.sourceforge.net/ "SuperCollider"), que es lo que en concreto aprendimos en el taller.

Primero sintetizamos un ruido de fondo y la pasamos por un Resonant Low Pass Filter (RLPF).

{% codeblock ruido lang:smalltalk %}
~lfn={RLPF.ar(LFNoise2.ar(10000),440,0.1)*0.03}
{% endcodeblock%}

En seguida sintetizamos un especia de ritmo atreves de un seria de ruidos de igual manera filtros por un RLPF.

{% codeblock tracktor lang:smalltalk %}
~tractor={RLPF.ar(BrownNoise.ar*Impulse.kr(10)*1*WhiteNoise.ar(10))};
{% endcodeblock%}

Luego sintetizamos un bombo.

{% codeblock bombo lang:smalltalk %}
~kick={Ringz.ar( Impulse.ar(2), 60, 0.5 )*0.3 };
{% endcodeblock%}

Un acorde hecho de tres tonos elejido de forma aleatorio.

{% codeblock acorde lang:smalltalk %}
~tono={SinOsc.ar([0,2,4,5,6,9,11,12].choose.midiratio*400)*1/5 };
~tono0={SinOsc.ar([0,2,4,5,6,9,11,12].choose.midiratio*400)*1/5 };
~tono1={SinOsc.ar([0,2,4,5,6,9,11,12].choose.midiratio*400)*1/5 };
{% endcodeblock%}

Y finalmente dos melodias reproducidas en sequencia aleatorio.

{% codeblock melodia lang:smalltalk %}
~demand={Demand.kr(Impulse.kr(1),0,Dseq([0,2,3,4,5,6,7,8,9,10,11,12].scramble,inf))};
~dmel0={Demand.kr(Impulse.kr(1),0,Dseq([0,2,3,4,5,6,7,8,9,10,11,12].reverse.scramble,inf))};
{% endcodeblock%}

