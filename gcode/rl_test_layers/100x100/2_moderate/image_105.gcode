;FLAVOR:Marlin
;Generated from path with 85 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.900 Y-1.700 W32.000 H8.800 ; print area for bed levelling
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
G0 X3.300 Y4.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.300 Y4.400 E0.00338 F3600
G1 X2.900 Y4.800 E0.02253 F3600
G1 X2.900 Y4.900 E0.02592 F3600
G1 X3.800 Y5.800 E0.06900 F3600
G1 X3.900 Y5.800 E0.07238 F3600
G1 X5.300 Y7.100 E0.13705 F3600
G1 X5.800 Y6.600 E0.16099 F3600
G1 X5.600 Y6.400 E0.17056 F3600
G1 X5.400 Y6.600 E0.18014 F3600
G1 X5.100 Y6.300 E0.19450 F3600
G1 X5.300 Y6.100 E0.20407 F3600
G1 X5.100 Y5.900 E0.21364 F3600
G1 X4.900 Y6.100 E0.22322 F3600
G1 X4.300 Y5.500 E0.25194 F3600
G1 X4.200 Y5.600 E0.25673 F3600
G1 X3.500 Y4.900 E0.29024 F3600
G1 X3.700 Y4.700 E0.29981 F3600
G1 X4.100 Y5.100 E0.31896 F3600
G1 X4.300 Y5.000 E0.32653 F3600
G1 X4.900 Y5.600 E0.35525 F3600
G1 X5.100 Y5.400 E0.36482 F3600
G1 X5.100 Y5.300 E0.36821 F3600
G1 X4.600 Y4.800 E0.39214 F3600
G1 X4.900 Y4.500 E0.40650 F3600
G1 X6.000 Y5.600 E0.45916 F3600
G1 X6.400 Y5.800 E0.47430 F3600
G1 X6.500 Y5.700 E0.47908 F3600
G1 X6.600 Y5.800 E0.48387 F3600
G1 X6.800 Y5.600 E0.49344 F3600
G1 X6.900 Y5.700 E0.49823 F3600
G1 X7.100 Y5.500 E0.50780 F3600
G1 X7.200 Y5.600 E0.51259 F3600
G1 X7.400 Y5.400 E0.52217 F3600
G1 X7.500 Y5.500 E0.52695 F3600
G1 X7.800 Y5.200 E0.54131 F3600
G1 X7.300 Y4.800 E0.56299 F3600
G1 X6.700 Y5.300 E0.58942 F3600
G1 X6.600 Y5.200 E0.59421 F3600
G1 X6.400 Y5.300 E0.60178 F3600
G1 X5.300 Y4.200 E0.65444 F3600
G1 X5.100 Y4.100 E0.66200 F3600
G1 X5.200 Y4.000 E0.66679 F3600
G1 X5.100 Y3.800 E0.67436 F3600
G1 X5.300 Y3.600 E0.68393 F3600
G1 X6.500 Y4.800 E0.74138 F3600
G1 X6.600 Y4.800 E0.74476 F3600
G1 X6.900 Y4.500 E0.75912 F3600
G1 X5.700 Y3.300 E0.81657 F3600
G1 X5.500 Y3.200 E0.82414 F3600
G1 X5.300 Y3.300 E0.83170 F3600
G1 X4.600 Y2.700 E0.86291 F3600
G1 X5.000 Y2.300 E0.88206 F3600
G1 X5.100 Y2.300 E0.88544 F3600
G1 X5.300 Y2.700 E0.90058 F3600
G1 X5.500 Y2.600 E0.90815 F3600
G1 X5.700 Y2.900 E0.92035 F3600
G1 X5.800 Y2.800 E0.92514 F3600
G1 X7.900 Y4.900 E1.02567 F3600
G1 X8.100 Y4.700 E1.03524 F3600
G1 X8.100 Y4.400 E1.04540 F3600
G1 X8.200 Y4.300 E1.05018 F3600
G1 X8.100 Y4.200 E1.05497 F3600
G1 X8.000 Y4.300 E1.05976 F3600
G1 X7.800 Y4.100 E1.06933 F3600
G1 X8.100 Y3.800 E1.08369 F3600
G1 X8.000 Y3.700 E1.08848 F3600
G1 X7.600 Y3.900 E1.10362 F3600
G1 X7.400 Y3.800 E1.11119 F3600
G1 X6.900 Y3.300 E1.13512 F3600
G1 X6.800 Y3.300 E1.13850 F3600
G1 X6.300 Y2.800 E1.16244 F3600
G1 X6.300 Y2.700 E1.16582 F3600
G1 X6.400 Y2.600 E1.17061 F3600
G1 X6.600 Y2.800 E1.18019 F3600
G1 X6.700 Y2.700 E1.18497 F3600
G1 X6.900 Y2.900 E1.19455 F3600
G1 X7.000 Y2.800 E1.19933 F3600
G1 X7.100 Y2.900 E1.20412 F3600
G1 X7.200 Y2.800 E1.20891 F3600
G1 X7.300 Y2.900 E1.21369 F3600
G1 X7.300 Y3.200 E1.22385 F3600
G1 X7.500 Y3.400 E1.23342 F3600
G1 X7.800 Y3.100 E1.24778 F3600
;--- Shutdown ---
G1 E0.54778 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---