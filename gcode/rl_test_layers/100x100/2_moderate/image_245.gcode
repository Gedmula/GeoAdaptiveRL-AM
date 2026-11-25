;FLAVOR:Marlin
;Generated from path with 62 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X5.100 Y-2.200 W32.000 H7.900 ; print area for bed levelling
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
G0 X5.100 Y3.000 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.200 Y2.900 E0.00479 F3600
G1 X5.400 Y3.100 E0.01436 F3600
G1 X5.500 Y3.100 E0.01775 F3600
G1 X6.700 Y4.400 E0.07763 F3600
G1 X6.600 Y4.500 E0.08242 F3600
G1 X6.700 Y4.600 E0.08720 F3600
G1 X6.600 Y4.700 E0.09199 F3600
G1 X6.700 Y4.800 E0.09678 F3600
G1 X6.700 Y5.000 E0.10355 F3600
G1 X6.600 Y5.100 E0.10833 F3600
G1 X6.700 Y5.200 E0.11312 F3600
G1 X6.600 Y5.300 E0.11791 F3600
G1 X6.900 Y5.600 E0.13227 F3600
G1 X7.200 Y5.700 E0.14297 F3600
G1 X7.400 Y5.500 E0.15255 F3600
G1 X7.500 Y5.600 E0.15733 F3600
G1 X7.600 Y5.500 E0.16212 F3600
G1 X7.500 Y5.400 E0.16691 F3600
G1 X7.600 Y5.300 E0.17170 F3600
G1 X7.500 Y5.200 E0.17648 F3600
G1 X7.600 Y5.100 E0.18127 F3600
G1 X7.500 Y5.000 E0.18606 F3600
G1 X7.200 Y5.300 E0.20042 F3600
G1 X7.000 Y5.100 E0.20999 F3600
G1 X7.200 Y4.900 E0.21956 F3600
G1 X7.100 Y4.700 E0.22713 F3600
G1 X7.200 Y4.500 E0.23470 F3600
G1 X6.900 Y4.200 E0.24906 F3600
G1 X7.000 Y4.100 E0.25385 F3600
G1 X5.700 Y2.700 E0.31852 F3600
G1 X5.500 Y2.700 E0.32529 F3600
G1 X5.100 Y2.500 E0.34043 F3600
G1 X5.400 Y2.200 E0.35479 F3600
G1 X5.700 Y2.200 E0.36494 F3600
G1 X5.800 Y2.100 E0.36973 F3600
G1 X6.000 Y2.300 E0.37930 F3600
G1 X5.900 Y2.400 E0.38409 F3600
G1 X6.700 Y3.100 E0.42007 F3600
G1 X6.800 Y3.400 E0.43077 F3600
G1 X7.200 Y3.800 E0.44992 F3600
G1 X7.300 Y3.700 E0.45471 F3600
G1 X7.300 Y3.600 E0.45809 F3600
G1 X7.100 Y3.400 E0.46767 F3600
G1 X7.200 Y3.300 E0.47245 F3600
G1 X7.100 Y3.200 E0.47724 F3600
G1 X7.200 Y3.100 E0.48203 F3600
G1 X7.100 Y3.000 E0.48682 F3600
G1 X7.200 Y2.900 E0.49160 F3600
G1 X6.700 Y2.500 E0.51328 F3600
G1 X6.600 Y2.500 E0.51666 F3600
G1 X6.200 Y2.100 E0.53581 F3600
G1 X6.400 Y1.900 E0.54538 F3600
G1 X6.500 Y2.000 E0.55017 F3600
G1 X6.600 Y1.900 E0.55496 F3600
G1 X6.800 Y2.100 E0.56453 F3600
G1 X7.100 Y1.800 E0.57889 F3600
G1 X7.300 Y2.000 E0.58847 F3600
G1 X7.100 Y2.200 E0.59804 F3600
G1 X7.300 Y2.400 E0.60761 F3600
G1 X7.400 Y2.300 E0.61240 F3600
;--- Shutdown ---
G1 E-0.08760 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---