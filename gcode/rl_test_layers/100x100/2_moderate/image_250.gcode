;FLAVOR:Marlin
;Generated from path with 89 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.300 Y0.300 W32.000 H6.800 ; print area for bed levelling
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
G0 X3.600 Y5.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.300 Y5.400 E0.01436 F3600
G1 X3.400 Y5.500 E0.01915 F3600
G1 X3.300 Y5.600 E0.02393 F3600
G1 X3.600 Y5.900 E0.03830 F3600
G1 X3.800 Y6.000 E0.04586 F3600
G1 X4.000 Y5.800 E0.05544 F3600
G1 X3.700 Y5.500 E0.06980 F3600
G1 X4.000 Y5.200 E0.08416 F3600
G1 X4.300 Y5.600 E0.10108 F3600
G1 X4.400 Y5.500 E0.10587 F3600
G0 X4.500 Y5.400 F9000
G0 X5.700 Y5.700 F9000
G1 X6.100 Y6.100 E0.12502 F3600
G1 X6.000 Y6.200 E0.12981 F3600
G1 X6.200 Y6.400 E0.13938 F3600
G1 X6.100 Y6.500 E0.14417 F3600
G1 X6.200 Y6.600 E0.14895 F3600
G1 X6.100 Y6.700 E0.15374 F3600
G1 X6.200 Y6.800 E0.15853 F3600
G1 X6.400 Y6.600 E0.16810 F3600
G1 X6.500 Y6.600 E0.17149 F3600
G1 X6.800 Y6.800 E0.18369 F3600
G1 X6.900 Y6.700 E0.18848 F3600
G1 X7.200 Y7.000 E0.20284 F3600
G1 X7.300 Y6.900 E0.20763 F3600
G1 X7.500 Y7.100 E0.21720 F3600
G1 X7.700 Y6.900 E0.22677 F3600
G1 X7.900 Y7.100 E0.23635 F3600
G1 X8.000 Y7.000 E0.24113 F3600
G1 X8.100 Y7.100 E0.24592 F3600
G1 X8.300 Y6.900 E0.25549 F3600
G1 X8.400 Y7.000 E0.26028 F3600
G1 X8.700 Y6.700 E0.27464 F3600
G1 X8.600 Y6.600 E0.27943 F3600
G1 X8.700 Y6.500 E0.28422 F3600
G1 X8.500 Y6.300 E0.29379 F3600
G1 X8.400 Y6.300 E0.29718 F3600
G1 X8.000 Y6.700 E0.31632 F3600
G1 X7.700 Y6.400 E0.33068 F3600
G1 X7.500 Y6.600 E0.34026 F3600
G1 X7.000 Y6.200 E0.36193 F3600
G1 X6.800 Y6.300 E0.36950 F3600
G1 X5.900 Y5.300 E0.41504 F3600
G1 X6.100 Y5.100 E0.42461 F3600
G1 X6.200 Y5.100 E0.42800 F3600
G1 X7.300 Y6.100 E0.47832 F3600
G1 X7.400 Y6.100 E0.48170 F3600
G1 X7.600 Y5.900 E0.49128 F3600
G1 X7.900 Y6.200 E0.50564 F3600
G1 X8.200 Y5.900 E0.52000 F3600
G1 X7.800 Y5.400 E0.54167 F3600
G1 X7.700 Y5.500 E0.54646 F3600
G1 X7.600 Y5.400 E0.55125 F3600
G1 X7.400 Y5.600 E0.56082 F3600
G1 X6.800 Y5.000 E0.58954 F3600
G1 X6.600 Y5.000 E0.59631 F3600
G1 X6.300 Y4.700 E0.61067 F3600
G1 X6.500 Y4.500 E0.62025 F3600
G1 X6.600 Y4.600 E0.62503 F3600
G1 X6.800 Y4.600 E0.63180 F3600
G1 X6.900 Y4.500 E0.63659 F3600
G1 X7.100 Y4.600 E0.64416 F3600
G1 X7.300 Y4.400 E0.65373 F3600
G1 X7.500 Y4.600 E0.66331 F3600
G1 X7.300 Y4.800 E0.67288 F3600
G1 X7.400 Y5.000 E0.68045 F3600
G1 X7.500 Y5.100 E0.68524 F3600
G1 X7.700 Y4.900 E0.69481 F3600
G1 X7.800 Y4.900 E0.69819 F3600
G1 X8.300 Y5.400 E0.72213 F3600
G1 X8.400 Y5.700 E0.73283 F3600
G1 X8.700 Y6.000 E0.74719 F3600
G1 X8.800 Y5.900 E0.75198 F3600
G1 X8.700 Y5.800 E0.75677 F3600
G1 X8.800 Y5.700 E0.76156 F3600
G1 X8.700 Y5.600 E0.76634 F3600
G1 X8.800 Y5.500 E0.77113 F3600
G1 X8.700 Y5.400 E0.77592 F3600
G1 X8.800 Y5.300 E0.78070 F3600
G1 X8.700 Y5.200 E0.78549 F3600
G1 X8.800 Y5.000 E0.79306 F3600
G1 X8.700 Y4.900 E0.79785 F3600
G1 X8.600 Y5.000 E0.80263 F3600
G1 X8.500 Y4.900 E0.80742 F3600
G1 X8.300 Y4.900 E0.81419 F3600
G1 X7.700 Y4.300 E0.84291 F3600
G1 X7.800 Y4.400 E0.84770 F3600
;--- Shutdown ---
G1 E0.14770 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---