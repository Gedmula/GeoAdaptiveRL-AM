;FLAVOR:Marlin
;Generated from path with 73 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.100 Y0.100 W32.000 H7.100 ; print area for bed levelling
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
G0 X4.100 Y4.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.200 Y4.200 E0.00479 F3600
G1 X3.900 Y4.500 E0.01915 F3600
G1 X3.600 Y5.100 E0.04185 F3600
G1 X3.100 Y5.700 E0.06829 F3600
G1 X3.200 Y5.800 E0.07308 F3600
G1 X3.100 Y6.000 E0.08065 F3600
G1 X3.300 Y6.100 E0.08822 F3600
G1 X3.700 Y6.500 E0.10736 F3600
G1 X3.800 Y6.400 E0.11215 F3600
G1 X4.000 Y6.600 E0.12172 F3600
G1 X4.200 Y6.400 E0.13130 F3600
G1 X3.500 Y5.800 E0.16251 F3600
G1 X3.900 Y5.400 E0.18165 F3600
G0 X4.000 Y5.300 F9000
G0 X4.000 Y5.100 F9000
G1 X4.200 Y4.900 E0.19123 F3600
G0 X4.300 Y4.800 F9000
G0 X4.500 Y5.300 F9000
G1 X4.600 Y5.400 E0.19601 F3600
G1 X4.200 Y5.800 E0.21516 F3600
G1 X4.500 Y6.100 E0.22952 F3600
G1 X5.000 Y5.300 E0.26146 F3600
G1 X4.800 Y5.100 E0.27103 F3600
G1 X5.000 Y4.900 E0.28060 F3600
G1 X5.100 Y5.000 E0.28539 F3600
G1 X5.200 Y4.900 E0.29018 F3600
G1 X4.800 Y4.500 E0.30932 F3600
G1 X4.700 Y4.500 E0.31271 F3600
G1 X4.500 Y4.700 E0.32228 F3600
G1 X4.200 Y4.500 E0.33449 F3600
G1 X4.500 Y4.200 E0.34885 F3600
G1 X4.600 Y4.300 E0.35364 F3600
G1 E-0.34636 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X6.500 Y6.000 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.35364 F2100 ; unretract
G1 X6.600 Y6.100 E0.35842 F3600
G1 X6.500 Y6.200 E0.36321 F3600
G1 X6.600 Y6.300 E0.36800 F3600
G1 X6.500 Y6.400 E0.37278 F3600
G1 X7.000 Y6.900 E0.39672 F3600
G1 X7.100 Y7.100 E0.40429 F3600
G1 X7.200 Y7.000 E0.40907 F3600
G1 X7.300 Y7.100 E0.41386 F3600
G1 X7.500 Y7.000 E0.42143 F3600
G1 X7.800 Y7.200 E0.43363 F3600
G1 X8.200 Y6.900 E0.45056 F3600
G1 X7.600 Y6.500 E0.47497 F3600
G1 X7.400 Y6.700 E0.48454 F3600
G1 X7.000 Y6.300 E0.50369 F3600
G1 X7.100 Y6.100 E0.51126 F3600
G1 X6.600 Y5.600 E0.53519 F3600
G1 X6.900 Y5.300 E0.54955 F3600
G1 X7.700 Y6.200 E0.59031 F3600
G1 X7.800 Y6.100 E0.59510 F3600
G1 X8.400 Y6.700 E0.62382 F3600
G1 X8.500 Y6.700 E0.62721 F3600
G1 X8.700 Y6.500 E0.63678 F3600
G1 X8.500 Y6.300 E0.64635 F3600
G1 X8.700 Y5.900 E0.66149 F3600
G1 X8.700 Y5.700 E0.66826 F3600
G1 X8.500 Y5.600 E0.67583 F3600
G1 X8.200 Y5.900 E0.69019 F3600
G1 X8.100 Y5.900 E0.69358 F3600
G1 X7.100 Y5.100 E0.73692 F3600
G1 X7.300 Y4.900 E0.74650 F3600
G1 X7.500 Y5.100 E0.75607 F3600
G1 X7.600 Y5.000 E0.76086 F3600
G1 X7.700 Y5.100 E0.76565 F3600
G1 X7.800 Y5.000 E0.77043 F3600
G1 X7.900 Y5.100 E0.77522 F3600
G1 X8.000 Y5.000 E0.78001 F3600
G1 X8.200 Y5.300 E0.79221 F3600
G1 X8.200 Y5.200 E0.79560 F3600
;--- Shutdown ---
G1 E0.09560 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---