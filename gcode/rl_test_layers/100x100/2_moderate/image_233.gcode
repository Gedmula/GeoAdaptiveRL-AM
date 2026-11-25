;FLAVOR:Marlin
;Generated from path with 63 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.500 Y-2.100 W32.000 H6.400 ; print area for bed levelling
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
G0 X1.900 Y2.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.700 Y2.300 E0.00957 F3600
G1 X1.800 Y2.400 E0.01436 F3600
G1 X1.900 Y2.800 E0.02832 F3600
G1 X1.800 Y2.900 E0.03310 F3600
G1 X1.800 Y3.100 E0.03987 F3600
G1 X1.500 Y3.400 E0.05423 F3600
G1 X1.700 Y3.600 E0.06381 F3600
G1 X1.900 Y3.500 E0.07138 F3600
G1 X2.300 Y3.900 E0.09053 F3600
G1 X2.500 Y3.700 E0.10010 F3600
G1 X2.100 Y3.300 E0.11925 F3600
G1 X2.400 Y3.000 E0.13361 F3600
G1 X2.800 Y3.400 E0.15276 F3600
G1 X2.900 Y3.300 E0.15754 F3600
G1 X3.100 Y3.500 E0.16712 F3600
G1 X3.300 Y3.300 E0.17669 F3600
G1 X3.500 Y3.500 E0.18626 F3600
G1 X3.600 Y3.400 E0.19105 F3600
G1 X3.700 Y3.600 E0.19862 F3600
G1 X3.800 Y3.500 E0.20341 F3600
G1 X4.000 Y3.700 E0.21298 F3600
G1 X4.100 Y3.600 E0.21777 F3600
G1 X4.400 Y3.900 E0.23213 F3600
G1 X4.300 Y4.100 E0.23970 F3600
G1 X4.500 Y4.300 E0.24927 F3600
G1 X4.600 Y4.200 E0.25406 F3600
G1 X4.700 Y4.300 E0.25884 F3600
G1 X5.100 Y4.000 E0.27577 F3600
G1 X4.200 Y3.100 E0.31885 F3600
G1 X4.100 Y3.200 E0.32364 F3600
G1 X3.700 Y2.900 E0.34056 F3600
G1 X3.600 Y3.000 E0.34535 F3600
G1 X3.400 Y2.800 E0.35492 F3600
G1 X3.000 Y3.000 E0.37006 F3600
G1 X2.700 Y2.700 E0.38442 F3600
G1 X2.300 Y2.700 E0.39796 F3600
G1 X2.200 Y2.600 E0.40275 F3600
G1 X2.200 Y2.300 E0.41290 F3600
G1 X2.500 Y2.000 E0.42726 F3600
G1 X3.100 Y2.700 E0.45847 F3600
G1 X3.300 Y2.500 E0.46805 F3600
G1 X3.400 Y2.600 E0.47283 F3600
G1 X3.800 Y2.400 E0.48797 F3600
G1 X4.000 Y2.600 E0.49754 F3600
G1 X4.100 Y2.500 E0.50233 F3600
G1 X4.200 Y2.600 E0.50712 F3600
G1 X4.300 Y2.500 E0.51190 F3600
G1 X4.600 Y2.900 E0.52883 F3600
G1 X4.600 Y3.000 E0.53221 F3600
G1 X5.000 Y3.400 E0.55136 F3600
G1 X5.100 Y3.300 E0.55615 F3600
G1 X5.000 Y3.200 E0.56094 F3600
G1 X5.100 Y3.100 E0.56572 F3600
G1 X5.000 Y3.000 E0.57051 F3600
G1 X5.100 Y2.900 E0.57530 F3600
G1 X4.800 Y2.600 E0.58966 F3600
G1 X4.800 Y2.500 E0.59304 F3600
G1 X4.400 Y2.200 E0.60997 F3600
G0 X4.600 Y2.000 F9000
G1 X4.700 Y1.900 E0.61475 F3600
G1 X5.200 Y2.300 E0.63643 F3600
;--- Shutdown ---
G1 E-0.06357 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---