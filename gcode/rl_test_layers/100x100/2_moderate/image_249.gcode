;FLAVOR:Marlin
;Generated from path with 49 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.800 Y0.700 W32.000 H7.700 ; print area for bed levelling
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
G0 X4.100 Y4.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.800 Y5.000 E0.01436 F3600
G1 X3.900 Y5.100 E0.01915 F3600
G1 X3.800 Y5.300 E0.02672 F3600
G1 X4.100 Y5.600 E0.04108 F3600
G1 X4.300 Y5.600 E0.04785 F3600
G1 X4.500 Y5.400 E0.05742 F3600
G1 X4.300 Y5.200 E0.06699 F3600
G1 X4.300 Y5.100 E0.07038 F3600
G1 X4.500 Y4.900 E0.07995 F3600
G1 X4.700 Y5.100 E0.08953 F3600
G1 X4.700 Y5.200 E0.09291 F3600
G0 X5.400 Y6.000 F9000
G1 X5.500 Y6.100 E0.09770 F3600
G1 X5.300 Y6.300 E0.10727 F3600
G1 X5.400 Y6.500 E0.11484 F3600
G1 X5.000 Y6.900 E0.13399 F3600
G1 X5.700 Y7.600 E0.16750 F3600
G1 X5.600 Y7.700 E0.17229 F3600
G1 X5.900 Y8.000 E0.18665 F3600
G1 X5.900 Y8.200 E0.19342 F3600
G1 X6.100 Y8.400 E0.20299 F3600
G1 X6.300 Y8.200 E0.21256 F3600
G1 X6.400 Y8.300 E0.21735 F3600
G1 X6.600 Y8.300 E0.22412 F3600
G1 X6.800 Y8.100 E0.23369 F3600
G1 X6.500 Y7.800 E0.24806 F3600
G1 X6.400 Y7.900 E0.25284 F3600
G1 X6.100 Y7.600 E0.26720 F3600
G1 X6.200 Y7.500 E0.27199 F3600
G1 X5.600 Y6.900 E0.30071 F3600
G1 X5.900 Y6.600 E0.31507 F3600
G1 X7.100 Y7.800 E0.37252 F3600
G1 X7.400 Y7.500 E0.38688 F3600
G1 X6.300 Y6.400 E0.43953 F3600
G1 X6.000 Y6.300 E0.45024 F3600
G1 X5.800 Y6.100 E0.45981 F3600
G1 X6.100 Y5.800 E0.47417 F3600
G1 X6.500 Y6.100 E0.49110 F3600
G1 X6.600 Y6.000 E0.49588 F3600
G1 X6.800 Y6.300 E0.50809 F3600
G1 X7.000 Y6.100 E0.51766 F3600
G1 X7.200 Y6.300 E0.52724 F3600
G1 X7.000 Y6.500 E0.53681 F3600
G1 X7.600 Y7.200 E0.56802 F3600
G1 X7.700 Y7.100 E0.57280 F3600
G1 X7.600 Y6.900 E0.58037 F3600
G1 X7.600 Y6.500 E0.59391 F3600
;--- Shutdown ---
G1 E-0.10609 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---