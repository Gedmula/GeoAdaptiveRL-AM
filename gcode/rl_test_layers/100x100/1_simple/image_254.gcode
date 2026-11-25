;FLAVOR:Marlin
;Generated from path with 72 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.500 Y-1.000 W32.000 H7.300 ; print area for bed levelling
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
G0 X3.400 Y3.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.500 Y3.500 E0.00479 F3600
G1 X2.700 Y4.400 E0.04555 F3600
G1 X2.700 Y4.500 E0.04893 F3600
G1 X2.500 Y4.700 E0.05851 F3600
G1 X2.600 Y4.800 E0.06329 F3600
G1 X2.500 Y4.900 E0.06808 F3600
G1 X2.800 Y5.300 E0.08500 F3600
G1 X2.800 Y5.400 E0.08839 F3600
G1 X3.300 Y5.900 E0.11232 F3600
G1 X3.400 Y5.800 E0.11711 F3600
G1 X3.600 Y6.100 E0.12931 F3600
G1 X3.700 Y6.000 E0.13410 F3600
G1 X4.000 Y6.200 E0.14631 F3600
G1 X4.100 Y6.100 E0.15109 F3600
G1 X4.400 Y6.300 E0.16330 F3600
G1 X4.500 Y6.200 E0.16808 F3600
G1 X4.600 Y6.300 E0.17287 F3600
G1 X4.800 Y6.100 E0.18244 F3600
G1 X4.900 Y6.200 E0.18723 F3600
G1 X5.100 Y6.000 E0.19681 F3600
G1 X5.200 Y6.100 E0.20159 F3600
G1 X5.800 Y5.500 E0.23031 F3600
G1 X5.900 Y5.300 E0.23788 F3600
G1 X5.700 Y5.100 E0.24746 F3600
G1 X5.400 Y5.400 E0.26182 F3600
G1 X5.300 Y5.400 E0.26520 F3600
G1 X5.100 Y5.600 E0.27478 F3600
G1 X4.800 Y5.600 E0.28493 F3600
G1 X4.500 Y5.900 E0.29929 F3600
G1 X4.400 Y5.800 E0.30408 F3600
G1 X4.000 Y5.700 E0.31804 F3600
G1 X3.600 Y5.400 E0.33496 F3600
G1 X3.500 Y5.500 E0.33975 F3600
G1 X2.900 Y4.900 E0.36847 F3600
G1 X3.200 Y4.600 E0.38283 F3600
G1 X3.700 Y5.100 E0.40676 F3600
G1 X3.800 Y5.100 E0.41015 F3600
G1 X4.300 Y5.500 E0.43182 F3600
G1 X4.500 Y5.300 E0.44140 F3600
G1 X3.400 Y4.200 E0.49405 F3600
G1 X3.700 Y3.900 E0.50841 F3600
G1 X4.800 Y5.000 E0.56107 F3600
G1 X4.900 Y5.200 E0.56864 F3600
G1 X5.200 Y4.900 E0.58300 F3600
G1 X4.900 Y4.600 E0.59736 F3600
G1 X4.900 Y4.500 E0.60075 F3600
G1 X3.700 Y3.300 E0.65819 F3600
G1 X3.700 Y3.200 E0.66157 F3600
G1 X3.900 Y3.000 E0.67115 F3600
G1 X4.000 Y3.100 E0.67593 F3600
G1 X4.100 Y3.000 E0.68072 F3600
G1 X4.200 Y3.100 E0.68551 F3600
G1 X4.300 Y3.000 E0.69030 F3600
G1 X4.500 Y3.200 E0.69987 F3600
G1 X4.400 Y3.400 E0.70744 F3600
G1 X4.600 Y3.600 E0.71701 F3600
G1 X4.900 Y3.300 E0.73137 F3600
G1 X5.100 Y3.500 E0.74095 F3600
G1 X5.100 Y3.600 E0.74433 F3600
G1 X4.900 Y3.800 E0.75391 F3600
G1 X5.200 Y4.100 E0.76827 F3600
G1 X5.100 Y4.200 E0.77305 F3600
G1 X5.300 Y4.400 E0.78263 F3600
G1 X5.300 Y4.500 E0.78601 F3600
G1 X5.700 Y4.900 E0.80516 F3600
G1 X5.900 Y4.700 E0.81473 F3600
G1 X5.600 Y4.400 E0.82909 F3600
G1 X5.700 Y4.300 E0.83388 F3600
G1 X5.500 Y4.100 E0.84346 F3600
G1 X5.600 Y3.900 E0.85102 F3600
;--- Shutdown ---
G1 E0.15102 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---