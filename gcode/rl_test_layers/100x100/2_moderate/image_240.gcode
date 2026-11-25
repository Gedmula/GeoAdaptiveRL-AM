;FLAVOR:Marlin
;Generated from path with 64 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.200 Y-0.400 W32.000 H7.400 ; print area for bed levelling
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
G0 X2.700 Y3.600 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.800 Y3.700 E0.00479 F3600
G1 X2.700 Y3.800 E0.00957 F3600
G1 X2.900 Y4.000 E0.01915 F3600
G1 X3.100 Y3.800 E0.02872 F3600
G1 X3.400 Y4.100 E0.04308 F3600
G1 X3.000 Y4.600 E0.06476 F3600
G1 X3.000 Y4.900 E0.07491 F3600
G1 X2.500 Y5.400 E0.09885 F3600
G1 X2.400 Y5.400 E0.10223 F3600
G1 X2.200 Y5.200 E0.11180 F3600
G1 X2.400 Y5.000 E0.12138 F3600
G1 X2.500 Y5.100 E0.12617 F3600
G0 X3.100 Y5.300 F9000
G1 X3.200 Y5.200 E0.13095 F3600
G1 X3.500 Y5.500 E0.14531 F3600
G1 X3.600 Y5.400 E0.15010 F3600
G1 X3.800 Y5.500 E0.15767 F3600
G1 X4.000 Y5.300 E0.16724 F3600
G1 X3.400 Y4.800 E0.19368 F3600
G1 X3.800 Y4.300 E0.21535 F3600
G1 X4.000 Y4.500 E0.22493 F3600
G1 X3.900 Y4.600 E0.22971 F3600
G1 X4.100 Y4.800 E0.23929 F3600
G1 X4.200 Y4.700 E0.24407 F3600
G1 X4.400 Y4.900 E0.25365 F3600
G1 X4.300 Y5.000 E0.25844 F3600
G1 X4.500 Y5.200 E0.26801 F3600
G1 X4.300 Y5.400 E0.27758 F3600
G1 X4.300 Y5.500 E0.28097 F3600
G1 X4.700 Y5.700 E0.29611 F3600
G1 X5.600 Y6.600 E0.33919 F3600
G1 X5.500 Y6.700 E0.34398 F3600
G1 X5.600 Y6.900 E0.35154 F3600
G1 X5.800 Y7.000 E0.35911 F3600
G1 X6.000 Y6.900 E0.36668 F3600
G1 X6.100 Y7.000 E0.37147 F3600
G1 X6.300 Y6.800 E0.38104 F3600
G1 X4.800 Y5.200 E0.45528 F3600
G1 X4.800 Y5.000 E0.46205 F3600
G1 X5.000 Y4.800 E0.47162 F3600
G1 X5.200 Y5.000 E0.48120 F3600
G1 X5.300 Y4.900 E0.48598 F3600
G1 X5.500 Y5.100 E0.49556 F3600
G1 X5.400 Y5.200 E0.50034 F3600
G1 X6.100 Y5.900 E0.53385 F3600
G1 X6.200 Y6.200 E0.54456 F3600
G1 X6.400 Y6.400 E0.55413 F3600
G1 X6.600 Y6.200 E0.56370 F3600
G1 X6.500 Y6.100 E0.56849 F3600
G1 X6.600 Y6.000 E0.57328 F3600
G1 X6.600 Y5.800 E0.58005 F3600
G1 X6.400 Y5.700 E0.58762 F3600
G1 X5.700 Y5.000 E0.62113 F3600
G1 X6.000 Y4.800 E0.63333 F3600
G1 X6.100 Y4.900 E0.63812 F3600
G1 X6.500 Y4.600 E0.65504 F3600
G1 X6.700 Y4.800 E0.66462 F3600
G1 X6.400 Y5.100 E0.67898 F3600
G1 X6.400 Y5.200 E0.68236 F3600
G1 X6.700 Y5.500 E0.69672 F3600
G1 X6.800 Y5.400 E0.70151 F3600
G1 X6.800 Y5.200 E0.70828 F3600
;--- Shutdown ---
G1 E0.00828 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---