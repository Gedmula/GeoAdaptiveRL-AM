;FLAVOR:Marlin
;Generated from path with 89 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.800 Y-2.400 W32.000 H8.800 ; print area for bed levelling
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
G0 X5.100 Y4.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.200 Y4.800 E0.00479 F3600
G1 X5.100 Y4.900 E0.00957 F3600
G1 X5.200 Y5.000 E0.01436 F3600
G1 X4.800 Y5.400 E0.03351 F3600
G1 X4.900 Y5.500 E0.03830 F3600
G1 X4.800 Y5.600 E0.04308 F3600
G1 X4.900 Y5.700 E0.04787 F3600
G1 X4.800 Y5.900 E0.05544 F3600
G1 X5.000 Y6.100 E0.06501 F3600
G1 X5.300 Y5.800 E0.07937 F3600
G1 X5.200 Y5.700 E0.08416 F3600
G1 X5.500 Y5.400 E0.09852 F3600
G1 X5.700 Y5.600 E0.10809 F3600
G1 X5.700 Y5.800 E0.11486 F3600
G1 X5.900 Y5.800 E0.12163 F3600
G1 X6.500 Y6.400 E0.15036 F3600
G1 X6.700 Y6.200 E0.15993 F3600
G1 X6.600 Y6.100 E0.16472 F3600
G1 X7.000 Y5.700 E0.18386 F3600
G1 X6.800 Y5.500 E0.19344 F3600
G1 X6.500 Y5.800 E0.20780 F3600
G1 X5.600 Y4.900 E0.25088 F3600
G1 X5.700 Y4.800 E0.25567 F3600
G1 X5.400 Y4.500 E0.27003 F3600
G1 X5.600 Y4.300 E0.27960 F3600
G1 X6.500 Y5.200 E0.32269 F3600
G1 X6.800 Y5.000 E0.33489 F3600
G1 X6.500 Y4.700 E0.34925 F3600
G1 X6.600 Y4.600 E0.35404 F3600
G1 X6.400 Y4.400 E0.36361 F3600
G1 X6.700 Y4.000 E0.38054 F3600
G1 X6.500 Y3.800 E0.39011 F3600
G1 X6.100 Y4.200 E0.40926 F3600
G1 X5.900 Y4.000 E0.41883 F3600
G1 X5.600 Y4.000 E0.42899 F3600
G1 X5.500 Y3.900 E0.43377 F3600
G1 X5.600 Y3.800 E0.43856 F3600
G1 X5.500 Y3.600 E0.44613 F3600
G1 X5.700 Y3.400 E0.45570 F3600
G1 X5.500 Y3.200 E0.46528 F3600
G1 X5.700 Y3.000 E0.47485 F3600
G1 X5.500 Y2.800 E0.48442 F3600
G1 X5.700 Y2.600 E0.49400 F3600
G1 X5.500 Y2.400 E0.50357 F3600
G1 X5.100 Y2.600 E0.51871 F3600
G1 X4.900 Y2.400 E0.52828 F3600
G1 X5.100 Y2.200 E0.53786 F3600
G1 X5.000 Y2.000 E0.54543 F3600
G1 X5.400 Y1.600 E0.56457 F3600
G1 X5.600 Y1.800 E0.57415 F3600
G1 X5.500 Y1.900 E0.57894 F3600
G1 X5.700 Y2.100 E0.58851 F3600
G1 X6.000 Y1.800 E0.60287 F3600
G1 X6.100 Y1.900 E0.60766 F3600
G1 X6.300 Y1.800 E0.61523 F3600
G1 X6.400 Y2.000 E0.62279 F3600
G1 X6.000 Y2.400 E0.64194 F3600
G1 X6.200 Y2.600 E0.65152 F3600
G1 X6.000 Y2.800 E0.66109 F3600
G1 X6.200 Y3.000 E0.67066 F3600
G1 X6.000 Y3.200 E0.68024 F3600
G1 X6.100 Y3.300 E0.68502 F3600
G1 X6.000 Y3.500 E0.69259 F3600
G1 X6.100 Y3.600 E0.69738 F3600
G1 X6.400 Y3.300 E0.71174 F3600
G1 X6.800 Y3.700 E0.73089 F3600
G1 X7.000 Y3.500 E0.74046 F3600
G1 X6.900 Y3.400 E0.74525 F3600
G1 X6.900 Y3.200 E0.75202 F3600
G1 X6.600 Y2.900 E0.76638 F3600
G1 X6.700 Y2.700 E0.77395 F3600
G1 X6.500 Y2.500 E0.78352 F3600
G1 X6.800 Y2.200 E0.79788 F3600
G1 X6.800 Y2.000 E0.80465 F3600
G1 X6.900 Y1.900 E0.80944 F3600
G1 X7.200 Y2.200 E0.82380 F3600
G1 X7.000 Y2.500 E0.83601 F3600
G1 X7.100 Y2.600 E0.84079 F3600
G1 X7.100 Y2.800 E0.84756 F3600
G1 X7.200 Y2.900 E0.85235 F3600
G1 X7.400 Y2.800 E0.85992 F3600
G1 X7.600 Y3.000 E0.86949 F3600
G1 X7.800 Y2.800 E0.87907 F3600
G1 X7.600 Y2.600 E0.88864 F3600
G1 X7.700 Y2.400 E0.89621 F3600
G1 X7.600 Y2.300 E0.90100 F3600
G1 X7.800 Y2.100 E0.91057 F3600
;--- Shutdown ---
G1 E0.21057 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---