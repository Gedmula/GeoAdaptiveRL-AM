;FLAVOR:Marlin
;Generated from path with 94 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.800 Y-0.200 W32.000 H7.200 ; print area for bed levelling
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
G0 X2.900 Y3.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.400 Y4.300 E0.02393 F3600
G1 X2.500 Y4.400 E0.02872 F3600
G1 X2.200 Y4.700 E0.04308 F3600
G1 X2.000 Y5.100 E0.05822 F3600
G1 X2.100 Y5.300 E0.06579 F3600
G1 X1.800 Y5.600 E0.08015 F3600
G1 X1.900 Y5.700 E0.08494 F3600
G1 X1.800 Y5.800 E0.08972 F3600
G1 X2.300 Y6.500 E0.11884 F3600
G1 X2.400 Y6.400 E0.12363 F3600
G1 X2.600 Y6.600 E0.13320 F3600
G1 X2.700 Y6.500 E0.13799 F3600
G1 X2.900 Y6.800 E0.15019 F3600
G1 X3.000 Y6.700 E0.15498 F3600
G1 X3.200 Y6.800 E0.16255 F3600
G1 X3.300 Y6.700 E0.16734 F3600
G1 X3.400 Y6.800 E0.17212 F3600
G1 X3.600 Y6.600 E0.18170 F3600
G1 X3.000 Y6.100 E0.20813 F3600
G1 X2.700 Y6.100 E0.21829 F3600
G1 X2.300 Y5.800 E0.23521 F3600
G1 X2.600 Y5.400 E0.25214 F3600
G1 X2.900 Y5.700 E0.26650 F3600
G1 X3.000 Y5.600 E0.27129 F3600
G1 X3.900 Y6.500 E0.31437 F3600
G1 X4.200 Y6.200 E0.32873 F3600
G1 X3.100 Y5.100 E0.38138 F3600
G1 X3.000 Y5.200 E0.38617 F3600
G1 X2.500 Y4.900 E0.40591 F3600
G1 X2.900 Y4.500 E0.42506 F3600
G1 X3.100 Y4.700 E0.43463 F3600
G1 X3.300 Y4.700 E0.44140 F3600
G1 X4.600 Y6.000 E0.50363 F3600
G1 X4.900 Y5.700 E0.51799 F3600
G1 X3.600 Y4.400 E0.58022 F3600
G1 X3.400 Y4.400 E0.58699 F3600
G1 X3.100 Y4.200 E0.59920 F3600
G1 X3.400 Y3.800 E0.61612 F3600
G1 X3.500 Y3.900 E0.62091 F3600
G1 X3.600 Y3.800 E0.62569 F3600
G1 X3.800 Y4.000 E0.63527 F3600
G1 X4.000 Y3.800 E0.64484 F3600
G1 X4.200 Y3.900 E0.65241 F3600
G1 X4.300 Y3.800 E0.65720 F3600
G1 X4.400 Y4.000 E0.66477 F3600
G1 X4.100 Y4.300 E0.67913 F3600
G1 X5.300 Y5.500 E0.73657 F3600
G1 X5.300 Y5.600 E0.73996 F3600
G1 X5.500 Y5.800 E0.74953 F3600
G1 X5.600 Y5.700 E0.75432 F3600
G1 X6.300 Y6.400 E0.78783 F3600
G1 X6.400 Y6.300 E0.79261 F3600
G1 X6.600 Y6.600 E0.80482 F3600
G1 X6.700 Y6.500 E0.80960 F3600
G1 X7.100 Y6.800 E0.82653 F3600
G1 X7.200 Y6.700 E0.83131 F3600
G1 X7.600 Y7.000 E0.84824 F3600
G1 X7.800 Y6.800 E0.85781 F3600
G1 X7.900 Y6.900 E0.86260 F3600
G1 X8.200 Y6.600 E0.87696 F3600
G1 X8.100 Y6.500 E0.88175 F3600
G1 X8.300 Y6.300 E0.89132 F3600
G1 X8.100 Y6.100 E0.90090 F3600
G1 X8.000 Y6.100 E0.90428 F3600
G1 X7.600 Y6.500 E0.92343 F3600
G1 X7.500 Y6.400 E0.92822 F3600
G1 X7.100 Y6.300 E0.94217 F3600
G1 X6.700 Y5.900 E0.96132 F3600
G1 X6.600 Y6.000 E0.96611 F3600
G1 X6.100 Y5.500 E0.99004 F3600
G1 X5.900 Y5.500 E0.99681 F3600
G1 X5.700 Y5.300 E1.00638 F3600
G1 X5.600 Y5.300 E1.00977 F3600
G1 X4.900 Y4.500 E1.04575 F3600
G1 X5.000 Y4.300 E1.05332 F3600
G1 X4.800 Y4.200 E1.06089 F3600
G1 X5.000 Y4.000 E1.07046 F3600
G0 X5.900 Y4.900 F9000
G1 X6.100 Y5.100 E1.08004 F3600
G1 X6.200 Y5.000 E1.08482 F3600
G1 X6.400 Y5.200 E1.09440 F3600
G1 X6.500 Y5.100 E1.09918 F3600
G1 X6.600 Y5.200 E1.10397 F3600
G1 X6.700 Y5.100 E1.10876 F3600
G1 X6.800 Y5.200 E1.11355 F3600
G1 X6.700 Y5.400 E1.12111 F3600
G1 X6.900 Y5.600 E1.13069 F3600
G1 X7.100 Y5.400 E1.14026 F3600
G1 X7.300 Y5.600 E1.14984 F3600
G1 X7.200 Y5.800 E1.15740 F3600
G1 X7.400 Y6.000 E1.16698 F3600
G1 X7.600 Y5.800 E1.17655 F3600
;--- Shutdown ---
G1 E0.47655 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---