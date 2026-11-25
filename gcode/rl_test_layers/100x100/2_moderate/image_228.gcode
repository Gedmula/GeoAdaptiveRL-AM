;FLAVOR:Marlin
;Generated from path with 83 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.300 Y0.500 W32.000 H6.800 ; print area for bed levelling
M140 S60.0         ; set bed temp
M104 S170.0        ; nozzle to bed-levelling temp (does not ooze)
M109 R170.0        ; wait for bed-levelling temp
M84 E                    ; turn off E motor
G28                      ; home all without mesh bed level
G1 X42 Y-4 Z5 F4800
M302 S160                ; lower cold extrusion limit to 160C
G92 E0                   ; reset extruder
G1 E-2 F2400             ; retraction
M84 E                    ; turn off E motor
G29 P9 X10 Y-4 W32 H4    ; clean the nozzle
M106 S100                ; fan on while the bed heats
G0 Z40 F10000
M190 S60.0         ; wait for bed temp
M107                     ; fan off
;--- Bed Levelling ---
M84 E                    ; turn off E motor
G29 P1                   ; invalidate mbl & probe print area
G29 P1 X0 Y0 W50 H20 C   ; probe near purge place
G29 P3.2                 ; interpolate mbl probes
G29 P3.13                ; extrapolate mbl outside probe area
G29 A                    ; activate mbl
;--- Purge Line ---
M104 S200.0      ; set extruder temp
G0 X0 Y-4 Z15 F4800      ; move away and ready for the purge
M109 S200.0      ; wait for extruder temp
M569 S0 E                ; set spreadcycle mode for extruder
G92 E0                   ; reset extruder
G1 E2 F2400              ; de-retract (undoes the retraction before probing)
G1 X15 Z0.2 E9 F500      ; purge
G1 X25 E13 F500          ; purge
G1 X35 E17 F650          ; purge
G1 X45 E21 F800          ; purge
G1 X48 Z0.05 F8000       ; wipe, move close to the bed
G1 X51 Z0.2 F8000        ; wipe, move quickly away from the bed
G92 E0                   ; reset extruder
M221 S100                ; set flow to 100%
G1 E-0.70000 F2100 ; retract
G1 Z0.400 F9000 ; lift
;--- Main Path ---
G0 X3.800 Y4.600 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.400 Y5.000 E0.01915 F3600
G1 X3.600 Y5.200 E0.02872 F3600
G1 X3.300 Y5.600 E0.04565 F3600
G1 X3.400 Y5.700 E0.05043 F3600
G1 X3.300 Y5.800 E0.05522 F3600
G1 X3.400 Y5.900 E0.06001 F3600
G1 X3.300 Y6.000 E0.06479 F3600
G1 X3.500 Y6.200 E0.07437 F3600
G1 X3.400 Y6.300 E0.07915 F3600
G1 X3.500 Y6.400 E0.08394 F3600
G1 X3.400 Y6.600 E0.09151 F3600
G1 X3.800 Y7.000 E0.11066 F3600
G0 X3.800 Y7.200 F9000
G1 X3.900 Y7.300 E0.11545 F3600
G1 X4.100 Y7.100 E0.12502 F3600
G0 X4.200 Y7.000 F9000
G0 X4.100 Y6.900 F9000
G1 X4.100 Y6.800 E0.12840 F3600
G1 X3.800 Y6.500 E0.14276 F3600
G1 X4.100 Y6.200 E0.15713 F3600
G1 X3.700 Y5.800 E0.17627 F3600
G1 X4.000 Y5.500 E0.19063 F3600
G1 X4.600 Y6.100 E0.21936 F3600
G1 X4.400 Y6.300 E0.22893 F3600
G1 X4.400 Y6.500 E0.23570 F3600
G1 X4.600 Y6.900 E0.25084 F3600
G1 X4.900 Y6.700 E0.26304 F3600
G1 X4.800 Y6.600 E0.26783 F3600
G1 X4.900 Y6.400 E0.27540 F3600
G1 X5.200 Y6.700 E0.28976 F3600
G1 X5.500 Y6.400 E0.30412 F3600
G1 X4.300 Y5.200 E0.36156 F3600
G1 X4.100 Y5.200 E0.36833 F3600
G1 X3.900 Y5.000 E0.37791 F3600
G1 X4.300 Y4.600 E0.39705 F3600
G1 X4.400 Y4.700 E0.40184 F3600
G1 X4.500 Y4.600 E0.40663 F3600
G1 X4.600 Y4.700 E0.41141 F3600
G1 X4.600 Y4.900 E0.41818 F3600
G1 X5.800 Y6.100 E0.47563 F3600
G1 X5.900 Y6.300 E0.48320 F3600
G1 X6.100 Y6.100 E0.49277 F3600
G1 X6.900 Y6.900 E0.53107 F3600
G1 X7.000 Y6.800 E0.53585 F3600
G1 X7.200 Y7.000 E0.54543 F3600
G1 X7.400 Y6.800 E0.55500 F3600
G1 X7.500 Y6.900 E0.55979 F3600
G1 X8.100 Y6.300 E0.58851 F3600
G1 X7.800 Y6.000 E0.60287 F3600
G1 X7.300 Y6.500 E0.62680 F3600
G1 X7.200 Y6.400 E0.63159 F3600
G1 X7.000 Y6.400 E0.63836 F3600
G1 X6.200 Y5.600 E0.67666 F3600
G1 X6.000 Y5.700 E0.68423 F3600
G1 X5.200 Y4.900 E0.72252 F3600
G1 X5.100 Y4.900 E0.72591 F3600
G1 X4.900 Y4.700 E0.73548 F3600
G1 X5.000 Y4.600 E0.74027 F3600
G0 X5.100 Y4.500 F9000
G0 X6.000 Y5.100 F9000
G1 X6.100 Y5.200 E0.74505 F3600
G1 X6.400 Y5.100 E0.75576 F3600
G1 X7.200 Y5.900 E0.79405 F3600
G1 X7.300 Y5.900 E0.79744 F3600
G1 X7.500 Y5.700 E0.80701 F3600
G1 X6.700 Y4.800 E0.84777 F3600
G1 X7.000 Y4.500 E0.86213 F3600
G1 X7.200 Y4.600 E0.86970 F3600
G1 X7.300 Y4.500 E0.87449 F3600
G1 X7.500 Y4.700 E0.88406 F3600
G1 X7.400 Y4.800 E0.88885 F3600
G1 X7.500 Y4.900 E0.89364 F3600
G1 X7.400 Y5.000 E0.89842 F3600
G1 X7.500 Y5.200 E0.90599 F3600
G1 X8.100 Y5.900 E0.93720 F3600
G1 X8.200 Y5.700 E0.94477 F3600
G1 X8.000 Y5.500 E0.95434 F3600
G1 X8.100 Y5.400 E0.95913 F3600
G1 X8.000 Y5.300 E0.96392 F3600
G1 X8.100 Y5.200 E0.96870 F3600
G1 X8.000 Y5.000 E0.97627 F3600
;--- Shutdown ---
G1 E0.27627 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---