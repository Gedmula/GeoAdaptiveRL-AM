;FLAVOR:Marlin
;Generated from path with 90 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.400 Y-2.300 W32.000 H10.800 ; print area for bed levelling
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
G0 X2.600 Y2.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.700 Y2.400 E0.00338 F3600
G1 X2.900 Y2.600 E0.01296 F3600
G1 X2.800 Y2.700 E0.01775 F3600
G1 X3.500 Y3.400 E0.05125 F3600
G1 X2.700 Y4.200 E0.08955 F3600
G1 X2.600 Y4.200 E0.09293 F3600
G1 X2.300 Y4.500 E0.10730 F3600
G1 X2.200 Y4.500 E0.11068 F3600
G1 X1.400 Y5.300 E0.14898 F3600
G1 X2.100 Y6.000 E0.18248 F3600
G1 X2.400 Y5.800 E0.19469 F3600
G1 X1.900 Y5.300 E0.21862 F3600
G1 X2.200 Y5.000 E0.23298 F3600
G1 X2.300 Y5.000 E0.23637 F3600
G1 X2.500 Y5.200 E0.24594 F3600
G1 X2.700 Y5.600 E0.26108 F3600
G1 X3.000 Y5.300 E0.27544 F3600
G1 X2.500 Y4.800 E0.29938 F3600
G1 X2.700 Y4.600 E0.30895 F3600
G1 X2.900 Y4.600 E0.31572 F3600
G1 X3.300 Y5.100 E0.33739 F3600
G1 X3.600 Y4.800 E0.35175 F3600
G1 X3.600 Y4.700 E0.35514 F3600
G1 X3.200 Y4.300 E0.37429 F3600
G1 X3.500 Y4.000 E0.38865 F3600
G1 X3.600 Y4.000 E0.39203 F3600
G1 X4.000 Y4.500 E0.41371 F3600
G1 X4.200 Y4.300 E0.42328 F3600
G1 X5.100 Y5.200 E0.46636 F3600
G1 X5.200 Y5.100 E0.47115 F3600
G1 X5.300 Y5.200 E0.47594 F3600
G1 X5.600 Y4.900 E0.49030 F3600
G1 X5.500 Y4.700 E0.49787 F3600
G1 X5.100 Y4.600 E0.51182 F3600
G1 X4.300 Y3.800 E0.55012 F3600
G1 X4.100 Y4.000 E0.55969 F3600
G1 X3.800 Y3.700 E0.57405 F3600
G1 X4.100 Y3.400 E0.58841 F3600
G1 X2.900 Y2.100 E0.64830 F3600
G1 X3.200 Y1.800 E0.66266 F3600
G1 X3.300 Y1.900 E0.66745 F3600
G1 X3.500 Y1.700 E0.67702 F3600
G1 X3.700 Y1.900 E0.68659 F3600
G1 X3.500 Y2.100 E0.69617 F3600
G1 X3.700 Y2.300 E0.70574 F3600
G1 X3.800 Y2.200 E0.71053 F3600
G1 X4.000 Y2.300 E0.71810 F3600
G1 X3.900 Y2.500 E0.72567 F3600
G1 X4.100 Y2.800 E0.73787 F3600
G1 X4.300 Y2.600 E0.74745 F3600
G1 X4.500 Y2.800 E0.75702 F3600
G1 X4.300 Y3.000 E0.76659 F3600
G1 X4.500 Y3.200 E0.77617 F3600
G1 X4.600 Y3.100 E0.78095 F3600
G1 X4.800 Y3.200 E0.78852 F3600
G1 X4.600 Y3.400 E0.79810 F3600
G1 X4.600 Y3.500 E0.80148 F3600
G1 X4.800 Y3.700 E0.81106 F3600
G1 X5.000 Y3.500 E0.82063 F3600
G1 X5.200 Y3.700 E0.83020 F3600
G1 X5.100 Y3.900 E0.83777 F3600
G1 X5.200 Y4.000 E0.84256 F3600
G1 X5.200 Y4.200 E0.84933 F3600
G1 X5.300 Y4.300 E0.85412 F3600
G1 X5.500 Y4.100 E0.86369 F3600
G1 X6.000 Y4.700 E0.89013 F3600
G1 X5.900 Y4.800 E0.89491 F3600
G1 E0.19491 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X6.600 Y6.500 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.89491 F2100 ; unretract
G1 X6.000 Y7.100 E0.92363 F3600
G1 X7.100 Y8.100 E0.97395 F3600
G1 X7.300 Y8.500 E0.98909 F3600
G1 X7.700 Y8.200 E1.00602 F3600
G1 X6.600 Y7.000 E1.06112 F3600
G1 X7.300 Y6.300 E1.09463 F3600
G1 X7.400 Y6.400 E1.09941 F3600
G1 X7.500 Y6.300 E1.10420 F3600
G1 X7.700 Y6.500 E1.11377 F3600
G1 X7.200 Y7.000 E1.13771 F3600
G1 X7.800 Y7.600 E1.16643 F3600
G1 X7.800 Y7.800 E1.17320 F3600
G1 X8.000 Y8.000 E1.18277 F3600
G1 X8.300 Y7.800 E1.19498 F3600
G1 X8.200 Y7.700 E1.19977 F3600
G1 X8.300 Y7.500 E1.20734 F3600
G1 X7.700 Y7.000 E1.23377 F3600
G1 X8.200 Y6.500 E1.25771 F3600
G1 X8.400 Y6.700 E1.26728 F3600
G1 X8.300 Y6.800 E1.27207 F3600
;--- Shutdown ---
G1 E0.57207 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---