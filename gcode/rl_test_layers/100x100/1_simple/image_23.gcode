;FLAVOR:Marlin
;Generated from path with 77 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.300 Y-1.100 W32.000 H8.800 ; print area for bed levelling
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
G0 X3.300 Y3.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.300 Y4.500 E0.05032 F3600
G1 X2.400 Y4.600 E0.05511 F3600
G1 X2.000 Y5.000 E0.07425 F3600
G1 X2.100 Y5.100 E0.07904 F3600
G1 X1.800 Y5.400 E0.09340 F3600
G1 X1.900 Y5.500 E0.09819 F3600
G1 X1.600 Y5.800 E0.11255 F3600
G1 X1.700 Y5.900 E0.11734 F3600
G1 X1.500 Y6.100 E0.12691 F3600
G1 X1.600 Y6.300 E0.13448 F3600
G1 X1.300 Y6.600 E0.14884 F3600
G1 X1.400 Y6.700 E0.15363 F3600
G1 X1.300 Y6.800 E0.15841 F3600
G1 X1.400 Y6.900 E0.16320 F3600
G1 X1.300 Y7.000 E0.16799 F3600
G1 X1.400 Y7.200 E0.17556 F3600
G1 X1.800 Y7.600 E0.19471 F3600
G1 X2.000 Y7.700 E0.20227 F3600
G1 X2.100 Y7.600 E0.20706 F3600
G1 X2.200 Y7.700 E0.21185 F3600
G1 X2.400 Y7.500 E0.22142 F3600
G1 X2.500 Y7.600 E0.22621 F3600
G1 X2.800 Y7.300 E0.24057 F3600
G1 X2.500 Y7.000 E0.25493 F3600
G1 X2.200 Y7.300 E0.26929 F3600
G1 X1.700 Y6.900 E0.29096 F3600
G1 X1.900 Y6.700 E0.30054 F3600
G1 X1.800 Y6.600 E0.30533 F3600
G1 X2.000 Y6.400 E0.31490 F3600
G1 X1.900 Y6.300 E0.31969 F3600
G1 X2.200 Y6.000 E0.33405 F3600
G1 X2.400 Y6.200 E0.34362 F3600
G1 X2.400 Y6.400 E0.35039 F3600
G1 X2.300 Y6.500 E0.35518 F3600
G1 X2.400 Y6.700 E0.36275 F3600
G1 X2.600 Y6.600 E0.37032 F3600
G1 X3.200 Y7.200 E0.39904 F3600
G1 X3.500 Y6.900 E0.41340 F3600
G1 X2.300 Y5.600 E0.47328 F3600
G1 X2.400 Y5.500 E0.47807 F3600
G1 X2.300 Y5.400 E0.48286 F3600
G1 X2.500 Y5.200 E0.49243 F3600
G1 X3.500 Y6.200 E0.54030 F3600
G1 X3.500 Y6.400 E0.54707 F3600
G1 X3.700 Y6.600 E0.55664 F3600
G1 X3.800 Y6.600 E0.56003 F3600
G1 X4.100 Y6.300 E0.57439 F3600
G1 X2.700 Y4.800 E0.64384 F3600
G1 X3.000 Y4.500 E0.65820 F3600
G1 X4.100 Y5.600 E0.71086 F3600
G1 X4.100 Y5.700 E0.71424 F3600
G1 X4.300 Y5.900 E0.72382 F3600
G1 X4.600 Y5.600 E0.73818 F3600
G1 X4.500 Y5.500 E0.74297 F3600
G1 X4.600 Y5.300 E0.75053 F3600
G1 X4.400 Y5.300 E0.75730 F3600
G1 X3.200 Y4.100 E0.81475 F3600
G1 X3.500 Y3.800 E0.82911 F3600
G1 X4.800 Y5.100 E0.89134 F3600
G1 X4.900 Y5.000 E0.89613 F3600
G1 X4.800 Y4.900 E0.90091 F3600
G1 X5.000 Y4.700 E0.91049 F3600
G1 X3.600 Y3.300 E0.97750 F3600
G1 X3.900 Y3.000 E0.99186 F3600
G1 X4.000 Y3.100 E0.99665 F3600
G1 X4.200 Y2.900 E1.00622 F3600
G1 X4.400 Y3.100 E1.01580 F3600
G1 X4.200 Y3.300 E1.02537 F3600
G1 X5.100 Y4.300 E1.07091 F3600
G1 X5.100 Y4.000 E1.08107 F3600
G1 X5.200 Y3.900 E1.08585 F3600
G1 X5.000 Y3.600 E1.09806 F3600
G1 X5.100 Y3.500 E1.10284 F3600
G1 X4.700 Y3.300 E1.11798 F3600
G1 X4.700 Y3.000 E1.12814 F3600
;--- Shutdown ---
G1 E0.42814 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---