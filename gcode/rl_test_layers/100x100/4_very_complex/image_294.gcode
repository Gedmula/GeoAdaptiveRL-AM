;FLAVOR:Marlin
;Generated from path with 88 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X0.700 Y-1.300 W32.000 H10.200 ; print area for bed levelling
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
G0 X1.400 Y2.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X0.900 Y3.200 E0.02393 F3600
G1 X1.000 Y3.300 E0.02872 F3600
G1 X0.700 Y3.600 E0.04308 F3600
G1 X0.800 Y3.700 E0.04787 F3600
G1 X0.700 Y3.800 E0.05266 F3600
G1 X1.500 Y4.700 E0.09342 F3600
G1 X1.400 Y4.900 E0.10098 F3600
G1 X1.500 Y5.000 E0.10577 F3600
G1 X1.400 Y5.100 E0.11056 F3600
G1 X1.500 Y5.200 E0.11535 F3600
G1 X1.400 Y5.300 E0.12013 F3600
G1 X1.600 Y5.700 E0.13527 F3600
G1 X1.500 Y5.800 E0.14006 F3600
G1 X1.700 Y6.000 E0.14963 F3600
G1 X1.600 Y6.100 E0.15442 F3600
G1 X1.900 Y6.500 E0.17134 F3600
G1 X1.900 Y6.600 E0.17473 F3600
G1 X2.500 Y7.300 E0.20593 F3600
G1 X2.700 Y7.400 E0.21350 F3600
G1 X2.800 Y7.300 E0.21829 F3600
G1 X3.000 Y7.500 E0.22786 F3600
G1 X3.100 Y7.400 E0.23265 F3600
G1 X3.300 Y7.600 E0.24222 F3600
G1 X3.400 Y7.500 E0.24701 F3600
G1 X3.600 Y7.700 E0.25659 F3600
G1 X3.700 Y7.600 E0.26137 F3600
G1 X3.900 Y7.800 E0.27095 F3600
G1 X4.100 Y7.700 E0.27852 F3600
G1 X4.600 Y8.200 E0.30245 F3600
G1 X4.600 Y8.300 E0.30583 F3600
G1 X5.300 Y8.900 E0.33704 F3600
G1 X5.500 Y8.700 E0.34662 F3600
G1 X5.600 Y8.800 E0.35140 F3600
G1 X5.700 Y8.800 E0.35479 F3600
G1 X5.900 Y8.600 E0.36436 F3600
G1 X6.000 Y8.700 E0.36915 F3600
G1 X6.300 Y8.300 E0.38607 F3600
G1 X6.100 Y8.100 E0.39565 F3600
G1 X5.800 Y8.400 E0.41001 F3600
G1 X5.700 Y8.300 E0.41479 F3600
G1 X5.500 Y8.500 E0.42437 F3600
G0 X5.200 Y8.400 F9000
G1 X5.100 Y8.300 E0.42916 F3600
G0 X4.900 Y8.100 F9000
G1 X4.800 Y8.000 E0.43394 F3600
G1 X4.900 Y7.900 E0.43873 F3600
G1 X4.300 Y7.300 E0.46745 F3600
G1 X4.200 Y7.400 E0.47224 F3600
G1 X3.800 Y7.400 E0.48578 F3600
G1 X3.400 Y7.100 E0.50270 F3600
G0 X2.900 Y7.000 F9000
G1 X2.800 Y7.000 E0.50609 F3600
G0 X2.600 Y6.800 F9000
G1 X2.500 Y6.700 E0.51087 F3600
G0 X2.300 Y6.500 F9000
G1 X2.000 Y6.200 E0.52523 F3600
G1 X2.100 Y6.100 E0.53002 F3600
G1 X1.900 Y5.900 E0.53960 F3600
G1 X2.000 Y5.800 E0.54438 F3600
G1 X1.800 Y5.600 E0.55396 F3600
G1 X1.900 Y5.500 E0.55874 F3600
G1 X1.800 Y5.400 E0.56353 F3600
G1 X2.000 Y5.200 E0.57310 F3600
G1 X1.900 Y5.000 E0.58067 F3600
G1 X2.100 Y4.800 E0.59025 F3600
G1 X2.400 Y5.100 E0.60461 F3600
G1 X2.600 Y5.100 E0.61138 F3600
G1 X2.700 Y5.000 E0.61616 F3600
G1 X2.900 Y5.200 E0.62574 F3600
G1 X3.100 Y5.300 E0.63331 F3600
G1 X3.200 Y5.200 E0.63809 F3600
G1 X3.400 Y5.400 E0.64767 F3600
G1 X3.500 Y5.300 E0.65245 F3600
G1 X3.600 Y5.400 E0.65724 F3600
G1 X3.700 Y5.300 E0.66203 F3600
G1 X3.600 Y5.200 E0.66682 F3600
G1 X3.800 Y5.000 E0.67639 F3600
G1 X4.100 Y5.300 E0.69075 F3600
G1 X4.000 Y5.400 E0.69554 F3600
G1 X4.100 Y5.500 E0.70032 F3600
G1 X4.300 Y5.300 E0.70990 F3600
G1 X4.200 Y5.200 E0.71468 F3600
G1 X4.300 Y5.100 E0.71947 F3600
G1 X4.400 Y5.300 E0.72704 F3600
G1 E0.02704 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X4.500 Y5.400 F9000
G0 X4.400 Y5.500 F9000
;--- Shutdown ---
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---