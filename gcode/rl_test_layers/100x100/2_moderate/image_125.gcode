;FLAVOR:Marlin
;Generated from path with 77 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.700 Y-2.000 W32.000 H8.100 ; print area for bed levelling
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
G0 X3.200 Y3.200 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.700 Y3.700 E0.02393 F3600
G1 X3.500 Y4.500 E0.06223 F3600
G1 X3.300 Y4.800 E0.07443 F3600
G1 X3.300 Y5.100 E0.08459 F3600
G1 X3.100 Y5.300 E0.09416 F3600
G1 X3.300 Y5.500 E0.10374 F3600
G1 X3.500 Y5.400 E0.11131 F3600
G1 X3.600 Y5.500 E0.11609 F3600
G1 X3.800 Y5.300 E0.12567 F3600
G1 X3.600 Y5.100 E0.13524 F3600
G1 X3.800 Y4.900 E0.14481 F3600
G1 X4.900 Y6.100 E0.19992 F3600
G1 X5.200 Y5.800 E0.21428 F3600
G1 X3.900 Y4.500 E0.27651 F3600
G1 X4.000 Y4.400 E0.28129 F3600
G1 X3.300 Y3.700 E0.31480 F3600
G1 X3.600 Y3.400 E0.32916 F3600
G1 X4.400 Y4.200 E0.36746 F3600
G1 X4.400 Y4.300 E0.37084 F3600
G1 X5.200 Y5.100 E0.40914 F3600
G1 X5.200 Y5.200 E0.41252 F3600
G1 X5.400 Y5.400 E0.42210 F3600
G1 X5.700 Y5.100 E0.43646 F3600
G1 X5.900 Y5.300 E0.44603 F3600
G1 X6.000 Y5.200 E0.45082 F3600
G1 X6.300 Y5.300 E0.46152 F3600
G1 X6.500 Y5.100 E0.47110 F3600
G1 X6.400 Y5.000 E0.47589 F3600
G1 X6.500 Y4.900 E0.48067 F3600
G1 X6.300 Y4.700 E0.49025 F3600
G1 X6.200 Y4.800 E0.49503 F3600
G1 X6.100 Y4.700 E0.49982 F3600
G1 X6.000 Y4.800 E0.50461 F3600
G1 X5.900 Y4.700 E0.50939 F3600
G1 X5.500 Y4.800 E0.52335 F3600
G1 X4.700 Y4.000 E0.56165 F3600
G1 X4.700 Y3.900 E0.56503 F3600
G1 X3.500 Y2.800 E0.62013 F3600
G1 X3.600 Y2.700 E0.62492 F3600
G1 X3.500 Y2.500 E0.63249 F3600
G1 X3.600 Y2.300 E0.64006 F3600
G1 X3.800 Y2.100 E0.64963 F3600
G1 X4.100 Y2.400 E0.66399 F3600
G1 X4.000 Y2.600 E0.67156 F3600
G1 X5.700 Y4.300 E0.75294 F3600
G1 X5.900 Y4.200 E0.76051 F3600
G1 X6.100 Y4.400 E0.77008 F3600
G1 X6.200 Y4.400 E0.77347 F3600
G1 X6.300 Y4.300 E0.77825 F3600
G1 X6.200 Y4.200 E0.78304 F3600
G1 X6.300 Y4.100 E0.78783 F3600
G1 X6.100 Y3.900 E0.79740 F3600
G1 X6.000 Y3.900 E0.80079 F3600
G1 X4.900 Y2.800 E0.85344 F3600
G1 X4.700 Y2.800 E0.86021 F3600
G1 X4.400 Y2.500 E0.87457 F3600
G1 X4.500 Y2.400 E0.87936 F3600
G1 X4.600 Y2.500 E0.88415 F3600
G1 X4.800 Y2.300 E0.89372 F3600
G1 X4.900 Y2.400 E0.89851 F3600
G1 X5.300 Y2.000 E0.91766 F3600
G1 X5.400 Y2.100 E0.92244 F3600
G1 X5.500 Y2.000 E0.92723 F3600
G1 X5.700 Y2.200 E0.93680 F3600
G1 X5.300 Y2.600 E0.95595 F3600
G1 X5.600 Y2.900 E0.97031 F3600
G1 X5.800 Y2.700 E0.97989 F3600
G1 X6.000 Y2.900 E0.98946 F3600
G1 X5.900 Y3.100 E0.99703 F3600
G1 X6.000 Y3.200 E1.00182 F3600
G1 X6.000 Y3.400 E1.00858 F3600
G1 X6.400 Y3.800 E1.02773 F3600
G1 X6.700 Y3.500 E1.04209 F3600
G1 X6.700 Y3.300 E1.04886 F3600
G1 X6.600 Y3.300 E1.05225 F3600
;--- Shutdown ---
G1 E0.35225 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---