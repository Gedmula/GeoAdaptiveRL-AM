;FLAVOR:Marlin
;Generated from path with 85 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.100 Y-0.800 W32.000 H7.600 ; print area for bed levelling
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
G0 X2.600 Y3.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.700 Y3.900 E0.00479 F3600
G1 X2.600 Y4.000 E0.00957 F3600
G1 X2.700 Y4.200 E0.01714 F3600
G1 X2.500 Y4.600 E0.03228 F3600
G1 X2.600 Y4.700 E0.03707 F3600
G1 X2.100 Y5.200 E0.06100 F3600
G1 X2.200 Y5.400 E0.06857 F3600
G1 X2.400 Y5.600 E0.07814 F3600
G1 X2.600 Y5.400 E0.08772 F3600
G1 X2.600 Y5.300 E0.09110 F3600
G1 X3.000 Y4.800 E0.11278 F3600
G1 X2.900 Y4.600 E0.12035 F3600
G1 X3.200 Y4.300 E0.13471 F3600
G1 X3.000 Y4.100 E0.14428 F3600
G1 X3.200 Y3.900 E0.15385 F3600
G1 X3.600 Y4.300 E0.17300 F3600
G1 X3.300 Y4.600 E0.18736 F3600
G1 X3.500 Y4.800 E0.19694 F3600
G1 X3.800 Y4.500 E0.21130 F3600
G1 X4.200 Y4.900 E0.23045 F3600
G1 X4.300 Y5.100 E0.23801 F3600
G1 X3.900 Y5.500 E0.25716 F3600
G1 X4.300 Y5.900 E0.27631 F3600
G1 X4.200 Y6.200 E0.28701 F3600
G1 X4.300 Y6.300 E0.29180 F3600
G1 X4.400 Y6.200 E0.29659 F3600
G1 X5.000 Y6.800 E0.32531 F3600
G1 X5.200 Y6.600 E0.33488 F3600
G1 X5.300 Y6.700 E0.33967 F3600
G1 X5.400 Y6.600 E0.34446 F3600
G1 X5.600 Y6.800 E0.35403 F3600
G1 X5.800 Y6.600 E0.36361 F3600
G1 X5.900 Y6.700 E0.36839 F3600
G1 X6.200 Y6.400 E0.38275 F3600
G1 X6.300 Y6.500 E0.38754 F3600
G1 X6.400 Y6.400 E0.39233 F3600
G1 X6.500 Y6.500 E0.39711 F3600
G1 X6.600 Y6.300 E0.40468 F3600
G1 X6.200 Y5.900 E0.42383 F3600
G1 X6.100 Y5.900 E0.42722 F3600
G1 X5.700 Y6.300 E0.44636 F3600
G1 X5.500 Y6.100 E0.45594 F3600
G1 X5.100 Y6.300 E0.47107 F3600
G1 X4.400 Y5.600 E0.50458 F3600
G1 X4.600 Y5.400 E0.51416 F3600
G1 X5.100 Y5.800 E0.53583 F3600
G1 X5.200 Y5.800 E0.53922 F3600
G1 X5.400 Y5.600 E0.54879 F3600
G1 X3.900 Y4.100 E0.62059 F3600
G1 X4.000 Y4.000 E0.62538 F3600
G1 X3.800 Y3.800 E0.63495 F3600
G1 X4.000 Y3.500 E0.64716 F3600
G1 X4.200 Y3.600 E0.65473 F3600
G1 X4.400 Y3.800 E0.66430 F3600
G1 X4.400 Y3.900 E0.66769 F3600
G1 X5.700 Y5.200 E0.72992 F3600
G1 X5.700 Y5.600 E0.74346 F3600
G1 X5.800 Y5.700 E0.74824 F3600
G1 X6.100 Y5.400 E0.76260 F3600
G1 X6.600 Y5.900 E0.78654 F3600
G1 X6.900 Y5.600 E0.80090 F3600
G1 X6.500 Y5.200 E0.82005 F3600
G1 X6.800 Y4.900 E0.83441 F3600
G1 X6.600 Y4.700 E0.84398 F3600
G1 X6.500 Y4.700 E0.84737 F3600
G1 X6.200 Y5.000 E0.86173 F3600
G1 X6.100 Y5.000 E0.86511 F3600
G1 X4.400 Y3.300 E0.94649 F3600
G1 X4.500 Y3.200 E0.95128 F3600
G1 X4.600 Y3.300 E0.95606 F3600
G1 X4.700 Y3.200 E0.96085 F3600
G1 X4.800 Y3.300 E0.96564 F3600
G1 X5.000 Y3.200 E0.97321 F3600
G1 X5.300 Y3.500 E0.98757 F3600
G1 X5.600 Y3.200 E1.00193 F3600
G1 X5.800 Y3.400 E1.01150 F3600
G1 X5.500 Y3.700 E1.02586 F3600
G1 X5.900 Y4.200 E1.04754 F3600
G1 X5.900 Y4.300 E1.05092 F3600
G1 X6.200 Y4.600 E1.06528 F3600
G1 X6.400 Y4.400 E1.07486 F3600
G1 X6.200 Y4.200 E1.08443 F3600
G1 X6.000 Y3.800 E1.09957 F3600
;--- Shutdown ---
G1 E0.39957 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---