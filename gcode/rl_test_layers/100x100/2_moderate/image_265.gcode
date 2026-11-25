;FLAVOR:Marlin
;Generated from path with 90 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.900 Y-2.500 W32.000 H8.000 ; print area for bed levelling
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
G0 X3.100 Y3.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.200 Y3.200 E0.00479 F3600
G1 X3.100 Y3.300 E0.00957 F3600
G1 X3.200 Y3.400 E0.01436 F3600
G1 X2.900 Y3.700 E0.02872 F3600
G1 X3.000 Y3.800 E0.03351 F3600
G1 X2.900 Y3.900 E0.03830 F3600
G1 X3.200 Y4.200 E0.05266 F3600
G1 X3.100 Y4.300 E0.05744 F3600
G1 X3.900 Y5.200 E0.09820 F3600
G1 X4.100 Y5.300 E0.10577 F3600
G1 X4.200 Y5.200 E0.11056 F3600
G1 X4.300 Y5.300 E0.11535 F3600
G1 X4.500 Y5.300 E0.12212 F3600
G1 X4.700 Y5.500 E0.13169 F3600
G1 X4.900 Y5.300 E0.14126 F3600
G1 X5.000 Y5.400 E0.14605 F3600
G1 X5.300 Y5.100 E0.16041 F3600
G1 X5.400 Y5.200 E0.16520 F3600
G1 X6.000 Y4.600 E0.19392 F3600
G1 X5.800 Y4.400 E0.20349 F3600
G1 X5.600 Y4.500 E0.21106 F3600
G1 X5.500 Y4.400 E0.21585 F3600
G1 X4.800 Y5.000 E0.24706 F3600
G1 X4.400 Y4.800 E0.26219 F3600
G1 X4.200 Y4.900 E0.26976 F3600
G1 X3.600 Y4.300 E0.29848 F3600
G1 X3.700 Y4.200 E0.30327 F3600
G1 X3.400 Y3.900 E0.31763 F3600
G1 X3.500 Y3.800 E0.32242 F3600
G1 X3.400 Y3.700 E0.32721 F3600
G1 X3.600 Y3.500 E0.33678 F3600
G1 X4.200 Y4.100 E0.36550 F3600
G1 X4.100 Y4.200 E0.37029 F3600
G1 X4.400 Y4.500 E0.38465 F3600
G1 X4.700 Y4.500 E0.39480 F3600
G1 X4.900 Y4.300 E0.40438 F3600
G1 X4.500 Y3.900 E0.42353 F3600
G1 X4.500 Y3.800 E0.42691 F3600
G1 X3.800 Y3.100 E0.46042 F3600
G1 X3.700 Y3.100 E0.46380 F3600
G1 X3.500 Y2.900 E0.47338 F3600
G1 X3.900 Y2.500 E0.49253 F3600
G1 X4.100 Y2.700 E0.50210 F3600
G1 X4.300 Y2.500 E0.51167 F3600
G1 X4.400 Y2.600 E0.51646 F3600
G1 X4.500 Y2.500 E0.52125 F3600
G1 X4.700 Y2.700 E0.53082 F3600
G1 X4.400 Y3.000 E0.54518 F3600
G1 X4.400 Y3.100 E0.54857 F3600
G1 X5.200 Y3.900 E0.58686 F3600
G1 X5.300 Y4.100 E0.59443 F3600
G1 X5.400 Y4.000 E0.59922 F3600
G1 X5.700 Y4.000 E0.60937 F3600
G1 X5.900 Y4.200 E0.61895 F3600
G1 X6.100 Y4.100 E0.62652 F3600
G1 X6.000 Y3.900 E0.63408 F3600
G1 X6.100 Y3.700 E0.64165 F3600
G1 X5.900 Y3.500 E0.65123 F3600
G1 X5.600 Y3.600 E0.66193 F3600
G1 X4.900 Y3.000 E0.69314 F3600
G1 X5.200 Y2.700 E0.70750 F3600
G1 X5.600 Y3.100 E0.72665 F3600
G1 X5.700 Y3.000 E0.73143 F3600
G1 X6.000 Y3.300 E0.74579 F3600
G1 X6.100 Y3.200 E0.75058 F3600
G0 X6.200 Y3.100 F9000
G0 X6.700 Y3.000 F9000
G1 X7.100 Y3.300 E0.76751 F3600
G1 X7.200 Y3.200 E0.77229 F3600
G1 X7.300 Y3.300 E0.77708 F3600
G1 X7.500 Y3.100 E0.78665 F3600
G1 X6.900 Y2.500 E0.81538 F3600
G1 X7.200 Y2.200 E0.82974 F3600
G1 X7.900 Y3.000 E0.86572 F3600
G1 X8.100 Y2.800 E0.87529 F3600
G1 X8.000 Y2.700 E0.88008 F3600
G1 X8.100 Y2.500 E0.88765 F3600
G1 X8.000 Y2.500 E0.89103 F3600
G1 X7.400 Y1.900 E0.91975 F3600
G1 X7.800 Y1.500 E0.93890 F3600
G1 X7.900 Y1.600 E0.94369 F3600
G1 X8.100 Y1.500 E0.95126 F3600
G1 X8.200 Y1.600 E0.95604 F3600
G1 X8.200 Y1.700 E0.95943 F3600
G1 X8.000 Y1.900 E0.96900 F3600
G1 X8.400 Y2.300 E0.98815 F3600
G1 X8.500 Y2.200 E0.99294 F3600
G1 X8.500 Y1.900 E1.00309 F3600
;--- Shutdown ---
G1 E0.30309 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---