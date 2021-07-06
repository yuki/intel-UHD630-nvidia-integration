# Intell full passthrough
La idea es que la gráfica Intel sea pasada a través de PCI passthrough a la mÃ¡quina virtual, y que actÃºe como si fuese hardware dedicado. Con esto conseguimos hacer uso de la salida HDMI de la grÃ¡fica a un monitor externo.

## Módulos a utilizar
Los ficheros de módulos a utilizar son **/etc/modules** y **/etc/modprobe.d/vfio.conf**  para las configuraciones específicas.

Cargando estos módulos, no tendremos que realizar modificaciones en el arranque del grub ni en el initramfs.

La idea es llegar a poder cargar/quitar los módulos en caliente para así­ no tener que reiniciar.

### Estado del hardware
En Linux el hardware utilizado lo vemos así:
```
# lspci
00:02.0 Display controller: Intel Corporation CometLake-S GT2 [UHD Graphics 630]
```

Y podemos ver más información del mismo a través de:
```
# lspci -vvvs 00:02.0

00:02.0 Display controller: Intel Corporation CometLake-S GT2 [UHD Graphics 630]
	DeviceName: Onboard - Video
	Subsystem: ASUSTeK Computer Inc. UHD Graphics 630 (Desktop)
	Control: I/O- Mem- BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 255
	IOMMU group: 2
	Region 0: Memory at 6013000000 (64-bit, non-prefetchable) [disabled] [size=16M]
	Region 2: Memory at 4000000000 (64-bit, prefetchable) [disabled] [size=256M]
	Region 4: I/O ports at 5000 [disabled] [size=64]
	Capabilities: [40] Vendor Specific Information: Len=0c <?>
	Capabilities: [70] Express (v2) Root Complex Integrated Endpoint, MSI 00
		DevCap:	MaxPayload 128 bytes, PhantFunc 0
			ExtTag- RBE+ FLReset+
		DevCtl:	CorrErr- NonFatalErr- FatalErr- UnsupReq-
			RlxdOrd- ExtTag- PhantFunc- AuxPwr- NoSnoop- FLReset-
			MaxPayload 128 bytes, MaxReadReq 128 bytes
		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
		DevCap2: Completion Timeout: Not Supported, TimeoutDis- NROPrPrP- LTR-
			 10BitTagComp- 10BitTagReq- OBFF Not Supported, ExtFmt- EETLPPrefix-
			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
			 FRS-
			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled,
			 AtomicOpsCtl: ReqEn-
	Capabilities: [ac] MSI: Enable- Count=1/1 Maskable- 64bit-
		Address: 00000000  Data: 0000
	Capabilities: [d0] Power Management version 2
		Flags: PMEClk- DSI+ D1- D2- AuxCurrent=0mA PME(D0-,D1-,D2-,D3hot-,D3cold-)
		Status: D0 NoSoftRst- PME-Enable- DSel=0 DScale=0 PME-
	Capabilities: [100 v1] Process Address Space ID (PASID)
		PASIDCap: Exec- Priv-, Max PASID Width: 14
		PASIDCtl: Enable- Exec- Priv-
	Capabilities: [200 v1] Address Translation Service (ATS)
		ATSCap:	Invalidate Queue Depth: 00
		ATSCtl:	Enable-, Smallest Translation Unit: 00
	Capabilities: [300 v1] Page Request Interface (PRI)
		PRICtl: Enable- Reset-
		PRISta: RF- UPRGI- Stopped+
		Page Request Capacity: 00008000, Page Request Allocation: 00000000
	Kernel driver in use: vfio-pci
	Kernel modules: i915
```

## Máquina virtual
El fichero **ubuntu-full-passthrough.sh** contiene una configuración básica para arrancar una ISO de ubuntu 20.04 y hacer uso de la gráfica intel.

Al principio del script creamos un dispositivo **tap0** que hará uso de un bridge creado previamente vmbr0 de la tarjeta de red.

Lo importante es la parte:
```
-device vfio-pci,host=00:02.0 -nographic -vga none
```
donde se le indica la gráfica Intel que se le pasa como pci a la máquina virtual.
