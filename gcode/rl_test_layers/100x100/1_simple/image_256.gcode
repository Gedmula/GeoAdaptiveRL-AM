;FLAVOR:Marlin
;Generated from path with 55 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.800 Y-0.100 W32.000 H6.800 ; print area for bed levelling
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
G0 X4.400 Y4.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.500 Y4.500 E0.00479 F3600
G1 X3.800 Y5.200 E0.03830 F3600
G1 X4.000 Y5.400 E0.04787 F3600
G1 X3.900 Y5.500 E0.05266 F3600
G1 X4.000 Y5.600 E0.05744 F3600
G1 X3.900 Y5.700 E0.06223 F3600
G1 X4.700 Y6.500 E0.10053 F3600
G1 X4.800 Y6.400 E0.10531 F3600
G1 X5.000 Y6.600 E0.11489 F3600
G1 X5.100 Y6.500 E0.11967 F3600
G1 X5.400 Y6.700 E0.13188 F3600
G1 X5.500 Y6.600 E0.13666 F3600
G1 X5.600 Y6.700 E0.14145 F3600
G1 X5.700 Y6.600 E0.14624 F3600
G1 X5.800 Y6.700 E0.15103 F3600
G1 X6.000 Y6.500 E0.16060 F3600
G1 X6.100 Y6.600 E0.16539 F3600
G1 X6.400 Y6.300 E0.17975 F3600
G1 X6.300 Y6.200 E0.18453 F3600
G1 X6.500 Y6.000 E0.19411 F3600
G1 X6.500 Y5.900 E0.19749 F3600
G1 X6.300 Y5.700 E0.20707 F3600
G1 X5.800 Y6.200 E0.23100 F3600
G1 X5.600 Y6.200 E0.23777 F3600
G1 X5.500 Y6.100 E0.24256 F3600
G1 X5.300 Y6.200 E0.25013 F3600
G1 X5.000 Y6.000 E0.26233 F3600
G1 X4.800 Y6.000 E0.26910 F3600
G1 X4.400 Y5.600 E0.28825 F3600
G1 X4.300 Y5.400 E0.29582 F3600
G1 X4.600 Y5.000 E0.31274 F3600
G1 X5.200 Y5.700 E0.34395 F3600
G1 X5.300 Y5.600 E0.34874 F3600
G1 X5.500 Y5.800 E0.35831 F3600
G1 X5.600 Y5.800 E0.36170 F3600
G1 X5.800 Y5.600 E0.37127 F3600
G1 X4.900 Y4.700 E0.41435 F3600
G1 X5.000 Y4.500 E0.42192 F3600
G1 X4.800 Y4.300 E0.43149 F3600
G1 X5.200 Y3.900 E0.45064 F3600
G1 X5.600 Y4.100 E0.46578 F3600
G1 X5.400 Y4.300 E0.47535 F3600
G1 X5.400 Y4.500 E0.48212 F3600
G1 X5.900 Y5.000 E0.50606 F3600
G1 X6.000 Y5.300 E0.51676 F3600
G1 X6.300 Y5.500 E0.52897 F3600
G1 X6.500 Y5.300 E0.53854 F3600
G1 X6.400 Y5.200 E0.54333 F3600
G1 X6.500 Y5.000 E0.55090 F3600
G1 X6.400 Y5.000 E0.55428 F3600
G1 X6.200 Y4.800 E0.56385 F3600
G1 X6.300 Y4.700 E0.56864 F3600
G1 X5.900 Y4.300 E0.58779 F3600
;--- Shutdown ---
G1 E-0.11221 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---