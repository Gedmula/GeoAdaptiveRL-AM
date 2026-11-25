;FLAVOR:Marlin
;Generated from path with 44 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X5.800 Y-2.300 W32.000 H7.800 ; print area for bed levelling
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
G0 X5.800 Y5.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X6.000 Y5.500 E0.00957 F3600
G1 X6.200 Y5.400 E0.01714 F3600
G1 X6.300 Y5.500 E0.02193 F3600
G1 X6.600 Y5.200 E0.03629 F3600
G1 X6.300 Y4.900 E0.05065 F3600
G1 X6.100 Y5.000 E0.05822 F3600
G1 X5.900 Y4.800 E0.06779 F3600
G1 X6.300 Y4.400 E0.08694 F3600
G1 X6.700 Y4.800 E0.10609 F3600
G1 X6.600 Y4.700 E0.11088 F3600
G0 X7.200 Y3.700 F9000
G1 X6.900 Y3.400 E0.12524 F3600
G1 X6.800 Y3.500 E0.13002 F3600
G1 X6.200 Y2.900 E0.15875 F3600
G1 X6.300 Y2.800 E0.16353 F3600
G1 X6.100 Y2.600 E0.17311 F3600
G1 X6.200 Y2.500 E0.17789 F3600
G1 X6.100 Y2.400 E0.18268 F3600
G1 X6.400 Y2.100 E0.19704 F3600
G1 X6.300 Y2.000 E0.20183 F3600
G1 X6.600 Y1.700 E0.21619 F3600
G1 X6.800 Y1.900 E0.22576 F3600
G1 X7.000 Y1.700 E0.23534 F3600
G1 X7.200 Y1.900 E0.24491 F3600
G1 X6.600 Y2.500 E0.27363 F3600
G1 X6.700 Y2.700 E0.28120 F3600
G1 X7.700 Y3.700 E0.32907 F3600
G1 X7.800 Y3.600 E0.33386 F3600
G1 X7.900 Y3.700 E0.33864 F3600
G1 X8.300 Y3.400 E0.35557 F3600
G1 X8.100 Y3.200 E0.36514 F3600
G1 X8.000 Y3.300 E0.36993 F3600
G1 X7.800 Y3.100 E0.37950 F3600
G1 X7.700 Y3.100 E0.38289 F3600
G1 X7.200 Y2.600 E0.40682 F3600
G1 X7.700 Y1.900 E0.43594 F3600
G1 X8.100 Y2.200 E0.45287 F3600
G1 X7.800 Y2.500 E0.46723 F3600
G1 X7.900 Y2.700 E0.47480 F3600
G1 X8.400 Y3.100 E0.49647 F3600
G1 X8.500 Y2.900 E0.50404 F3600
G1 X8.300 Y2.500 E0.51918 F3600
;--- Shutdown ---
G1 E-0.18082 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---