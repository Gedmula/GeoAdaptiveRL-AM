;FLAVOR:Marlin
;Generated from path with 90 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-1.900 W32.000 H9.800 ; print area for bed levelling
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
G0 X2.900 Y2.900 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.000 Y3.000 E0.00479 F3600
G1 X1.600 Y4.300 E0.06946 F3600
G1 X1.700 Y4.400 E0.07424 F3600
G1 X1.600 Y4.500 E0.07903 F3600
G1 X1.900 Y4.800 E0.09339 F3600
G1 X1.800 Y4.900 E0.09818 F3600
G1 X2.100 Y5.300 E0.11510 F3600
G1 X2.200 Y5.200 E0.11989 F3600
G1 X2.300 Y5.300 E0.12467 F3600
G1 X2.400 Y5.200 E0.12946 F3600
G1 X4.000 Y6.800 E0.20605 F3600
G1 X3.600 Y7.200 E0.22520 F3600
G1 X3.700 Y7.300 E0.22999 F3600
G1 X4.000 Y7.300 E0.24014 F3600
G1 X4.500 Y7.600 E0.25988 F3600
G1 X4.600 Y7.500 E0.26467 F3600
G1 X5.000 Y7.900 E0.28381 F3600
G1 X5.300 Y7.600 E0.29818 F3600
G1 X4.700 Y7.000 E0.32690 F3600
G1 X4.500 Y7.100 E0.33447 F3600
G1 X4.300 Y6.900 E0.34404 F3600
G1 X4.500 Y6.700 E0.35361 F3600
G1 X2.600 Y4.800 E0.44457 F3600
G1 X2.400 Y4.800 E0.45133 F3600
G1 X2.100 Y4.500 E0.46570 F3600
G1 X2.300 Y4.300 E0.47527 F3600
G1 X2.300 Y4.200 E0.47865 F3600
G1 X2.500 Y4.000 E0.48823 F3600
G1 X2.600 Y4.000 E0.49161 F3600
G1 X2.700 Y4.100 E0.49640 F3600
G1 X2.600 Y4.300 E0.50397 F3600
G1 X2.800 Y4.500 E0.51354 F3600
G1 X2.900 Y4.500 E0.51693 F3600
G1 X5.400 Y7.000 E0.63660 F3600
G1 X5.400 Y7.200 E0.64337 F3600
G1 X5.600 Y7.300 E0.65094 F3600
G1 X5.900 Y6.900 E0.66786 F3600
G1 X2.800 Y3.800 E0.81626 F3600
G1 X3.100 Y3.500 E0.83062 F3600
G1 X6.200 Y6.600 E0.97902 F3600
G1 X6.500 Y6.300 E0.99338 F3600
G1 X3.400 Y3.200 E1.14177 F3600
G1 X3.500 Y3.100 E1.14656 F3600
G1 X3.200 Y2.800 E1.16092 F3600
G1 X3.700 Y2.100 E1.19004 F3600
G1 X4.000 Y2.400 E1.20440 F3600
G1 X3.800 Y2.600 E1.21397 F3600
G1 X3.900 Y3.000 E1.22793 F3600
G1 X6.600 Y5.700 E1.35718 F3600
G1 X6.600 Y5.900 E1.36395 F3600
G1 X6.800 Y6.100 E1.37352 F3600
G1 X7.200 Y5.800 E1.39044 F3600
G1 X7.100 Y5.700 E1.39523 F3600
G1 X7.200 Y5.600 E1.40002 F3600
G1 X6.900 Y5.400 E1.41222 F3600
G1 X7.000 Y5.300 E1.41701 F3600
G1 X6.900 Y5.200 E1.42180 F3600
G1 X6.800 Y5.300 E1.42658 F3600
G1 X6.600 Y5.100 E1.43616 F3600
G1 X6.600 Y5.000 E1.43954 F3600
G1 X6.800 Y4.800 E1.44912 F3600
G1 X6.600 Y4.600 E1.45869 F3600
G1 X6.400 Y4.800 E1.46826 F3600
G1 X4.700 Y3.100 E1.54964 F3600
G1 X4.600 Y3.100 E1.55303 F3600
G1 X4.200 Y2.700 E1.57217 F3600
G1 X4.500 Y2.400 E1.58654 F3600
G1 X4.800 Y2.700 E1.60090 F3600
G1 X4.900 Y2.600 E1.60568 F3600
G1 X5.100 Y2.800 E1.61526 F3600
G1 X5.200 Y2.700 E1.62004 F3600
G1 X5.400 Y2.900 E1.62962 F3600
G1 X5.300 Y3.000 E1.63440 F3600
G1 X5.400 Y3.200 E1.64197 F3600
G1 X6.300 Y4.100 E1.68506 F3600
G1 X6.300 Y4.200 E1.68844 F3600
G1 X6.500 Y4.400 E1.69801 F3600
G1 X6.700 Y4.200 E1.70759 F3600
G1 X6.500 Y4.000 E1.71716 F3600
G1 X6.600 Y3.900 E1.72195 F3600
G1 X6.400 Y3.700 E1.73152 F3600
G1 X6.500 Y3.600 E1.73631 F3600
G1 X6.400 Y3.500 E1.74110 F3600
G1 X6.400 Y3.600 E1.74448 F3600
G0 X6.100 Y3.400 F9000
G1 X5.700 Y3.000 E1.76363 F3600
G1 X5.900 Y2.800 E1.77320 F3600
G1 X6.500 Y3.100 E1.79591 F3600
;--- Shutdown ---
G1 E1.09591 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---