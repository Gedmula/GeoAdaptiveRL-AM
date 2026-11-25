;FLAVOR:Marlin
;Generated from path with 60 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X5.700 Y-0.100 W32.000 H6.500 ; print area for bed levelling
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
G0 X5.700 Y5.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.900 Y5.500 E0.00957 F3600
G1 X5.800 Y5.600 E0.01436 F3600
G1 X6.000 Y5.800 E0.02393 F3600
G1 X5.900 Y5.900 E0.02872 F3600
G1 X6.400 Y6.400 E0.05266 F3600
G1 X6.600 Y6.300 E0.06023 F3600
G1 X6.700 Y6.400 E0.06501 F3600
G1 X6.800 Y6.300 E0.06980 F3600
G1 X7.000 Y6.400 E0.07737 F3600
G1 X7.200 Y6.200 E0.08694 F3600
G1 X7.400 Y6.400 E0.09652 F3600
G1 X7.700 Y6.100 E0.11088 F3600
G1 X7.700 Y6.000 E0.11426 F3600
G1 X7.600 Y5.900 E0.11905 F3600
G1 X7.500 Y6.000 E0.12384 F3600
G1 X7.200 Y5.700 E0.13820 F3600
G1 X6.700 Y6.100 E0.15987 F3600
G1 X6.400 Y5.800 E0.17423 F3600
G1 X6.500 Y5.700 E0.17902 F3600
G1 X6.300 Y5.500 E0.18859 F3600
G1 X6.300 Y5.400 E0.19198 F3600
G1 X5.800 Y4.900 E0.21591 F3600
G1 X5.900 Y4.800 E0.22070 F3600
G1 X5.800 Y4.700 E0.22549 F3600
G1 X6.100 Y4.300 E0.24241 F3600
G1 X6.000 Y4.200 E0.24720 F3600
G1 X6.300 Y3.900 E0.26156 F3600
G1 X6.400 Y4.000 E0.26634 F3600
G1 X6.600 Y3.900 E0.27391 F3600
G1 X6.800 Y4.100 E0.28349 F3600
G1 X6.300 Y4.600 E0.30742 F3600
G1 X6.400 Y4.700 E0.31221 F3600
G1 X6.300 Y4.800 E0.31700 F3600
G1 X6.900 Y5.500 E0.34820 F3600
G1 X7.200 Y5.200 E0.36256 F3600
G1 X6.800 Y4.800 E0.38171 F3600
G1 X7.000 Y4.600 E0.39129 F3600
G1 X7.100 Y4.600 E0.39467 F3600
G1 X7.500 Y5.000 E0.41382 F3600
G1 X7.500 Y5.400 E0.42736 F3600
G1 X7.800 Y5.700 E0.44172 F3600
G1 X7.900 Y5.600 E0.44651 F3600
G1 X7.800 Y5.500 E0.45129 F3600
G1 X8.000 Y5.300 E0.46087 F3600
G1 X7.900 Y5.200 E0.46565 F3600
G1 X8.000 Y5.100 E0.47044 F3600
G1 X7.800 Y4.900 E0.48001 F3600
G1 X7.900 Y4.800 E0.48480 F3600
G1 X7.700 Y4.600 E0.49437 F3600
G1 X7.800 Y4.500 E0.49916 F3600
G1 X7.700 Y4.400 E0.50395 F3600
G1 X7.600 Y4.500 E0.50874 F3600
G1 X7.500 Y4.400 E0.51352 F3600
G1 X7.300 Y4.400 E0.52029 F3600
G1 X7.000 Y4.100 E0.53465 F3600
G1 X7.200 Y3.900 E0.54423 F3600
G1 X7.400 Y3.900 E0.55100 F3600
G1 X7.500 Y4.000 E0.55578 F3600
;--- Shutdown ---
G1 E-0.14422 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---