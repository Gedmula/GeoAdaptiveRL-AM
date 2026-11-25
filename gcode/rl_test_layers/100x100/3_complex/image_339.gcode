;FLAVOR:Marlin
;Generated from path with 92 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.700 Y-1.100 W32.000 H7.800 ; print area for bed levelling
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
G0 X4.800 Y4.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.900 Y4.900 E0.00479 F3600
G1 X4.700 Y5.200 E0.01699 F3600
G1 X4.800 Y5.300 E0.02178 F3600
G1 X4.700 Y5.400 E0.02657 F3600
G1 X4.800 Y5.500 E0.03135 F3600
G1 X4.700 Y5.600 E0.03614 F3600
G1 X4.900 Y5.800 E0.04571 F3600
G1 X5.100 Y6.200 E0.06085 F3600
G1 X5.300 Y6.400 E0.07042 F3600
G1 X5.400 Y6.300 E0.07521 F3600
G1 X5.900 Y6.700 E0.09689 F3600
G1 X6.000 Y6.600 E0.10167 F3600
G1 X6.200 Y6.700 E0.10924 F3600
G1 X6.300 Y6.600 E0.11403 F3600
G1 X6.400 Y6.700 E0.11881 F3600
G1 X6.600 Y6.500 E0.12839 F3600
G1 X6.700 Y6.600 E0.13318 F3600
G1 X7.200 Y6.100 E0.15711 F3600
G1 X7.000 Y5.900 E0.16668 F3600
G1 X6.800 Y5.900 E0.17345 F3600
G1 X6.500 Y6.200 E0.18781 F3600
G1 X6.400 Y6.100 E0.19260 F3600
G1 X6.300 Y6.200 E0.19739 F3600
G1 X6.200 Y6.100 E0.20218 F3600
G1 X6.000 Y6.200 E0.20974 F3600
G1 X5.800 Y6.000 E0.21932 F3600
G1 X5.600 Y6.000 E0.22609 F3600
G1 X5.400 Y5.800 E0.23566 F3600
G1 X5.500 Y5.700 E0.24045 F3600
G1 X5.400 Y5.600 E0.24524 F3600
G1 X5.300 Y5.700 E0.25002 F3600
G1 X5.100 Y5.500 E0.25960 F3600
G1 X5.300 Y5.300 E0.26917 F3600
G1 X5.300 Y5.100 E0.27594 F3600
G1 X5.500 Y4.900 E0.28551 F3600
G1 X5.000 Y4.500 E0.30719 F3600
G1 X5.400 Y4.100 E0.32634 F3600
G1 X5.500 Y4.200 E0.33112 F3600
G1 X5.700 Y4.000 E0.34070 F3600
G1 X5.900 Y4.200 E0.35027 F3600
G1 X5.700 Y4.400 E0.35984 F3600
G1 X5.700 Y4.500 E0.36323 F3600
G1 X5.900 Y4.700 E0.37280 F3600
G1 X6.100 Y4.500 E0.38238 F3600
G1 X6.300 Y4.700 E0.39195 F3600
G1 X6.400 Y4.700 E0.39534 F3600
G1 X6.900 Y5.200 E0.41927 F3600
G1 X6.700 Y5.400 E0.42884 F3600
G1 X6.900 Y5.600 E0.43842 F3600
G1 X7.000 Y5.500 E0.44321 F3600
G1 X7.300 Y5.800 E0.45757 F3600
G1 X7.600 Y5.500 E0.47193 F3600
G1 X7.800 Y5.600 E0.47950 F3600
G1 X8.000 Y5.400 E0.48907 F3600
G1 X7.900 Y5.300 E0.49386 F3600
G1 X8.000 Y5.200 E0.49864 F3600
G1 X7.800 Y5.000 E0.50822 F3600
G1 X7.600 Y5.000 E0.51499 F3600
G1 X7.400 Y5.200 E0.52456 F3600
G1 X7.200 Y5.000 E0.53414 F3600
G1 X7.200 Y4.900 E0.53752 F3600
G1 X7.500 Y4.600 E0.55188 F3600
G1 X7.300 Y4.400 E0.56145 F3600
G1 X7.000 Y4.600 E0.57366 F3600
G1 X6.800 Y4.600 E0.58043 F3600
G1 X6.600 Y4.500 E0.58800 F3600
G1 X6.100 Y4.000 E0.61193 F3600
G1 X6.200 Y3.900 E0.61672 F3600
G1 X6.400 Y4.100 E0.62629 F3600
G1 X6.500 Y4.000 E0.63108 F3600
G1 X6.800 Y4.300 E0.64544 F3600
G1 X7.000 Y4.100 E0.65501 F3600
G1 X7.100 Y4.200 E0.65980 F3600
G1 X7.400 Y3.900 E0.67416 F3600
G1 X7.100 Y3.600 E0.68852 F3600
G1 X7.200 Y3.400 E0.69609 F3600
G1 X7.600 Y3.000 E0.71524 F3600
G1 X7.700 Y3.100 E0.72003 F3600
G1 X7.900 Y2.900 E0.72960 F3600
G1 X8.100 Y3.100 E0.73917 F3600
G1 X7.900 Y3.300 E0.74875 F3600
G1 X8.000 Y3.400 E0.75354 F3600
G1 X8.100 Y3.300 E0.75832 F3600
G1 X8.200 Y3.400 E0.76311 F3600
G1 X8.300 Y3.300 E0.76790 F3600
G1 X8.500 Y3.500 E0.77747 F3600
G1 X8.400 Y3.600 E0.78226 F3600
G1 X8.600 Y3.800 E0.79183 F3600
G1 X8.800 Y3.600 E0.80141 F3600
G1 X8.700 Y3.600 E0.80479 F3600
;--- Shutdown ---
G1 E0.10479 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---