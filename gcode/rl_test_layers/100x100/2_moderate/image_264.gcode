;FLAVOR:Marlin
;Generated from path with 92 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.200 Y-2.000 W32.000 H7.800 ; print area for bed levelling
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
G0 X3.400 Y3.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.500 Y3.500 E0.00479 F3600
G1 X3.200 Y3.800 E0.01915 F3600
G1 X3.300 Y3.900 E0.02393 F3600
G1 X3.200 Y4.100 E0.03150 F3600
G1 X3.300 Y4.200 E0.03629 F3600
G1 X3.200 Y4.300 E0.04108 F3600
G1 X3.300 Y4.400 E0.04586 F3600
G1 X3.200 Y4.500 E0.05065 F3600
G1 X3.400 Y4.700 E0.06023 F3600
G1 X3.300 Y4.800 E0.06501 F3600
G1 X4.000 Y5.500 E0.09852 F3600
G1 X4.100 Y5.400 E0.10331 F3600
G1 X4.300 Y5.700 E0.11551 F3600
G1 X4.400 Y5.600 E0.12030 F3600
G1 X4.600 Y5.800 E0.12987 F3600
G1 X4.800 Y5.600 E0.13945 F3600
G1 X4.900 Y5.700 E0.14423 F3600
G1 X5.100 Y5.500 E0.15381 F3600
G1 X5.200 Y5.600 E0.15859 F3600
G1 X5.500 Y5.300 E0.17296 F3600
G1 X5.100 Y4.900 E0.19210 F3600
G1 X4.700 Y5.300 E0.21125 F3600
G1 X4.100 Y5.000 E0.23396 F3600
G1 X3.800 Y4.700 E0.24832 F3600
G1 X3.800 Y4.500 E0.25509 F3600
G1 X3.700 Y4.400 E0.25987 F3600
G1 X3.800 Y4.200 E0.26744 F3600
G1 X3.600 Y4.000 E0.27702 F3600
G1 X3.800 Y3.800 E0.28659 F3600
G1 X4.200 Y4.200 E0.30574 F3600
G1 X4.300 Y4.400 E0.31331 F3600
G1 X4.200 Y4.500 E0.31810 F3600
G1 X4.600 Y4.900 E0.33724 F3600
G1 X4.900 Y4.600 E0.35160 F3600
G1 X4.600 Y4.200 E0.36853 F3600
G1 X4.600 Y4.100 E0.37191 F3600
G1 X3.600 Y3.100 E0.41978 F3600
G1 X3.800 Y2.900 E0.42936 F3600
G1 X4.000 Y2.800 E0.43693 F3600
G1 X4.100 Y2.900 E0.44171 F3600
G1 X4.300 Y2.700 E0.45129 F3600
G1 X4.500 Y2.900 E0.46086 F3600
G1 X4.300 Y3.100 E0.47043 F3600
G1 X4.400 Y3.300 E0.47800 F3600
G1 X5.200 Y4.100 E0.51630 F3600
G1 X5.100 Y4.200 E0.52109 F3600
G1 X5.500 Y4.600 E0.54023 F3600
G1 X5.500 Y4.800 E0.54700 F3600
G1 X5.700 Y5.000 E0.55658 F3600
G1 X5.900 Y4.900 E0.56415 F3600
G1 X5.800 Y4.800 E0.56893 F3600
G1 X6.000 Y4.600 E0.57851 F3600
G1 X5.900 Y4.500 E0.58329 F3600
G1 X6.000 Y4.400 E0.58808 F3600
G1 X5.800 Y4.200 E0.59765 F3600
G1 X6.000 Y3.900 E0.60986 F3600
G1 X5.800 Y3.700 E0.61943 F3600
G1 X5.600 Y3.900 E0.62901 F3600
G1 X5.500 Y3.900 E0.63239 F3600
G1 X4.800 Y3.100 E0.66837 F3600
G1 X4.800 Y2.800 E0.67853 F3600
G1 X4.900 Y2.700 E0.68331 F3600
G1 X5.000 Y2.800 E0.68810 F3600
G1 X5.100 Y2.700 E0.69289 F3600
G1 X5.700 Y3.300 E0.72161 F3600
G1 X5.800 Y3.200 E0.72640 F3600
G1 X6.100 Y3.500 E0.74076 F3600
G1 X6.200 Y3.400 E0.74554 F3600
G0 X6.700 Y2.900 F9000
G1 X6.700 Y2.800 E0.74893 F3600
G1 X6.500 Y2.600 E0.75850 F3600
G1 X6.600 Y2.500 E0.76329 F3600
G1 X6.500 Y2.400 E0.76808 F3600
G1 X6.900 Y2.000 E0.78723 F3600
G1 X7.000 Y2.100 E0.79201 F3600
G1 X7.200 Y2.000 E0.79958 F3600
G1 X7.400 Y2.200 E0.80915 F3600
G1 X7.000 Y2.600 E0.82830 F3600
G1 X7.200 Y2.900 E0.84051 F3600
G1 X7.300 Y2.800 E0.84529 F3600
G1 X7.500 Y2.900 E0.85286 F3600
G1 X7.700 Y2.700 E0.86244 F3600
G1 X7.600 Y2.600 E0.86722 F3600
G1 X7.700 Y2.400 E0.87479 F3600
G1 X8.000 Y2.700 E0.88915 F3600
G1 X8.200 Y2.500 E0.89873 F3600
G1 X8.100 Y2.400 E0.90351 F3600
G1 X8.300 Y2.200 E0.91309 F3600
G1 X8.100 Y2.000 E0.92266 F3600
G1 X7.900 Y2.000 E0.92943 F3600
;--- Shutdown ---
G1 E0.22943 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---