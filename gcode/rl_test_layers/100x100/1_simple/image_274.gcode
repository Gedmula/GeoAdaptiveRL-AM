;FLAVOR:Marlin
;Generated from path with 81 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-1.500 W32.000 H8.900 ; print area for bed levelling
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
G0 X3.300 Y3.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.400 Y3.400 E0.00479 F3600
G1 X3.300 Y3.600 E0.01236 F3600
G1 X3.400 Y3.700 E0.01714 F3600
G1 X3.200 Y3.900 E0.02672 F3600
G1 X3.300 Y4.000 E0.03150 F3600
G1 X3.000 Y4.400 E0.04843 F3600
G1 X3.100 Y4.500 E0.05321 F3600
G1 X2.900 Y4.700 E0.06279 F3600
G1 X3.000 Y4.800 E0.06758 F3600
G1 X2.700 Y5.100 E0.08194 F3600
G1 X2.800 Y5.200 E0.08672 F3600
G1 X1.900 Y6.100 E0.12981 F3600
G1 X1.800 Y6.300 E0.13737 F3600
G1 X1.900 Y6.400 E0.14216 F3600
G1 X1.600 Y6.700 E0.15652 F3600
G1 X1.700 Y6.800 E0.16131 F3600
G1 X1.600 Y6.900 E0.16610 F3600
G1 X2.100 Y7.400 E0.19003 F3600
G1 X2.200 Y7.400 E0.19342 F3600
G1 X2.400 Y7.200 E0.20299 F3600
G1 X2.600 Y7.400 E0.21256 F3600
G1 X2.900 Y7.100 E0.22692 F3600
G1 X2.600 Y6.800 E0.24129 F3600
G1 X2.500 Y6.800 E0.24467 F3600
G1 X2.300 Y7.000 E0.25424 F3600
G1 X2.100 Y6.800 E0.26382 F3600
G1 X2.300 Y6.500 E0.27602 F3600
G1 X2.200 Y6.400 E0.28081 F3600
G1 X2.500 Y6.100 E0.29517 F3600
G1 X3.200 Y6.800 E0.32868 F3600
G1 X3.300 Y7.000 E0.33625 F3600
G1 X3.700 Y6.700 E0.35317 F3600
G1 X2.800 Y5.800 E0.39625 F3600
G1 X3.100 Y5.500 E0.41062 F3600
G1 X4.000 Y6.400 E0.45370 F3600
G1 X4.100 Y6.600 E0.46127 F3600
G1 X4.500 Y6.200 E0.48041 F3600
G1 X3.500 Y5.200 E0.52828 F3600
G1 X3.300 Y5.100 E0.53585 F3600
G1 X3.400 Y5.000 E0.54064 F3600
G1 X3.300 Y4.800 E0.54821 F3600
G1 X3.500 Y4.600 E0.55778 F3600
G1 X4.600 Y5.700 E0.61044 F3600
G1 X4.600 Y5.800 E0.61382 F3600
G1 X4.800 Y6.000 E0.62340 F3600
G1 X5.100 Y5.700 E0.63776 F3600
G1 X3.600 Y4.100 E0.71199 F3600
G1 X3.900 Y3.800 E0.72636 F3600
G1 X5.000 Y4.900 E0.77901 F3600
G1 X5.000 Y5.100 E0.78578 F3600
G1 X5.300 Y5.400 E0.80014 F3600
G1 X5.400 Y5.300 E0.80493 F3600
G1 X5.400 Y5.100 E0.81170 F3600
G1 X5.500 Y5.000 E0.81649 F3600
G1 X5.400 Y4.900 E0.82127 F3600
G1 X5.600 Y4.700 E0.83085 F3600
G1 X5.100 Y4.300 E0.85252 F3600
G1 X5.000 Y4.300 E0.85591 F3600
G1 X4.000 Y3.300 E0.90378 F3600
G1 X3.900 Y3.400 E0.90856 F3600
G1 X3.600 Y3.100 E0.92292 F3600
G1 X4.000 Y2.700 E0.94207 F3600
G1 X4.100 Y2.700 E0.94546 F3600
G1 X4.300 Y2.500 E0.95503 F3600
G1 X4.400 Y2.600 E0.95982 F3600
G1 X4.500 Y2.500 E0.96460 F3600
G1 X4.600 Y2.700 E0.97217 F3600
G1 X4.300 Y3.000 E0.98653 F3600
G1 X5.200 Y3.900 E1.02962 F3600
G1 X5.200 Y4.000 E1.03300 F3600
G1 X5.500 Y4.300 E1.04736 F3600
G1 X5.600 Y4.100 E1.05493 F3600
G1 X5.400 Y3.900 E1.06450 F3600
G1 X5.500 Y3.800 E1.06929 F3600
G1 X5.300 Y3.600 E1.07886 F3600
G1 X5.400 Y3.500 E1.08365 F3600
G1 X5.100 Y3.200 E1.09801 F3600
G1 X5.200 Y3.100 E1.10280 F3600
G1 X5.000 Y3.000 E1.11037 F3600
;--- Shutdown ---
G1 E0.41037 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---