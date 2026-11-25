;FLAVOR:Marlin
;Generated from path with 51 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-2.900 W32.000 H6.500 ; print area for bed levelling
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
G0 X1.800 Y1.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.600 Y2.000 E0.00957 F3600
G1 X1.800 Y2.400 E0.02471 F3600
G1 X1.700 Y2.600 E0.03228 F3600
G1 X1.800 Y2.800 E0.03985 F3600
G1 X2.200 Y3.200 E0.05900 F3600
G1 X2.200 Y3.300 E0.06238 F3600
G1 X2.300 Y3.400 E0.06717 F3600
G1 X2.400 Y3.300 E0.07196 F3600
G1 X2.700 Y3.600 E0.08632 F3600
G1 X2.900 Y3.400 E0.09589 F3600
G1 X3.000 Y3.500 E0.10068 F3600
G1 X3.100 Y3.400 E0.10546 F3600
G1 X3.200 Y3.500 E0.11025 F3600
G1 X3.400 Y3.300 E0.11983 F3600
G1 X3.500 Y3.400 E0.12461 F3600
G1 X4.100 Y2.800 E0.15333 F3600
G1 X4.200 Y2.600 E0.16090 F3600
G1 X4.000 Y2.400 E0.17048 F3600
G1 X3.200 Y3.000 E0.20433 F3600
G1 X3.000 Y2.900 E0.21189 F3600
G1 X2.800 Y3.100 E0.22147 F3600
G1 X2.600 Y3.000 E0.22904 F3600
G1 X2.200 Y2.600 E0.24818 F3600
G1 X2.300 Y2.500 E0.25297 F3600
G1 X2.000 Y2.200 E0.26733 F3600
G1 X2.300 Y1.900 E0.28169 F3600
G1 X2.100 Y1.700 E0.29127 F3600
G1 X2.400 Y1.400 E0.30563 F3600
G1 X2.600 Y1.400 E0.31240 F3600
G1 X2.700 Y1.500 E0.31718 F3600
G1 X2.600 Y1.600 E0.32197 F3600
G1 X2.700 Y1.700 E0.32676 F3600
G1 X2.600 Y2.200 E0.34402 F3600
G1 X2.800 Y2.600 E0.35916 F3600
G1 X2.900 Y2.500 E0.36394 F3600
G1 X3.000 Y2.600 E0.36873 F3600
G1 X3.200 Y2.400 E0.37830 F3600
G1 X3.000 Y2.200 E0.38788 F3600
G1 X3.200 Y2.000 E0.39745 F3600
G1 X3.100 Y1.900 E0.40224 F3600
G1 X3.300 Y1.700 E0.41181 F3600
G1 X2.900 Y1.300 E0.43096 F3600
G1 X3.100 Y1.100 E0.44053 F3600
G1 X3.200 Y1.200 E0.44532 F3600
G1 X3.300 Y1.100 E0.45011 F3600
G1 X3.800 Y1.600 E0.47404 F3600
G1 X3.500 Y2.100 E0.49378 F3600
G1 X3.600 Y2.300 E0.50135 F3600
G1 X4.200 Y1.700 E0.53007 F3600
;--- Shutdown ---
G1 E-0.16993 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---