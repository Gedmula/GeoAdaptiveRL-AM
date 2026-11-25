;FLAVOR:Marlin
;Generated from path with 55 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-0.900 W32.000 H8.800 ; print area for bed levelling
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
G0 X4.400 Y5.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.700 Y6.400 E0.03351 F3600
G1 X3.600 Y6.300 E0.03830 F3600
G1 X3.300 Y6.600 E0.05266 F3600
G0 X3.100 Y6.800 F9000
G1 X1.900 Y7.900 E0.10776 F3600
G1 X1.800 Y7.900 E0.11114 F3600
G1 X1.600 Y7.700 E0.12072 F3600
G1 X2.300 Y7.000 E0.15423 F3600
G1 X2.400 Y7.100 E0.15901 F3600
G1 X2.800 Y6.700 E0.17816 F3600
G1 X2.900 Y6.800 E0.18295 F3600
G0 X3.000 Y6.900 F9000
G0 X4.100 Y6.500 F9000
G1 X4.200 Y6.400 E0.18773 F3600
G0 X4.400 Y6.200 F9000
G1 X4.500 Y6.100 E0.19252 F3600
G0 X4.700 Y5.900 F9000
G1 X4.900 Y5.700 E0.20210 F3600
G1 X4.800 Y5.600 E0.20688 F3600
G1 X5.000 Y5.400 E0.21646 F3600
G1 X5.100 Y5.400 E0.21984 F3600
G1 X5.300 Y5.600 E0.22941 F3600
G1 X5.500 Y5.400 E0.23899 F3600
G1 X5.300 Y5.200 E0.24856 F3600
G1 X5.500 Y5.000 E0.25814 F3600
G1 X5.800 Y5.300 E0.27250 F3600
G1 X6.000 Y5.100 E0.28207 F3600
G1 X5.800 Y4.900 E0.29164 F3600
G1 X6.000 Y4.700 E0.30122 F3600
G1 X6.100 Y4.700 E0.30460 F3600
G1 X6.300 Y4.900 E0.31418 F3600
G1 X6.500 Y4.700 E0.32375 F3600
G1 X6.300 Y4.500 E0.33333 F3600
G1 X6.500 Y4.300 E0.34290 F3600
G1 X6.800 Y4.600 E0.35726 F3600
G1 X7.000 Y4.400 E0.36683 F3600
G1 X6.900 Y4.200 E0.37440 F3600
G1 X7.100 Y4.000 E0.38398 F3600
G1 X7.300 Y4.200 E0.39355 F3600
G1 X7.500 Y4.000 E0.40312 F3600
G1 X7.400 Y3.900 E0.40791 F3600
G1 X7.500 Y3.700 E0.41548 F3600
G1 X7.800 Y4.000 E0.42984 F3600
G1 X8.000 Y3.800 E0.43941 F3600
G1 X7.800 Y3.600 E0.44899 F3600
G1 X8.000 Y3.400 E0.45856 F3600
G1 X8.300 Y3.700 E0.47292 F3600
G1 X8.400 Y3.500 E0.48049 F3600
G1 X8.200 Y3.300 E0.49007 F3600
G1 X8.400 Y3.100 E0.49964 F3600
G1 X8.600 Y3.300 E0.50921 F3600
G1 X8.700 Y3.200 E0.51400 F3600
G1 X8.800 Y3.300 E0.51879 F3600
;--- Shutdown ---
G1 E-0.18121 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---