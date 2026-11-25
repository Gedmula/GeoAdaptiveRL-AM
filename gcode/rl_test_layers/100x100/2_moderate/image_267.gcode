;FLAVOR:Marlin
;Generated from path with 78 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.300 Y1.000 W32.000 H7.800 ; print area for bed levelling
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
G0 X5.300 Y5.900 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.600 Y6.600 E0.03351 F3600
G1 X4.700 Y6.700 E0.03830 F3600
G1 X4.400 Y7.000 E0.05266 F3600
G1 X4.500 Y7.100 E0.05744 F3600
G1 X4.300 Y7.300 E0.06702 F3600
G1 X4.400 Y7.400 E0.07180 F3600
G1 X4.300 Y7.500 E0.07659 F3600
G1 X4.500 Y7.700 E0.08617 F3600
G1 X4.400 Y7.800 E0.09095 F3600
G1 X4.600 Y8.000 E0.10053 F3600
G1 X4.800 Y8.400 E0.11566 F3600
G1 X5.000 Y8.600 E0.12524 F3600
G1 X5.100 Y8.500 E0.13002 F3600
G1 X5.400 Y8.800 E0.14439 F3600
G1 X5.600 Y8.600 E0.15396 F3600
G1 X5.700 Y8.700 E0.15875 F3600
G1 X6.100 Y8.300 E0.17789 F3600
G1 X6.200 Y8.400 E0.18268 F3600
G1 X6.400 Y8.200 E0.19225 F3600
G1 X6.300 Y8.100 E0.19704 F3600
G1 X6.400 Y8.000 E0.20183 F3600
G1 X6.100 Y7.700 E0.21619 F3600
G1 X5.500 Y8.300 E0.24491 F3600
G1 X5.300 Y8.100 E0.25448 F3600
G1 X5.200 Y8.200 E0.25927 F3600
G1 X4.900 Y7.900 E0.27363 F3600
G1 X5.000 Y7.800 E0.27842 F3600
G1 X4.700 Y7.400 E0.29534 F3600
G1 X4.900 Y7.200 E0.30492 F3600
G1 X5.500 Y7.800 E0.33364 F3600
G1 X5.800 Y7.500 E0.34800 F3600
G1 X5.100 Y6.800 E0.38151 F3600
G1 X5.400 Y6.500 E0.39587 F3600
G1 X6.400 Y7.600 E0.44619 F3600
G1 X6.500 Y7.500 E0.45098 F3600
G1 X6.400 Y7.300 E0.45855 F3600
G1 X6.500 Y7.200 E0.46333 F3600
G1 X6.300 Y7.000 E0.47291 F3600
G1 X6.400 Y6.900 E0.47769 F3600
G1 X5.600 Y6.100 E0.51599 F3600
G1 X5.800 Y5.900 E0.52556 F3600
G1 X6.000 Y6.100 E0.53514 F3600
G1 X6.100 Y6.000 E0.53992 F3600
G1 X6.600 Y6.500 E0.56386 F3600
G1 X6.900 Y6.300 E0.57606 F3600
G1 X6.500 Y5.900 E0.59521 F3600
G1 X6.500 Y5.800 E0.59860 F3600
G1 X6.700 Y5.600 E0.60817 F3600
G1 X6.800 Y5.600 E0.61155 F3600
G1 X7.400 Y6.300 E0.64276 F3600
G1 X7.600 Y6.100 E0.65233 F3600
G1 X7.700 Y6.200 E0.65712 F3600
G1 X7.900 Y6.000 E0.66670 F3600
G1 X8.000 Y6.100 E0.67148 F3600
G1 X8.200 Y5.900 E0.68106 F3600
G1 X7.900 Y5.600 E0.69542 F3600
G1 X7.600 Y5.800 E0.70762 F3600
G1 X7.400 Y5.600 E0.71720 F3600
G1 X7.300 Y5.600 E0.72058 F3600
G1 X7.100 Y5.400 E0.73015 F3600
G1 X7.100 Y5.300 E0.73354 F3600
G1 X7.200 Y5.200 E0.73833 F3600
G1 X7.300 Y5.300 E0.74311 F3600
G1 X7.400 Y5.200 E0.74790 F3600
G1 X7.500 Y5.300 E0.75269 F3600
G1 X7.700 Y5.100 E0.76226 F3600
G1 X7.800 Y5.200 E0.76705 F3600
G1 X7.900 Y5.100 E0.77183 F3600
G1 X8.000 Y5.200 E0.77662 F3600
G1 X8.200 Y5.000 E0.78620 F3600
G1 X8.300 Y5.100 E0.79098 F3600
G1 X8.400 Y5.000 E0.79577 F3600
G1 X8.500 Y5.100 E0.80056 F3600
G1 X8.300 Y5.500 E0.81569 F3600
G1 X8.500 Y5.700 E0.82527 F3600
G1 X8.600 Y5.600 E0.83006 F3600
;--- Shutdown ---
G1 E0.13006 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---