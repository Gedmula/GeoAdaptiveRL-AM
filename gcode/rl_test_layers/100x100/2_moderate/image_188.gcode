;FLAVOR:Marlin
;Generated from path with 90 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X5.800 Y-2.300 W32.000 H10.400 ; print area for bed levelling
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
G0 X5.900 Y2.900 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X6.100 Y3.100 E0.00957 F3600
G1 X6.000 Y3.200 E0.01436 F3600
G1 X6.100 Y3.300 E0.01915 F3600
G1 X6.000 Y3.400 E0.02393 F3600
G1 X6.200 Y3.600 E0.03351 F3600
G1 X6.100 Y3.700 E0.03830 F3600
G1 X6.200 Y3.800 E0.04308 F3600
G1 X6.100 Y3.900 E0.04787 F3600
G1 X6.200 Y4.000 E0.05266 F3600
G1 X6.100 Y4.100 E0.05744 F3600
G1 X6.300 Y4.300 E0.06702 F3600
G1 X6.200 Y4.400 E0.07180 F3600
G1 X6.300 Y4.500 E0.07659 F3600
G1 X6.200 Y4.600 E0.08138 F3600
G1 X6.300 Y4.700 E0.08617 F3600
G1 X6.200 Y4.800 E0.09095 F3600
G1 X6.300 Y4.900 E0.09574 F3600
G1 X6.200 Y5.000 E0.10053 F3600
G1 X6.400 Y5.200 E0.11010 F3600
G1 X6.300 Y5.300 E0.11489 F3600
G1 X6.400 Y5.400 E0.11967 F3600
G1 X6.300 Y5.500 E0.12446 F3600
G1 X6.400 Y5.600 E0.12925 F3600
G1 X6.300 Y5.700 E0.13403 F3600
G1 X6.500 Y5.900 E0.14361 F3600
G1 X6.400 Y6.000 E0.14840 F3600
G1 X6.500 Y6.100 E0.15318 F3600
G1 X6.400 Y6.200 E0.15797 F3600
G1 X6.500 Y6.300 E0.16276 F3600
G1 X6.400 Y6.400 E0.16754 F3600
G1 X6.600 Y6.600 E0.17712 F3600
G1 X6.500 Y6.700 E0.18190 F3600
G1 X6.600 Y6.800 E0.18669 F3600
G1 X6.500 Y7.000 E0.19426 F3600
G1 X6.600 Y7.100 E0.19905 F3600
G1 X6.500 Y7.200 E0.20383 F3600
G1 X6.600 Y7.300 E0.20862 F3600
G1 X6.500 Y7.400 E0.21341 F3600
G1 X6.700 Y7.600 E0.22298 F3600
G1 X6.600 Y7.700 E0.22777 F3600
G1 X6.600 Y7.900 E0.23454 F3600
G1 X6.800 Y8.100 E0.24411 F3600
G1 X7.000 Y7.900 E0.25369 F3600
G1 X7.100 Y8.000 E0.25847 F3600
G1 X7.300 Y7.800 E0.26805 F3600
G1 X7.200 Y7.700 E0.27283 F3600
G1 X7.300 Y7.600 E0.27762 F3600
G1 X7.100 Y7.400 E0.28719 F3600
G1 X7.200 Y7.300 E0.29198 F3600
G1 X7.000 Y7.100 E0.30156 F3600
G1 X7.200 Y6.900 E0.31113 F3600
G1 X7.100 Y6.800 E0.31592 F3600
G1 X7.200 Y6.600 E0.32348 F3600
G1 X6.900 Y6.400 E0.33569 F3600
G1 X7.000 Y6.300 E0.34048 F3600
G1 X6.900 Y6.200 E0.34526 F3600
G1 X7.100 Y6.000 E0.35484 F3600
G1 X7.000 Y5.900 E0.35962 F3600
G1 X7.100 Y5.700 E0.36719 F3600
G1 X7.000 Y5.600 E0.37198 F3600
G1 X6.900 Y5.700 E0.37677 F3600
G1 X6.700 Y5.500 E0.38634 F3600
G1 X7.000 Y5.200 E0.40070 F3600
G1 X6.800 Y5.000 E0.41028 F3600
G1 X6.900 Y4.900 E0.41506 F3600
G1 X6.700 Y4.700 E0.42464 F3600
G1 X6.900 Y4.500 E0.43421 F3600
G1 X6.800 Y4.400 E0.43900 F3600
G1 X6.900 Y4.200 E0.44657 F3600
G1 X6.600 Y4.000 E0.45877 F3600
G1 X6.800 Y3.700 E0.47097 F3600
G1 X6.600 Y3.400 E0.48318 F3600
G1 X6.700 Y3.300 E0.48797 F3600
G1 X6.500 Y3.100 E0.49754 F3600
G1 X6.700 Y2.900 E0.50711 F3600
G1 X6.600 Y2.800 E0.51190 F3600
G1 X6.200 Y2.700 E0.52586 F3600
G1 X5.900 Y2.400 E0.54022 F3600
G1 X6.000 Y2.300 E0.54500 F3600
G1 X5.800 Y2.100 E0.55458 F3600
G1 X5.800 Y2.000 E0.55796 F3600
G1 X6.000 Y1.800 E0.56754 F3600
G1 X6.200 Y1.900 E0.57511 F3600
G1 X6.400 Y1.700 E0.58468 F3600
G1 X6.600 Y1.900 E0.59425 F3600
G1 X6.400 Y2.100 E0.60383 F3600
G1 X6.400 Y2.200 E0.60721 F3600
G1 X6.600 Y2.400 E0.61679 F3600
;--- Shutdown ---
G1 E-0.08321 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---