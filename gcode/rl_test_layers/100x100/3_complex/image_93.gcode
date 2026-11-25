;FLAVOR:Marlin
;Generated from path with 80 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-0.200 W32.000 H7.600 ; print area for bed levelling
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
G0 X2.800 Y3.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.600 Y5.000 E0.05744 F3600
G1 X2.900 Y6.300 E0.11967 F3600
G1 X3.000 Y6.200 E0.12446 F3600
G1 X4.000 Y7.200 E0.17233 F3600
G1 X4.100 Y7.100 E0.17712 F3600
G1 X4.200 Y7.200 E0.18190 F3600
G1 X4.400 Y7.000 E0.19148 F3600
G1 X4.400 Y6.900 E0.19486 F3600
G1 X3.400 Y5.900 E0.24273 F3600
G1 X3.100 Y5.800 E0.25344 F3600
G1 X2.200 Y4.900 E0.29652 F3600
G1 X2.500 Y4.600 E0.31088 F3600
G1 X2.600 Y4.600 E0.31426 F3600
G1 X4.800 Y6.700 E0.41721 F3600
G1 X4.700 Y6.900 E0.42478 F3600
G1 X4.900 Y7.100 E0.43435 F3600
G1 X5.000 Y7.000 E0.43914 F3600
G1 X5.100 Y7.200 E0.44671 F3600
G1 X5.300 Y7.200 E0.45348 F3600
G1 X5.400 Y7.300 E0.45827 F3600
G1 X5.500 Y7.200 E0.46305 F3600
G1 X5.800 Y7.400 E0.47526 F3600
G1 X6.000 Y7.200 E0.48483 F3600
G1 X6.100 Y7.300 E0.48962 F3600
G1 X6.500 Y7.000 E0.50654 F3600
G1 X6.600 Y7.100 E0.51133 F3600
G1 X6.800 Y6.900 E0.52090 F3600
G1 X6.600 Y6.700 E0.53048 F3600
G1 X6.500 Y6.800 E0.53526 F3600
G1 X6.400 Y6.700 E0.54005 F3600
G1 X6.200 Y6.800 E0.54762 F3600
G1 X6.100 Y6.700 E0.55241 F3600
G1 X5.900 Y6.900 E0.56198 F3600
G1 X5.700 Y6.800 E0.56955 F3600
G1 X5.400 Y6.800 E0.57970 F3600
G1 X5.000 Y6.400 E0.59885 F3600
G1 X5.200 Y6.200 E0.60843 F3600
G1 X5.000 Y6.000 E0.61800 F3600
G1 X4.900 Y6.100 E0.62279 F3600
G1 X4.600 Y5.800 E0.63715 F3600
G1 X4.800 Y5.600 E0.64672 F3600
G1 X4.600 Y5.400 E0.65630 F3600
G1 X4.400 Y5.600 E0.66587 F3600
G1 X4.300 Y5.600 E0.66925 F3600
G1 X3.800 Y5.100 E0.69319 F3600
G1 X3.600 Y5.100 E0.69996 F3600
G1 X2.800 Y4.300 E0.73825 F3600
G1 X3.000 Y4.100 E0.74783 F3600
G1 X4.000 Y5.000 E0.79337 F3600
G1 X4.600 Y5.100 E0.81396 F3600
G1 X4.700 Y5.200 E0.81874 F3600
G1 X4.900 Y5.000 E0.82832 F3600
G1 X4.900 Y4.900 E0.83170 F3600
G1 X4.800 Y4.800 E0.83649 F3600
G1 X4.600 Y4.800 E0.84326 F3600
G1 X4.400 Y4.600 E0.85283 F3600
G1 X4.700 Y4.300 E0.86719 F3600
G1 X4.900 Y4.400 E0.87476 F3600
G1 X5.200 Y4.100 E0.88912 F3600
G1 X5.400 Y4.300 E0.89870 F3600
G1 X5.200 Y4.500 E0.90827 F3600
G1 X5.200 Y4.600 E0.91166 F3600
G1 X5.400 Y4.800 E0.92123 F3600
G1 X5.700 Y4.500 E0.93559 F3600
G1 X5.800 Y4.600 E0.94038 F3600
G1 X5.900 Y4.500 E0.94517 F3600
G1 X6.100 Y4.700 E0.95474 F3600
G1 X6.200 Y4.600 E0.95953 F3600
G1 X7.200 Y5.700 E1.00985 F3600
G1 X7.400 Y5.500 E1.01942 F3600
G1 X7.200 Y5.300 E1.02899 F3600
G1 X7.300 Y5.200 E1.03378 F3600
G1 X7.100 Y5.000 E1.04335 F3600
G1 X7.100 Y4.800 E1.05012 F3600
G1 X7.000 Y4.800 E1.05351 F3600
G1 X6.500 Y4.300 E1.07744 F3600
G1 X6.100 Y4.100 E1.09258 F3600
G1 X5.900 Y4.200 E1.10015 F3600
;--- Shutdown ---
G1 E0.40015 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---