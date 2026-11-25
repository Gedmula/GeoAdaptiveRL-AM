;FLAVOR:Marlin
;Generated from path with 67 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X5.100 Y1.500 W32.000 H7.200 ; print area for bed levelling
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
G0 X5.300 Y5.500 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.100 Y5.700 E0.00957 F3600
G1 X5.200 Y5.800 E0.01436 F3600
G1 X5.100 Y5.900 E0.01915 F3600
G1 X5.700 Y6.500 E0.04787 F3600
G1 X5.800 Y6.500 E0.05125 F3600
G1 X6.000 Y6.700 E0.06083 F3600
G1 X6.100 Y6.600 E0.06562 F3600
G1 X6.200 Y6.700 E0.07040 F3600
G1 X6.400 Y6.500 E0.07998 F3600
G1 X6.100 Y6.200 E0.09434 F3600
G1 X5.900 Y6.200 E0.10111 F3600
G1 X5.600 Y5.900 E0.11547 F3600
G1 X5.600 Y5.800 E0.11885 F3600
G1 X5.800 Y5.600 E0.12843 F3600
G1 X6.500 Y6.300 E0.16193 F3600
G0 X7.000 Y6.800 F9000
G1 X7.100 Y6.900 E0.16672 F3600
G1 X6.900 Y7.100 E0.17630 F3600
G1 X7.000 Y7.200 E0.18108 F3600
G1 X6.800 Y7.400 E0.19066 F3600
G1 X6.900 Y7.500 E0.19544 F3600
G1 X6.600 Y7.800 E0.20980 F3600
G1 X6.700 Y7.900 E0.21459 F3600
G1 X6.600 Y8.000 E0.21938 F3600
G1 X7.000 Y8.500 E0.24105 F3600
G1 X7.400 Y8.700 E0.25619 F3600
G1 X7.500 Y8.600 E0.26098 F3600
G1 X7.600 Y8.700 E0.26576 F3600
G1 X7.800 Y8.500 E0.27534 F3600
G1 X7.900 Y8.600 E0.28012 F3600
G1 X8.200 Y8.300 E0.29449 F3600
G1 X7.900 Y8.000 E0.30885 F3600
G1 X7.800 Y8.000 E0.31223 F3600
G1 X7.400 Y8.400 E0.33138 F3600
G1 X7.100 Y8.100 E0.34574 F3600
G1 X7.200 Y7.900 E0.35331 F3600
G1 X7.100 Y7.800 E0.35810 F3600
G1 X7.300 Y7.600 E0.36767 F3600
G1 X7.500 Y7.700 E0.37524 F3600
G1 X7.700 Y7.500 E0.38481 F3600
G1 X7.400 Y7.200 E0.39917 F3600
G1 X7.600 Y7.000 E0.40875 F3600
G1 X7.300 Y6.700 E0.42311 F3600
G1 X7.600 Y6.400 E0.43747 F3600
G1 X7.700 Y6.500 E0.44226 F3600
G1 X7.800 Y6.400 E0.44704 F3600
G1 X7.900 Y6.500 E0.45183 F3600
G1 X8.000 Y6.400 E0.45662 F3600
G1 X8.200 Y6.600 E0.46619 F3600
G1 X7.900 Y6.900 E0.48055 F3600
G1 X8.000 Y7.000 E0.48534 F3600
G1 X8.000 Y7.300 E0.49549 F3600
G1 X8.100 Y7.400 E0.50028 F3600
G1 X8.000 Y7.600 E0.50785 F3600
G1 X8.500 Y8.100 E0.53178 F3600
G1 X8.600 Y8.000 E0.53657 F3600
G1 X8.500 Y7.900 E0.54136 F3600
G1 X8.700 Y7.700 E0.55093 F3600
G1 X8.500 Y7.500 E0.56050 F3600
G1 X8.600 Y7.400 E0.56529 F3600
G1 X8.500 Y7.300 E0.57008 F3600
G1 X8.600 Y7.100 E0.57765 F3600
G1 X8.500 Y6.900 E0.58522 F3600
G1 X8.600 Y6.700 E0.59278 F3600
G1 X8.500 Y6.600 E0.59757 F3600
;--- Shutdown ---
G1 E-0.10243 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---