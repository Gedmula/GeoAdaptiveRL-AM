;FLAVOR:Marlin
;Generated from path with 50 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.100 Y-0.600 W32.000 H8.300 ; print area for bed levelling
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
G0 X3.600 Y5.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.600 Y5.500 E0.00338 F3600
G1 X3.100 Y6.000 E0.02732 F3600
G1 X4.300 Y7.100 E0.08242 F3600
G1 X4.400 Y7.000 E0.08721 F3600
G1 X5.100 Y7.700 E0.12072 F3600
G1 X5.300 Y7.600 E0.12829 F3600
G1 X5.700 Y7.200 E0.14743 F3600
G1 X5.500 Y7.000 E0.15701 F3600
G1 X5.300 Y7.200 E0.16658 F3600
G1 X5.200 Y7.200 E0.16997 F3600
G1 X4.600 Y6.600 E0.19869 F3600
G1 X4.500 Y6.600 E0.20207 F3600
G1 X3.700 Y5.900 E0.23805 F3600
G1 X4.100 Y5.500 E0.25720 F3600
G1 X4.300 Y5.700 E0.26678 F3600
G1 X4.300 Y5.800 E0.27016 F3600
G1 X5.200 Y6.700 E0.31324 F3600
G1 X5.300 Y6.600 E0.31803 F3600
G1 X5.600 Y6.700 E0.32873 F3600
G1 X5.700 Y6.600 E0.33352 F3600
G1 X4.400 Y5.300 E0.39575 F3600
G1 X4.500 Y5.200 E0.40054 F3600
G1 X4.900 Y5.200 E0.41408 F3600
G1 X5.800 Y6.100 E0.45716 F3600
G1 X6.100 Y5.800 E0.47152 F3600
G1 X5.100 Y4.900 E0.51706 F3600
G1 X5.200 Y4.800 E0.52185 F3600
G1 X5.300 Y4.900 E0.52663 F3600
G1 X5.500 Y4.700 E0.53621 F3600
G1 X6.100 Y5.300 E0.56493 F3600
G1 X6.400 Y5.000 E0.57929 F3600
G1 X5.800 Y4.400 E0.60801 F3600
G1 X6.100 Y4.100 E0.62237 F3600
G1 X6.600 Y4.600 E0.64631 F3600
G1 X6.700 Y4.800 E0.65388 F3600
G1 X6.900 Y4.600 E0.66345 F3600
G1 X7.000 Y4.700 E0.66824 F3600
G1 X7.300 Y4.300 E0.68516 F3600
G1 X7.000 Y4.300 E0.69532 F3600
G1 X6.600 Y4.000 E0.71224 F3600
G1 X6.300 Y3.900 E0.72295 F3600
G1 X6.100 Y3.700 E0.73252 F3600
G1 X6.400 Y3.400 E0.74688 F3600
G1 X6.500 Y3.500 E0.75167 F3600
G1 X6.600 Y3.400 E0.75645 F3600
G1 X6.800 Y3.600 E0.76603 F3600
G1 X6.900 Y3.500 E0.77081 F3600
G1 X7.100 Y3.800 E0.78302 F3600
;--- Shutdown ---
G1 E0.08302 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---