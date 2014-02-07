---
layout: post
title: "Archlinux en MacBook"
date: 2012-11-07 12:51
comments: true
categories: hacks archlinux
tags: [hacks, arch, linux, mac]
---
Anotamos aquí lo que aprendimos al instalar [archlinux](https://www.archlinux.org "Archlinux") en un **macbook**. Aun que en realidad no es cosa de otro mundo, la documentación es un poco ambiguo y muchas de las recomendaciones que se encuentran en el Internet resuelvan la problema de alguna manera. Pero para resolver el problema de la mejor manera posible, tuvimos que tejer la tapete de parches cortados de varias fuentes.

{% img right http://www.rodsbooks.com/refind/refind.png 600 Menú de Arranque %}

Para quienes no quieren leer hasta en final, terminamos con un *dualboot* **osx** y [archlinux](https://www.archlinux.org "Archlinux"), y, gracias a [rEFInd](http://www.rodsbooks.com/refind/ "rEFInd"), arrancamos a linux sin necesidad ni de emulación del *[BIOS](http://es.wikipedia.org/wiki/BIOS "BIOS")* ni de *[GRUB](http://es.wikipedia.org/wiki/Grub)*.



<!-- more -->

## ¿Problema?

En realidad el macbook no es tan distinto de cualquier PC, es un Procesador *intel dual core*. Ya no estamos en los remansos oscuros de los días cuando necesitábamos un version especial de linux y la sistema de aplicaciones que la orbitan. Lo que queda de diferencia al nivel de la sistema es el reemplazo en los mac del *[BIOS](http://es.wikipedia.org/wiki/BIOS "BIOS")* con una cosa que si llama *[EFI](http://es.wikipedia.org/wiki/EFI)*.

El Mac carga un nivel de virtualización del *[BIOS](http://es.wikipedia.org/wiki/BIOS "BIOS")*. Es este emulación del *[BIOS](http://es.wikipedia.org/wiki/BIOS "BIOS")* es lo que permite a uno instalar cosas feas como *window$* en ella. Y por conveniencia históricamente las instalaciones de *Linux* en los *mactel* (mac con procesador intel) ha aprovechado de este emulación. Por conveniencia pero no por necesidad, y mucho menos por elocuencia, por que desde hace tiempo linux puede arrancar a se mismo a través de *[EFI](http://es.wikipedia.org/wiki/EFI)*. Entonces es menos elocuente utilizar el emulación del *[BIOS](http://es.wikipedia.org/wiki/BIOS "BIOS")* uno, lo obvio, por que es inesesario; dos, por que es mas lento y tres, porque introducir otra capa de software entre el hardware y la sistema operativo inevitablemente introduzca mas *bugs* (potencial de fallas). Y el solucion de un *[MBR](http://es.wikipedia.org/wiki/MBR) capechano* [introduzca una seria de otras problemas](http://www.rodsbooks.com/gdisk/hybrid.html "MBR Hibrido").

Pero como en todo hay pros y contras, al arrancar linux con puro *[EFI](http://es.wikipedia.org/wiki/EFI)*, según, perdimos [aceleración gráfica](https://help.ubuntu.com/community/MactelSupportTeam/EFI-Boot-Mactel "EFI Boot Ubuntu") con tarjetas de video nvidia (las tarjetas gráficas intel y radeon no sufren el mismo limitate). Pero nuestra experiencia comprueba la contrario. O, mas bien, el *driver* de fuente abierta *nouveau* vimos que habiamos perdidos aceleración gráfica, video reproduce de manera cortado, pero el *driver* propietario *nvidia* funciona muy bien, al menos con la tarjeta gráfica a la mano, el **Nvidia GeForce 9400M**. Eso y no funciona el *reboot* o reinicio de la ordenadora, entonces es siempre necesario apagarlo y arrancarlo despues.

Presentamos los pasos que siguimos.

## Solución

El primer paso es seguir el proceso descrito en el [wiki de arch](https://wiki.archlinux.org/index.php/Official_Arch_Linux_Install_Guide "Guía de Instalación de archlinux").

Al llegar al [paso de los particiones](https://wiki.archlinux.org/index.php/Installation_Guide_(Espa%C3%B1ol\)#Particiones "Particiones") es necesario *no* utilizar los herramientas tradicionales (fdisk, cfdisk, etc) los cuales utilizan el tablas de partición *[MBR](http://es.wikipedia.org/wiki/MBR) (Master Boot Record)* . En su lugar utilizamos los herramientas de **GPT fdisk** (gdisk, cgdisk, etc), que trabajan con la tabla de particiones *[GPT](http://es.wikipedia.org/wiki/Tabla_de_particiones_GUID)* (tambien conocido como *[Globally Unique Identifier (GUID](http://es.wikipedia.org/wiki/GUID))*. *[GPT](http://es.wikipedia.org/wiki/Tabla_de_particiones_GUID)* tiene varias venajes, por ejemplo un máximo de 129 particiones en comparación de los 4 de *[MBR](http://es.wikipedia.org/wiki/MBR)*, su principal limitación es que los sistemas operativas antiguas no tiene soporte para ello. Aparte del elección de *[GPT](http://es.wikipedia.org/wiki/Tabla_de_particiones_GUID)*, haz los particiones según se acostumbra hacerlo. Pero toma nota de donde viva el *[EFI](http://es.wikipedia.org/wiki/EFI)* (en el macbook a la mano esta en **/dev/sda1**). Puede ser de utilidad [la pagina del wiki de arch sobre macbook](https://wiki.archlinux.org/index.php/Macbook#EFI_2 "EFI y cgdisk").

{% pullquote %}
Llegando al final, en el seccion [Instalación del gestor de arranque](https://wiki.archlinux.org/index.php/Installation_Guide_(Espa%C3%B1ol\)#Instalaci.C3.B3n_del_gestor_de_arranque) veamos que hay un paquete que grub hecho especialmente para utilizar [EFI](http://es.wikipedia.org/wiki/EFI). Pero en realidad {" para arrancar linux en el macbook no necesitamos de grub. "} Así que se puede saltar este paso y [en su lugar vamos a copiar rEFInd al partición de EFI](https://bbs.archlinux.org/viewtopic.php?pid=1151686#p1151686 "Arrancar directamente con rEFInd").
{% endpullquote %}

Primer [obtenga rEFInd](http://www.rodsbooks.com/refind/getting.html "Descargar rEFInd") y descomprimir en *zip*. Luego montar el *[EFI](http://es.wikipedia.org/wiki/EFI)* del mac en algun lugar. Como a este punto en el instalación de archlinux tenemos el *raiz* de la sistema montado en **/mnt** y **/boot** montado en **/mnt/boot** vamos a montar el *[EFI](http://es.wikipedia.org/wiki/EFI)* bajo **/mnt/boot/efi**

{% codeblock %}
# mkdir /mnt/boot/efi
# mount LABEL=EFI /mnt/boot/efi
{% endcodeblock %}

Ahora debe de existir la carpeta *[EFI](http://es.wikipedia.org/wiki/EFI)* bajo **/mnt/boot/efi** y profundizando un nivel mas veremos la carpeta *APPLE* (**/mnt/boot/efi/EFI/APPLE**). Para que el macbook detecta de forma automática nuestra linux, vamos a crear la carpeta **EFI/BOOT** y dentro de ello vamos a copiar rEFInd.

{% codeblock %}
# mkdir /mnt/boot/efi/EFI/BOOT
# cd /ruta/a/refind-bin-${numero_de_version}
# cp -r refind/* /mnt/boot/efi/EFI/BOOT/
# cd /mnt/boot/efi/EFI/BOOT/
# mv refind.conf-sample refind.conf
# mv refind_x64.efi BOOTX64.efi
{% endcodeblock %}

Abrimos refind.conf y quitamos el gato (*#*) del opción "*scan_all_linux_kernels*". Y al final podemos limpiar la carpeta *BOOT*. Si nuestra mac es 64 bit podemos borrar los ficheros con *ia32* en el nombre.

Finalmente creamos el fichero **/boot/refind_linux.conf** con los variables de arranque, por ejemplo:
{% codeblock %}
# echo '"Default" "root=UUID=54b939d6-b59d-4dcb-8311-4b612d2c26dd ro"' > /boot/refind_linux.conf
{% endcodeblock %}
Ahora se puede volver al instalación oficial de archlinux, empezando con la [configuración del sitema](https://wiki.archlinux.org/index.php/Installation_Guide_(Espa%C3%B1ol\)#Configuraci.C3.B3n_del_sistema
"Volver a Instalación de Arch") y seguir lo hasta el final.

Al momento de reiniciar la sistema, se arrancaría en el os de mac. Y, tomando los ejemplos de los indicaciones de instalación de [rEFInd](http://www.rodsbooks.com/refind/ "rEFInd"), primer montamos el *EFI* y después lo *bendecimos*.

{% codeblock %}
$ sudo mkdir /efi
$ sudo mount -t msdos /dev/disk0s1 /efi
$ sudo bless --mount /efi --setBoot --file /efi/EFI/BOOT/refind_x64.efi
{% endcodeblock %}

Ahora reiniciamos de nuevo, y debemos ver un pantalla donde elegimos entre la manzanita o el pinguinito. A veces hay que reiniciar un par de veces para que agarra.

Despues de la [Guía de instalación](https://wiki.archlinux.org/index.php/Installation_Guide_(Espa%C3%B1ol\) "Instalación de Arch"), sigue los pasos de la [Guía de principiantes](https://wiki.archlinux.org/index.php/Beginners%27_Guide/Extra_(Espa%C3%B1ol\) "Guía de Pricipiantes"). Pero como esos son como toques finales, no debe de importarse si se haga antes o después del *bendición* del rEFInd. Al momento de llegar al la configuración de **X**, utiliza los *drivers* propietarios de *nvidia* para no sufrir un lento rendimiento gráfica.

##### Algunas referencias Mas
[macbook pro pure efi +grub](http://plopez.nfshost.com/2011_macbook_air_pure_efi_dual-boot) | [pagina de wiki de arch sobre UEFI](https://wiki.archlinux.org/index.php/Unified_Extensible_Firmware_Interface#Create_an_UEFI_System_Partition_in_Linux) | [install refind con pacman](https://wiki.archlinux.org/index.php/UEFI_Bootloaders#Using_rEFInd) | [sobre rEFInd](http://www.rodsbooks.com/efi-bootloaders/refind.html) | [de la pagina de apple](https://discussions.apple.com/thread/2746152?start=0&tstart=0)
