;FLAVOR:Marlin
;Generated from path with 83 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.300 Y-2.500 W32.000 H9.200 ; print area for bed levelling
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
G0 X4.300 Y4.000 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.500 Y3.800 E0.00957 F3600
G1 X4.600 Y3.900 E0.01436 F3600
G1 X4.900 Y3.500 E0.03129 F3600
G1 X5.200 Y3.800 E0.04565 F3600
G1 X5.200 Y3.900 E0.04903 F3600
G1 X5.500 Y4.300 E0.06596 F3600
G1 X5.900 Y3.900 E0.08510 F3600
G1 X5.200 Y3.200 E0.11861 F3600
G1 X5.400 Y3.000 E0.12819 F3600
G1 X5.500 Y3.000 E0.13157 F3600
G1 X6.200 Y3.700 E0.16508 F3600
G1 X6.400 Y3.500 E0.17465 F3600
G1 X6.000 Y3.000 E0.19633 F3600
G1 X6.100 Y2.900 E0.20111 F3600
G1 X5.700 Y2.600 E0.21804 F3600
G1 X5.900 Y2.400 E0.22761 F3600
G1 X6.200 Y2.600 E0.23982 F3600
G1 X6.400 Y2.400 E0.24939 F3600
G1 X5.800 Y1.900 E0.27583 F3600
G1 X6.100 Y1.600 E0.29019 F3600
G1 X6.300 Y1.700 E0.29776 F3600
G1 X6.500 Y1.500 E0.30733 F3600
G1 X6.700 Y1.700 E0.31690 F3600
G1 X6.500 Y1.900 E0.32648 F3600
G1 X6.700 Y2.100 E0.33605 F3600
G1 X6.900 Y1.900 E0.34563 F3600
G1 X7.100 Y2.100 E0.35520 F3600
G1 X7.100 Y2.200 E0.35858 F3600
G1 X6.900 Y2.400 E0.36816 F3600
G1 X7.000 Y2.500 E0.37295 F3600
G1 X6.900 Y2.600 E0.37773 F3600
G1 X7.000 Y2.700 E0.38252 F3600
G1 X6.900 Y2.800 E0.38731 F3600
G1 X7.100 Y3.000 E0.39688 F3600
G1 X7.000 Y3.100 E0.40167 F3600
G1 X7.200 Y3.300 E0.41124 F3600
G1 X7.400 Y3.300 E0.41801 F3600
G1 X7.600 Y3.500 E0.42758 F3600
G1 X7.700 Y3.500 E0.43097 F3600
G1 X7.900 Y3.300 E0.44054 F3600
G1 X8.000 Y3.400 E0.44533 F3600
G1 X8.300 Y3.100 E0.45969 F3600
G1 X8.100 Y2.900 E0.46927 F3600
G1 X8.300 Y2.700 E0.47884 F3600
G1 X8.200 Y2.600 E0.48363 F3600
G1 X8.300 Y2.500 E0.48841 F3600
G1 X8.200 Y2.400 E0.49320 F3600
G1 X8.000 Y2.400 E0.49997 F3600
G1 X7.500 Y2.900 E0.52390 F3600
G1 X7.300 Y2.700 E0.53348 F3600
G1 X7.400 Y2.600 E0.53827 F3600
G1 X7.300 Y2.500 E0.54305 F3600
G1 X7.500 Y2.300 E0.55263 F3600
G1 X7.400 Y2.200 E0.55741 F3600
G1 X7.600 Y2.000 E0.56699 F3600
G1 X7.700 Y2.100 E0.57177 F3600
G1 X7.800 Y2.000 E0.57656 F3600
G1 X8.000 Y2.200 E0.58613 F3600
G1 X8.100 Y2.100 E0.59092 F3600
G1 E-0.10908 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X8.200 Y2.000 F9000
G0 X6.800 Y5.500 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.59092 F2100 ; unretract
G1 X6.800 Y5.600 E0.59431 F3600
G1 X6.400 Y6.000 E0.61345 F3600
G1 X6.400 Y6.100 E0.61684 F3600
G1 X6.600 Y6.300 E0.62641 F3600
G1 X6.700 Y6.200 E0.63120 F3600
G1 X7.200 Y6.700 E0.65513 F3600
G1 X7.400 Y6.500 E0.66471 F3600
G1 X7.500 Y6.600 E0.66950 F3600
G1 X7.700 Y6.400 E0.67907 F3600
G1 X7.500 Y6.200 E0.68864 F3600
G1 X7.400 Y6.300 E0.69343 F3600
G1 X7.200 Y6.100 E0.70300 F3600
G1 X7.100 Y6.100 E0.70639 F3600
G1 X7.000 Y6.000 E0.71118 F3600
G1 X7.100 Y5.900 E0.71596 F3600
G1 X7.000 Y5.800 E0.72075 F3600
G1 X7.300 Y5.500 E0.73511 F3600
G1 X7.500 Y5.700 E0.74468 F3600
G1 X7.600 Y5.600 E0.74947 F3600
G1 X7.700 Y5.800 E0.75704 F3600
;--- Shutdown ---
G1 E0.05704 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---