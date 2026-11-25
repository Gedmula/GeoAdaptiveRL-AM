;FLAVOR:Marlin
;Generated from path with 58 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.200 Y-2.700 W32.000 H9.300 ; print area for bed levelling
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
G0 X4.700 Y4.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.800 Y4.800 E0.00479 F3600
G1 X4.200 Y5.500 E0.03599 F3600
G1 X4.600 Y5.900 E0.05514 F3600
G1 X4.700 Y5.800 E0.05993 F3600
G1 X5.400 Y6.500 E0.09344 F3600
G1 X5.600 Y6.600 E0.10101 F3600
G1 X5.900 Y6.300 E0.11537 F3600
G1 X5.000 Y5.400 E0.15845 F3600
G1 X4.900 Y5.500 E0.16324 F3600
G1 X4.800 Y5.400 E0.16802 F3600
G1 X5.200 Y5.000 E0.18717 F3600
G1 X6.200 Y6.000 E0.23504 F3600
G1 X6.400 Y5.800 E0.24461 F3600
G1 X6.300 Y5.700 E0.24940 F3600
G1 X6.400 Y5.600 E0.25419 F3600
G1 X5.300 Y4.500 E0.30684 F3600
G1 X5.200 Y4.600 E0.31163 F3600
G1 X5.000 Y4.400 E0.32121 F3600
G1 X5.200 Y4.200 E0.33078 F3600
G1 X5.100 Y4.100 E0.33557 F3600
G1 X5.300 Y3.900 E0.34514 F3600
G1 X5.400 Y3.900 E0.34853 F3600
G1 X6.400 Y4.900 E0.39639 F3600
G1 X6.400 Y5.100 E0.40316 F3600
G1 X6.600 Y5.300 E0.41274 F3600
G1 X6.900 Y5.000 E0.42710 F3600
G1 X6.800 Y4.900 E0.43189 F3600
G1 X6.900 Y4.700 E0.43945 F3600
G1 X5.800 Y3.600 E0.49211 F3600
G1 X5.600 Y3.500 E0.49968 F3600
G1 X5.900 Y3.100 E0.51660 F3600
G1 X7.200 Y4.400 E0.57883 F3600
G1 X7.500 Y4.000 E0.59576 F3600
G1 X7.300 Y3.900 E0.60333 F3600
G1 X6.100 Y2.700 E0.66077 F3600
G1 X6.400 Y2.400 E0.67513 F3600
G1 X7.700 Y3.700 E0.73736 F3600
G1 X7.900 Y3.500 E0.74694 F3600
G1 X7.800 Y3.400 E0.75172 F3600
G1 X7.900 Y3.300 E0.75651 F3600
G1 X6.800 Y2.100 E0.81161 F3600
G1 X6.600 Y2.100 E0.81838 F3600
G1 X6.500 Y2.000 E0.82317 F3600
G1 X7.100 Y1.300 E0.85438 F3600
G1 X7.300 Y1.500 E0.86395 F3600
G1 X7.300 Y1.600 E0.86733 F3600
G1 X7.100 Y1.800 E0.87691 F3600
G1 X7.900 Y2.600 E0.91520 F3600
G1 X7.900 Y2.700 E0.91859 F3600
G1 X8.100 Y2.900 E0.92816 F3600
G1 X8.400 Y2.600 E0.94252 F3600
G1 X8.300 Y2.500 E0.94731 F3600
G1 X8.500 Y2.300 E0.95688 F3600
G1 X8.400 Y2.200 E0.96167 F3600
G1 X8.200 Y2.200 E0.96844 F3600
G1 X7.700 Y1.800 E0.99012 F3600
;--- Shutdown ---
G1 E0.29012 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---