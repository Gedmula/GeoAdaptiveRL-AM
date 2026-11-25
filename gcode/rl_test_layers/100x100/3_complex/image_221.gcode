;FLAVOR:Marlin
;Generated from path with 65 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.500 Y-1.800 W32.000 H7.800 ; print area for bed levelling
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
G0 X3.500 Y3.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.700 Y3.300 E0.00957 F3600
G1 X3.800 Y3.200 E0.01436 F3600
G1 X4.000 Y3.400 E0.02393 F3600
G1 X4.100 Y3.300 E0.02872 F3600
G1 X4.300 Y3.400 E0.03629 F3600
G1 X4.600 Y3.700 E0.05065 F3600
G1 X4.600 Y3.800 E0.05404 F3600
G1 X4.400 Y4.000 E0.06361 F3600
G1 X4.500 Y4.100 E0.06840 F3600
G1 X4.400 Y4.300 E0.07597 F3600
G1 X4.500 Y4.400 E0.08075 F3600
G1 X4.100 Y4.900 E0.10243 F3600
G1 X4.200 Y5.000 E0.10721 F3600
G1 X4.100 Y5.100 E0.11200 F3600
G1 X4.300 Y5.300 E0.12157 F3600
G1 X4.200 Y5.400 E0.12636 F3600
G1 X4.300 Y5.800 E0.14032 F3600
G1 X4.500 Y6.000 E0.14989 F3600
G1 X4.700 Y5.900 E0.15746 F3600
G1 X4.500 Y5.600 E0.16966 F3600
G1 X4.700 Y5.400 E0.17924 F3600
G0 X4.800 Y5.300 F9000
G0 X4.700 Y5.200 F9000
G1 X4.600 Y5.000 E0.18681 F3600
G1 X4.800 Y4.900 E0.19438 F3600
G1 X5.200 Y5.300 E0.21352 F3600
G1 X5.200 Y5.600 E0.22368 F3600
G1 X5.400 Y5.800 E0.23325 F3600
G1 X5.500 Y5.800 E0.23664 F3600
G1 X5.700 Y5.600 E0.24621 F3600
G1 X5.600 Y5.500 E0.25100 F3600
G1 X5.700 Y5.400 E0.25579 F3600
G1 X5.600 Y5.300 E0.26057 F3600
G1 X5.700 Y5.200 E0.26536 F3600
G1 X5.600 Y5.200 E0.26874 F3600
G1 X5.400 Y5.000 E0.27832 F3600
G1 X5.600 Y4.800 E0.28789 F3600
G1 X5.500 Y4.700 E0.29268 F3600
G1 X5.300 Y4.700 E0.29945 F3600
G1 X5.100 Y4.500 E0.30902 F3600
G1 X5.000 Y4.600 E0.31381 F3600
G1 X4.800 Y4.400 E0.32338 F3600
G1 X4.900 Y4.200 E0.33095 F3600
G1 X4.800 Y4.100 E0.33574 F3600
G1 X4.900 Y4.000 E0.34053 F3600
G1 X4.800 Y3.900 E0.34531 F3600
G0 X4.700 Y3.800 F9000
G0 X4.800 Y3.400 F9000
G1 X4.200 Y2.800 E0.37403 F3600
G1 X4.100 Y2.900 E0.37882 F3600
G1 X3.800 Y2.900 E0.38898 F3600
G1 X3.600 Y2.700 E0.39855 F3600
G1 X4.100 Y2.200 E0.42248 F3600
G1 X4.300 Y2.400 E0.43206 F3600
G1 X4.500 Y2.200 E0.44163 F3600
G1 X4.600 Y2.300 E0.44642 F3600
G1 X4.700 Y2.200 E0.45121 F3600
G1 X4.800 Y2.400 E0.45878 F3600
G1 X4.600 Y2.600 E0.46835 F3600
G1 X5.100 Y3.200 E0.49479 F3600
G1 X5.300 Y2.900 E0.50699 F3600
G1 X5.100 Y2.700 E0.51656 F3600
G1 X5.200 Y2.500 E0.52413 F3600
;--- Shutdown ---
G1 E-0.17587 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---