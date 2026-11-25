;FLAVOR:Marlin
;Generated from path with 76 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.200 Y-1.300 W32.000 H7.700 ; print area for bed levelling
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
G0 X2.000 Y4.200 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.200 Y5.000 E0.03830 F3600
G1 X1.400 Y5.100 E0.04586 F3600
G1 X2.000 Y5.700 E0.07459 F3600
G1 X1.900 Y5.800 E0.07937 F3600
G1 X2.000 Y5.900 E0.08416 F3600
G1 X1.900 Y6.000 E0.08895 F3600
G1 X1.900 Y6.200 E0.09572 F3600
G1 X2.000 Y6.300 E0.10050 F3600
G1 X2.100 Y6.200 E0.10529 F3600
G1 X2.200 Y6.300 E0.11008 F3600
G1 X2.300 Y6.200 E0.11486 F3600
G1 X2.500 Y6.400 E0.12444 F3600
G1 X2.800 Y6.100 E0.13880 F3600
G1 X2.900 Y6.200 E0.14359 F3600
G1 X3.000 Y6.100 E0.14837 F3600
G1 X2.900 Y6.000 E0.15316 F3600
G1 X3.000 Y5.900 E0.15795 F3600
G1 X2.800 Y5.700 E0.16752 F3600
G1 X2.600 Y5.900 E0.17709 F3600
G1 X2.300 Y5.600 E0.19146 F3600
G1 X2.400 Y5.500 E0.19624 F3600
G1 X1.800 Y4.900 E0.22496 F3600
G1 X2.300 Y4.400 E0.24890 F3600
G1 X2.500 Y4.600 E0.25847 F3600
G1 X2.400 Y4.800 E0.26604 F3600
G1 X3.100 Y5.600 E0.30202 F3600
G1 X3.400 Y5.300 E0.31638 F3600
G1 X2.800 Y4.700 E0.34511 F3600
G1 X2.900 Y4.600 E0.34989 F3600
G1 X2.800 Y4.500 E0.35468 F3600
G1 X2.900 Y4.300 E0.36225 F3600
G1 X3.000 Y4.400 E0.36704 F3600
G1 X3.100 Y4.300 E0.37182 F3600
G1 X3.700 Y4.900 E0.40054 F3600
G1 X3.600 Y5.000 E0.40533 F3600
G1 X3.800 Y5.200 E0.41490 F3600
G1 X4.000 Y5.100 E0.42247 F3600
G1 X4.100 Y5.200 E0.42726 F3600
G1 X4.300 Y5.000 E0.43683 F3600
G1 X4.400 Y5.100 E0.44162 F3600
G1 X5.000 Y4.500 E0.47034 F3600
G1 X5.100 Y4.600 E0.47513 F3600
G1 X5.000 Y5.000 E0.48909 F3600
G1 X5.300 Y5.400 E0.50601 F3600
G1 X5.600 Y5.100 E0.52037 F3600
G1 X5.700 Y5.200 E0.52516 F3600
G1 X5.900 Y5.000 E0.53473 F3600
G1 X5.800 Y4.800 E0.54230 F3600
G1 X5.500 Y4.800 E0.55246 F3600
G1 X5.400 Y4.700 E0.55724 F3600
G1 X5.500 Y4.600 E0.56203 F3600
G1 X5.400 Y4.500 E0.56682 F3600
G1 X5.500 Y4.300 E0.57439 F3600
G1 X5.300 Y4.100 E0.58396 F3600
G1 X5.500 Y3.900 E0.59353 F3600
G1 X5.300 Y3.700 E0.60311 F3600
G1 X4.200 Y4.700 E0.65343 F3600
G1 X4.000 Y4.600 E0.66100 F3600
G1 X3.400 Y4.000 E0.68972 F3600
G1 X3.700 Y3.700 E0.70408 F3600
G1 X3.800 Y3.700 E0.70746 F3600
G1 X4.200 Y4.200 E0.72914 F3600
G1 X4.500 Y3.900 E0.74350 F3600
G1 X4.100 Y3.500 E0.76265 F3600
G1 X4.200 Y3.300 E0.77021 F3600
G1 X4.000 Y3.100 E0.77979 F3600
G1 X4.000 Y3.000 E0.78317 F3600
G1 X4.300 Y2.700 E0.79753 F3600
G1 X4.500 Y2.900 E0.80711 F3600
G1 X4.700 Y2.700 E0.81668 F3600
G1 X4.900 Y2.900 E0.82626 F3600
G1 X4.500 Y3.300 E0.84540 F3600
G1 X4.800 Y3.600 E0.85976 F3600
G1 X4.900 Y3.500 E0.86455 F3600
;--- Shutdown ---
G1 E0.16455 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---