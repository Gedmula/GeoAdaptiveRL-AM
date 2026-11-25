;FLAVOR:Marlin
;Generated from path with 72 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.700 Y0.400 W32.000 H8.000 ; print area for bed levelling
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
G0 X5.300 Y5.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.400 Y5.400 E0.00479 F3600
G1 X5.000 Y5.900 E0.02646 F3600
G1 X5.100 Y6.000 E0.03125 F3600
G1 X4.900 Y6.200 E0.04082 F3600
G1 X4.900 Y6.500 E0.05098 F3600
G1 X5.000 Y6.600 E0.05576 F3600
G1 X4.700 Y6.900 E0.07012 F3600
G1 X4.800 Y7.000 E0.07491 F3600
G1 X4.700 Y7.100 E0.07970 F3600
G1 X4.800 Y7.200 E0.08448 F3600
G1 X4.700 Y7.300 E0.08927 F3600
G1 X4.900 Y7.500 E0.09885 F3600
G1 X4.800 Y7.600 E0.10363 F3600
G1 X5.000 Y7.800 E0.11321 F3600
G1 X5.000 Y7.900 E0.11659 F3600
G1 X5.400 Y8.300 E0.13574 F3600
G1 X5.600 Y8.400 E0.14331 F3600
G1 X5.700 Y8.300 E0.14809 F3600
G1 X5.800 Y8.400 E0.15288 F3600
G1 X6.000 Y8.200 E0.16246 F3600
G1 X6.100 Y8.300 E0.16724 F3600
G1 X6.200 Y8.100 E0.17481 F3600
G1 X6.000 Y7.900 E0.18439 F3600
G1 X5.800 Y7.900 E0.19116 F3600
G1 X5.700 Y8.000 E0.19594 F3600
G1 X5.400 Y7.700 E0.21030 F3600
G1 X5.500 Y7.600 E0.21509 F3600
G1 X5.100 Y7.200 E0.23424 F3600
G1 X5.300 Y7.000 E0.24381 F3600
G1 X5.200 Y6.900 E0.24860 F3600
G1 X5.400 Y6.800 E0.25617 F3600
G1 X6.300 Y7.800 E0.30171 F3600
G1 X6.500 Y7.600 E0.31128 F3600
G1 X6.400 Y7.500 E0.31607 F3600
G1 X6.600 Y7.200 E0.32827 F3600
G1 X6.500 Y7.100 E0.33306 F3600
G1 X6.400 Y7.200 E0.33785 F3600
G1 X5.600 Y6.400 E0.37614 F3600
G1 X5.400 Y6.300 E0.38371 F3600
G1 X5.500 Y6.200 E0.38850 F3600
G1 X5.400 Y6.100 E0.39328 F3600
G1 X5.600 Y5.900 E0.40286 F3600
G1 X5.500 Y5.800 E0.40764 F3600
G1 X5.700 Y5.600 E0.41722 F3600
G1 X6.000 Y5.900 E0.43158 F3600
G1 X5.900 Y6.100 E0.43915 F3600
G1 X6.600 Y6.800 E0.47266 F3600
G1 X6.800 Y6.600 E0.48223 F3600
G1 X6.700 Y6.500 E0.48702 F3600
G1 X6.800 Y6.400 E0.49180 F3600
G1 X6.500 Y6.100 E0.50617 F3600
G1 X6.600 Y6.000 E0.51095 F3600
G1 X6.700 Y6.100 E0.51574 F3600
G1 X6.900 Y5.900 E0.52531 F3600
G1 X6.600 Y5.600 E0.53967 F3600
G1 X6.400 Y5.800 E0.54925 F3600
G1 X5.600 Y5.000 E0.58754 F3600
G1 X6.200 Y4.400 E0.61626 F3600
G1 X6.400 Y4.600 E0.62584 F3600
G1 X6.100 Y4.900 E0.64020 F3600
G1 X6.400 Y5.200 E0.65456 F3600
G1 X6.500 Y5.100 E0.65935 F3600
G1 X6.800 Y5.400 E0.67371 F3600
G1 X6.900 Y5.400 E0.67709 F3600
G1 X7.000 Y5.300 E0.68188 F3600
G1 X6.800 Y5.100 E0.69145 F3600
G1 X6.900 Y4.900 E0.69902 F3600
G1 X6.800 Y4.700 E0.70659 F3600
G1 X6.900 Y4.500 E0.71416 F3600
G1 X7.000 Y4.600 E0.71895 F3600
;--- Shutdown ---
G1 E0.01895 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---