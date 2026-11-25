;FLAVOR:Marlin
;Generated from path with 41 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.600 Y2.500 W32.000 H6.300 ; print area for bed levelling
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
G0 X4.500 Y6.500 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.500 Y6.600 E0.00338 F3600
G1 X3.600 Y7.500 E0.04647 F3600
G1 X3.900 Y7.800 E0.06083 F3600
G1 X3.700 Y8.000 E0.07040 F3600
G1 X3.800 Y8.100 E0.07519 F3600
G1 X3.700 Y8.200 E0.07998 F3600
G1 X3.900 Y8.400 E0.08955 F3600
G1 X4.000 Y8.300 E0.09434 F3600
G1 X4.200 Y8.500 E0.10391 F3600
G1 X4.400 Y8.600 E0.11148 F3600
G1 X4.500 Y8.500 E0.11627 F3600
G1 X4.700 Y8.700 E0.12584 F3600
G1 X4.800 Y8.600 E0.13063 F3600
G1 X5.000 Y8.800 E0.14020 F3600
G1 X5.100 Y8.700 E0.14499 F3600
G1 X5.300 Y8.800 E0.15256 F3600
G1 X5.500 Y8.600 E0.16213 F3600
G1 X4.900 Y8.100 E0.18857 F3600
G1 X4.600 Y8.300 E0.20077 F3600
G1 X4.300 Y8.000 E0.21513 F3600
G1 X4.400 Y7.800 E0.22270 F3600
G1 X4.200 Y7.600 E0.23228 F3600
G1 X4.200 Y7.500 E0.23566 F3600
G1 X4.400 Y7.300 E0.24523 F3600
G1 X4.500 Y7.300 E0.24862 F3600
G1 X5.600 Y8.400 E0.30128 F3600
G1 X5.900 Y8.100 E0.31564 F3600
G1 X4.700 Y7.000 E0.37074 F3600
G1 X5.000 Y6.600 E0.38766 F3600
G1 X5.200 Y6.800 E0.39724 F3600
G1 X5.300 Y6.700 E0.40202 F3600
G1 X5.400 Y6.800 E0.40681 F3600
G1 X5.400 Y7.100 E0.41697 F3600
G1 X5.500 Y7.200 E0.42175 F3600
G1 X5.600 Y7.200 E0.42514 F3600
G1 X5.800 Y7.000 E0.43471 F3600
G1 X5.900 Y7.100 E0.43950 F3600
G1 X5.800 Y7.300 E0.44707 F3600
G1 X6.000 Y7.500 E0.45664 F3600
;--- Shutdown ---
G1 E-0.24336 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---