# Introducción

La idea de este repositorio es tener unas configuraciones que integran una gráfica 
Intel UHD630 con una tarjeta gráfica Nvidia.

Todas las configuraciones se realizarán en una** Debian Testing (11.0)**.

Las integraciones o configuraciones que se quieren conseguir son:
 - [PCI passthrough de la gráfica Intel a una máquina virtual qemu](i915_passthrough)
 - PCI passthrough de la gráfica Nvidia a una máquina virtual qemu
 - Hacer uso de la gráfica Intel virtualizada usando GVT-g
 - Usar ambas gráficas en el mismo escritorio(xinerama)

Cada configuración tendrá su directorio dedicado donde se indicará los módulos utilizados
y configuraciones oportunas de la placa base en caso de ser necesario


Hardware utilizado para estas pruebas:
 - **Placa base**: Asus PRIME B360M-A
 - **Procesador**: Intel i5-9400 (UHD630 integrada)
 - **Gráfica**: Nvidia RTX 2060 Super
 - **RAM**: 16GB
 - 2 monitores:
   - HDMI conectado a la placa base (salida Intel)
   - HDMI conectado a Nvidia
