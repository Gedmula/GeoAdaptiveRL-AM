;FLAVOR:Marlin
;Generated from path with 84 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.500 Y0.900 W32.000 H6.800 ; print area for bed levelling
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
G0 X3.000 Y6.600 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.500 Y7.100 E0.02393 F3600
G1 X2.700 Y7.300 E0.03351 F3600
G1 X2.600 Y7.400 E0.03830 F3600
G1 X2.800 Y7.700 E0.05050 F3600
G1 X2.900 Y7.600 E0.05529 F3600
G1 X3.000 Y7.700 E0.06007 F3600
G1 X3.200 Y7.500 E0.06965 F3600
G1 X3.300 Y7.600 E0.07443 F3600
G1 X3.500 Y7.400 E0.08401 F3600
G1 X3.600 Y7.500 E0.08880 F3600
G1 X3.900 Y7.200 E0.10316 F3600
G1 X3.600 Y6.900 E0.11752 F3600
G1 X3.300 Y7.200 E0.13188 F3600
G1 X3.100 Y7.100 E0.13945 F3600
G1 X3.400 Y6.800 E0.15381 F3600
G1 X3.300 Y6.700 E0.15859 F3600
G1 X3.600 Y6.400 E0.17296 F3600
G1 X3.700 Y6.500 E0.17774 F3600
G1 X3.800 Y6.400 E0.18253 F3600
G1 X4.100 Y6.700 E0.19689 F3600
G1 X4.100 Y6.900 E0.20366 F3600
G1 X4.300 Y7.100 E0.21323 F3600
G1 X4.500 Y6.900 E0.22281 F3600
G1 X4.600 Y7.000 E0.22759 F3600
G1 X4.800 Y6.800 E0.23717 F3600
G1 X4.900 Y6.900 E0.24196 F3600
G1 X5.100 Y6.700 E0.25153 F3600
G1 X5.200 Y6.800 E0.25632 F3600
G1 X5.400 Y6.600 E0.26589 F3600
G1 X5.500 Y6.700 E0.27068 F3600
G1 X5.700 Y6.500 E0.28025 F3600
G1 X5.800 Y6.600 E0.28504 F3600
G1 X6.000 Y6.400 E0.29461 F3600
G1 X5.700 Y6.100 E0.30897 F3600
G1 X5.500 Y6.200 E0.31654 F3600
G1 X5.400 Y6.100 E0.32133 F3600
G1 X5.200 Y6.300 E0.33090 F3600
G1 X4.900 Y6.300 E0.34106 F3600
G1 X4.600 Y6.600 E0.35542 F3600
G1 X4.200 Y6.200 E0.37457 F3600
G1 X4.800 Y5.900 E0.39727 F3600
G1 X4.900 Y6.000 E0.40206 F3600
G1 X5.300 Y5.700 E0.41898 F3600
G1 X5.400 Y5.800 E0.42377 F3600
G1 X5.600 Y5.600 E0.43334 F3600
G1 X5.700 Y5.700 E0.43813 F3600
G1 X6.100 Y5.500 E0.45327 F3600
G1 X6.200 Y5.600 E0.45806 F3600
G1 X6.000 Y5.800 E0.46763 F3600
G1 X6.400 Y6.300 E0.48930 F3600
G1 X6.500 Y6.200 E0.49409 F3600
G1 X6.700 Y6.300 E0.50166 F3600
G1 X6.800 Y6.100 E0.50923 F3600
G1 X6.400 Y5.600 E0.53090 F3600
G0 X6.500 Y5.400 F9000
G1 X6.600 Y5.300 E0.53569 F3600
G1 X6.700 Y5.400 E0.54048 F3600
G1 X6.800 Y5.300 E0.54526 F3600
G1 X7.000 Y5.500 E0.55484 F3600
G1 X6.900 Y5.600 E0.55962 F3600
G1 X7.300 Y6.100 E0.58130 F3600
G1 X7.600 Y6.100 E0.59145 F3600
G1 X7.700 Y6.000 E0.59624 F3600
G1 X7.400 Y5.700 E0.61060 F3600
G1 X7.500 Y5.600 E0.61539 F3600
G1 X7.200 Y5.300 E0.62975 F3600
G1 X7.400 Y5.100 E0.63932 F3600
G1 X7.600 Y5.200 E0.64689 F3600
G1 X7.800 Y5.000 E0.65646 F3600
G1 X7.900 Y5.100 E0.66125 F3600
G1 X8.000 Y5.100 E0.66464 F3600
G1 X8.200 Y4.900 E0.67421 F3600
G1 X8.300 Y5.000 E0.67900 F3600
G1 X8.300 Y5.100 E0.68238 F3600
G1 X7.900 Y5.500 E0.70153 F3600
G1 X7.900 Y5.800 E0.71168 F3600
G1 X8.000 Y5.900 E0.71647 F3600
G1 X8.100 Y5.800 E0.72126 F3600
G1 X8.200 Y5.900 E0.72604 F3600
G1 X8.300 Y5.700 E0.73361 F3600
G1 X8.600 Y5.500 E0.74582 F3600
G1 X8.500 Y5.500 E0.74920 F3600
;--- Shutdown ---
G1 E0.04920 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---