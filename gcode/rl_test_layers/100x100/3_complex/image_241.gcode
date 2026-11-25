;FLAVOR:Marlin
;Generated from path with 85 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.100 Y-2.300 W32.000 H9.600 ; print area for bed levelling
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
G0 X2.700 Y4.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.100 Y5.300 E0.02872 F3600
G1 X4.100 Y7.300 E0.12446 F3600
G1 X4.200 Y7.200 E0.12925 F3600
G1 X4.300 Y7.300 E0.13403 F3600
G1 X4.400 Y7.200 E0.13882 F3600
G1 X4.500 Y7.300 E0.14361 F3600
G1 X4.900 Y6.900 E0.16276 F3600
G1 X4.800 Y6.800 E0.16754 F3600
G1 X4.900 Y6.700 E0.17233 F3600
G1 X4.700 Y6.500 E0.18190 F3600
G1 X4.300 Y6.900 E0.20105 F3600
G1 X2.700 Y5.300 E0.27764 F3600
G1 X3.200 Y4.800 E0.30158 F3600
G1 X3.300 Y4.900 E0.30636 F3600
G1 X3.500 Y4.700 E0.31594 F3600
G1 X3.700 Y4.900 E0.32551 F3600
G1 X3.300 Y5.300 E0.34466 F3600
G1 X4.300 Y6.300 E0.39253 F3600
G1 X4.600 Y6.000 E0.40689 F3600
G1 X4.800 Y6.200 E0.41646 F3600
G1 X5.000 Y6.000 E0.42604 F3600
G1 X4.600 Y5.600 E0.44519 F3600
G1 X4.400 Y5.800 E0.45476 F3600
G1 X3.900 Y5.300 E0.47869 F3600
G1 X4.200 Y5.000 E0.49306 F3600
G1 X3.900 Y4.700 E0.50742 F3600
G1 X4.200 Y4.400 E0.52178 F3600
G1 X4.300 Y4.400 E0.52516 F3600
G1 X4.500 Y4.600 E0.53474 F3600
G1 X4.500 Y4.800 E0.54151 F3600
G1 X4.600 Y4.900 E0.54629 F3600
G1 X4.500 Y5.200 E0.55700 F3600
G1 X4.600 Y5.300 E0.56178 F3600
G1 X4.700 Y5.200 E0.56657 F3600
G1 X5.000 Y5.500 E0.58093 F3600
G1 X5.300 Y5.200 E0.59529 F3600
G1 X4.500 Y4.300 E0.63605 F3600
G1 X4.800 Y4.000 E0.65041 F3600
G1 X4.900 Y4.000 E0.65380 F3600
G1 X5.100 Y4.200 E0.66337 F3600
G1 X5.200 Y4.500 E0.67407 F3600
G1 X5.500 Y4.800 E0.68844 F3600
G1 X5.800 Y4.500 E0.70280 F3600
G1 X5.500 Y4.200 E0.71716 F3600
G1 X5.600 Y4.100 E0.72194 F3600
G1 X5.100 Y3.600 E0.74588 F3600
G1 X5.400 Y3.300 E0.76024 F3600
G1 X6.000 Y3.900 E0.78896 F3600
G1 X6.100 Y4.300 E0.80292 F3600
G1 X6.200 Y4.400 E0.80770 F3600
G1 X6.500 Y4.100 E0.82207 F3600
G1 X6.600 Y4.200 E0.82685 F3600
G1 X6.800 Y4.000 E0.83643 F3600
G1 X6.600 Y3.800 E0.84600 F3600
G1 X6.500 Y3.800 E0.84939 F3600
G1 X5.700 Y3.000 E0.88768 F3600
G1 X5.500 Y2.900 E0.89525 F3600
G1 X5.700 Y2.700 E0.90482 F3600
G1 X5.800 Y2.800 E0.90961 F3600
G1 X6.000 Y2.700 E0.91718 F3600
G1 X6.800 Y3.500 E0.95547 F3600
G1 X7.000 Y3.600 E0.96304 F3600
G1 X7.100 Y3.500 E0.96783 F3600
G1 X7.300 Y3.700 E0.97740 F3600
G1 X7.600 Y3.400 E0.99177 F3600
G1 X7.400 Y3.200 E1.00134 F3600
G1 X7.500 Y3.100 E1.00613 F3600
G1 X7.600 Y3.200 E1.01091 F3600
G1 X7.700 Y3.100 E1.01570 F3600
G1 X7.800 Y3.200 E1.02049 F3600
G1 X7.900 Y3.100 E1.02527 F3600
G1 X7.800 Y3.000 E1.03006 F3600
G1 E0.33006 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X7.700 Y3.100 F9000
G0 X5.800 Y2.400 F9000
G1 Z0.200 F9000 ; lower z
G1 E1.03006 F2100 ; unretract
G1 X5.900 Y2.300 E1.03485 F3600
G1 X5.800 Y2.200 E1.03963 F3600
G1 X5.900 Y2.100 E1.04442 F3600
G1 X5.800 Y2.000 E1.04921 F3600
G1 X5.900 Y1.900 E1.05400 F3600
G1 X6.000 Y1.900 E1.05738 F3600
G1 X6.200 Y1.700 E1.06695 F3600
G1 X6.400 Y1.900 E1.07653 F3600
G1 X6.400 Y2.000 E1.07991 F3600
;--- Shutdown ---
G1 E0.37991 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---