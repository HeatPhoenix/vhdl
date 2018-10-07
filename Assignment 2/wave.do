view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue 0 -period 10ns -dutycycle 5 -starttime 0ns -endtime 1000ns sim:/async_dff/clk 
wave create -driver freeze -pattern clock -initialvalue 0 -period 10ns -dutycycle 5 -starttime 0ns -endtime 1000ns sim:/async_dff/clk 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 1000ns sim:/async_dff/reset 
wave create -driver freeze -pattern constant -value 0 -starttime 0ns -endtime 1000ns sim:/async_dff/D 
wave modify -driver freeze -pattern clock -initialvalue 0 -period 100ns -dutycycle 50 -starttime 0ns -endtime 1000ns Edit:/async_dff/clk 
wave edit insert_pulse -duration 100ns -time 200ns Edit:/async_dff/reset 
wave edit insert_pulse -duration 100ns -time 150ns Edit:/async_dff/D 
wave edit insert_pulse -duration 100ns -time 400ns Edit:/async_dff/D 
wave edit insert_pulse -duration 100ns -time 500ns Edit:/async_dff/D 
wave edit insert_pulse -duration 100ns -time 500ns Edit:/async_dff/D 
wave edit insert_pulse -duration 100ns -time 500ns Edit:/async_dff/D 
wave edit insert_pulse -duration 100ns -time 650ns Edit:/async_dff/D 
wave edit insert_pulse -duration 100ns -time 700ns Edit:/async_dff/reset 
wave edit insert_pulse -duration 100ns -time 750ns Edit:/async_dff/D 
wave edit stretch_edge -forward 100ns -time 750ns Edit:/async_dff/D 
wave edit stretch_edge -forward 100ns -time 850ns Edit:/async_dff/D 
WaveCollapseAll -1
wave clipboard restore
