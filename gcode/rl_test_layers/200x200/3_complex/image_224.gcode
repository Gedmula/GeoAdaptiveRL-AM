;FLAVOR:Marlin
;Generated from path with 80 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.100 Y-0.800 W32.000 H17.300 ; print area for bed levelling
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
G0 X4.100 Y3.900 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.200 Y3.800 E0.00479 F3600
G1 X4.600 Y4.200 E0.02393 F3600
G1 X4.600 Y4.300 E0.02732 F3600
G1 X7.000 Y6.700 E0.14221 F3600
G1 X7.200 Y6.600 E0.14978 F3600
G1 X7.400 Y6.800 E0.15935 F3600
G0 X7.500 Y6.900 F9000
G0 X7.400 Y7.000 F9000
G1 X7.400 Y7.100 E0.16273 F3600
G0 X7.600 Y7.300 F9000
G1 X7.700 Y7.500 E0.17030 F3600
G1 X13.400 Y13.200 E0.44316 F3600
G1 X13.500 Y13.100 E0.44795 F3600
G1 X13.800 Y13.400 E0.46231 F3600
G0 X13.900 Y13.500 F9000
G0 X13.800 Y13.600 F9000
G1 X15.900 Y15.700 E0.56283 F3600
G1 X15.900 Y15.800 E0.56622 F3600
G1 X16.600 Y16.500 E0.59973 F3600
G1 X16.700 Y16.400 E0.60451 F3600
G1 X16.800 Y16.500 E0.60930 F3600
G1 X17.400 Y15.900 E0.63802 F3600
G1 X17.200 Y15.700 E0.64760 F3600
G1 X17.100 Y15.700 E0.65098 F3600
G1 X16.800 Y16.000 E0.66534 F3600
G1 X16.500 Y15.700 E0.67970 F3600
G1 X16.800 Y15.400 E0.69406 F3600
G1 X16.600 Y15.200 E0.70364 F3600
G1 X16.300 Y15.500 E0.71800 F3600
G1 X16.000 Y15.200 E0.73236 F3600
G1 X16.000 Y15.100 E0.73574 F3600
G1 X16.300 Y14.800 E0.75010 F3600
G1 X16.100 Y14.600 E0.75968 F3600
G1 X16.000 Y14.600 E0.76306 F3600
G1 X15.700 Y14.900 E0.77742 F3600
G1 X14.800 Y14.000 E0.82051 F3600
G1 X14.800 Y13.900 E0.82389 F3600
G1 X14.600 Y13.800 E0.83146 F3600
G1 X14.200 Y13.400 E0.85061 F3600
G1 X14.500 Y13.100 E0.86497 F3600
G1 X15.300 Y13.900 E0.90326 F3600
G1 X15.300 Y14.000 E0.90665 F3600
G1 X15.400 Y14.100 E0.91144 F3600
G1 X15.500 Y14.000 E0.91622 F3600
G1 X15.500 Y14.100 E0.91961 F3600
G1 X15.700 Y14.300 E0.92918 F3600
G1 X15.800 Y14.200 E0.93397 F3600
G1 X15.700 Y14.100 E0.93876 F3600
G1 E0.23876 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X13.900 Y13.000 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.93876 F2100 ; unretract
G1 X13.900 Y12.900 E0.94214 F3600
G1 X14.100 Y12.700 E0.95171 F3600
G1 X13.900 Y12.500 E0.96129 F3600
G1 X13.500 Y12.700 E0.97643 F3600
G1 X8.100 Y7.300 E1.23492 F3600
G1 X8.100 Y7.200 E1.23831 F3600
G1 X7.700 Y6.800 E1.25745 F3600
G1 X8.000 Y6.500 E1.27181 F3600
G1 X8.800 Y7.300 E1.31011 F3600
G1 X8.800 Y7.400 E1.31349 F3600
G1 X13.300 Y11.800 E1.52653 F3600
G1 X13.300 Y12.000 E1.53330 F3600
G1 X13.400 Y12.100 E1.53808 F3600
G1 X13.500 Y12.000 E1.54287 F3600
G1 X13.800 Y12.300 E1.55723 F3600
G1 X13.900 Y12.200 E1.56202 F3600
G1 E0.86202 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X7.500 Y6.400 F9000
G1 Z0.200 F9000 ; lower z
G1 E1.56202 F2100 ; unretract
G1 X7.500 Y6.300 E1.56540 F3600
G1 X7.700 Y6.100 E1.57498 F3600
G1 X7.500 Y5.900 E1.58455 F3600
G1 X7.200 Y6.200 E1.59891 F3600
G1 X7.100 Y6.200 E1.60230 F3600
G1 X4.400 Y3.500 E1.73154 F3600
G1 X4.700 Y3.200 E1.74590 F3600
G1 X4.900 Y3.400 E1.75548 F3600
G1 X5.000 Y3.400 E1.75886 F3600
G1 X6.900 Y5.300 E1.84982 F3600
G1 X6.900 Y5.400 E1.85320 F3600
G1 X7.100 Y5.600 E1.86277 F3600
;--- Shutdown ---
G1 E1.16277 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---