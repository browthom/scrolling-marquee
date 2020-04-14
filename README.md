# scrolling-marquee
VHDL model for implementation on a Digilent Basys 3 Artix-7 development board. This VHDL design will display a name to the seven segment LED display and scroll the letters across the 4 segments every 0.5 seconds. After every letter has scrolled through the segments, the LED segments will go dark for 2 seconds and then the scrolling process will resume again. If BTNC is pressed and held, the scrolling will pause.

_The browthom/vhdl-user-component-dir repository must be imported into the Vivado project as a directory. This is done so that the top_level.vhd file can properly instantiate all components listed in its vhdl model._
