;FLAVOR:Marlin
;Generated from path with 92 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.500 Y-0.500 W32.000 H8.100 ; print area for bed levelling
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
G0 X4.100 Y4.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.200 Y4.200 E0.00479 F3600
G1 X3.900 Y4.500 E0.01915 F3600
G1 X3.800 Y4.700 E0.02672 F3600
G1 X3.900 Y4.800 E0.03150 F3600
G1 X3.700 Y5.000 E0.04108 F3600
G1 X3.800 Y5.100 E0.04586 F3600
G1 X3.700 Y5.200 E0.05065 F3600
G1 X3.800 Y5.300 E0.05544 F3600
G1 X3.500 Y5.600 E0.06980 F3600
G1 X3.700 Y5.800 E0.07937 F3600
G1 X3.600 Y5.900 E0.08416 F3600
G1 X3.700 Y6.000 E0.08895 F3600
G1 X3.600 Y6.100 E0.09373 F3600
G1 X3.800 Y6.300 E0.10331 F3600
G1 X3.700 Y6.400 E0.10809 F3600
G1 X4.600 Y7.300 E0.15118 F3600
G1 X4.700 Y7.200 E0.15596 F3600
G1 X4.800 Y7.400 E0.16353 F3600
G1 X5.000 Y7.500 E0.17110 F3600
G1 X5.100 Y7.400 E0.17589 F3600
G1 X5.400 Y7.600 E0.18809 F3600
G1 X5.500 Y7.500 E0.19288 F3600
G1 X5.600 Y7.600 E0.19767 F3600
G1 X5.700 Y7.500 E0.20245 F3600
G1 X5.800 Y7.600 E0.20724 F3600
G1 X6.000 Y7.400 E0.21681 F3600
G1 X5.600 Y7.000 E0.23596 F3600
G1 X5.400 Y7.100 E0.24353 F3600
G1 X4.800 Y6.800 E0.26624 F3600
G1 X4.200 Y6.200 E0.29496 F3600
G1 X4.100 Y6.000 E0.30253 F3600
G1 X4.200 Y5.900 E0.30732 F3600
G1 X4.000 Y5.700 E0.31689 F3600
G1 X4.200 Y5.500 E0.32646 F3600
G1 X5.200 Y6.500 E0.37433 F3600
G1 X5.300 Y6.400 E0.37912 F3600
G1 X6.000 Y7.000 E0.41033 F3600
G1 X6.300 Y6.700 E0.42469 F3600
G1 X5.600 Y6.000 E0.45820 F3600
G1 X5.500 Y6.100 E0.46298 F3600
G1 X4.600 Y5.200 E0.50607 F3600
G1 X4.400 Y5.200 E0.51284 F3600
G1 X4.200 Y5.000 E0.52241 F3600
G1 X4.400 Y4.800 E0.53198 F3600
G1 X4.300 Y4.700 E0.53677 F3600
G1 X4.500 Y4.500 E0.54634 F3600
G1 X5.500 Y5.500 E0.59421 F3600
G1 X5.800 Y5.600 E0.60492 F3600
G1 X6.700 Y6.500 E0.64800 F3600
G1 X6.900 Y6.400 E0.65557 F3600
G1 X7.100 Y6.600 E0.66514 F3600
G1 X7.400 Y6.300 E0.67950 F3600
G1 X7.100 Y6.000 E0.69386 F3600
G1 X6.800 Y6.000 E0.70402 F3600
G1 X4.900 Y4.200 E0.79261 F3600
G1 X4.700 Y4.200 E0.79938 F3600
G1 X4.500 Y4.000 E0.80895 F3600
G1 X4.800 Y3.700 E0.82331 F3600
G1 X4.900 Y3.800 E0.82810 F3600
G1 X5.100 Y3.600 E0.83767 F3600
G1 X5.300 Y3.800 E0.84725 F3600
G1 X5.200 Y3.900 E0.85204 F3600
G1 X7.500 Y6.100 E0.95977 F3600
G1 X7.600 Y6.000 E0.96456 F3600
G1 X7.500 Y5.800 E0.97212 F3600
G1 X7.600 Y5.700 E0.97691 F3600
G1 X7.500 Y5.600 E0.98170 F3600
G1 X7.600 Y5.500 E0.98649 F3600
G1 X7.300 Y5.300 E0.99869 F3600
G1 X7.500 Y5.100 E1.00826 F3600
G1 X7.300 Y4.900 E1.01784 F3600
G1 X7.100 Y5.100 E1.02741 F3600
G1 X6.900 Y4.900 E1.03698 F3600
G1 X6.900 Y4.800 E1.04037 F3600
G1 X7.200 Y4.500 E1.05473 F3600
G1 X7.000 Y4.300 E1.06430 F3600
G1 X6.900 Y4.300 E1.06769 F3600
G1 X6.600 Y4.600 E1.08205 F3600
G1 X6.500 Y4.600 E1.08544 F3600
G1 X6.300 Y4.400 E1.09501 F3600
G1 X6.300 Y4.300 E1.09839 F3600
G1 X6.000 Y4.200 E1.10910 F3600
G1 X5.600 Y3.800 E1.12825 F3600
G1 X5.600 Y3.600 E1.13502 F3600
G1 X5.700 Y3.500 E1.13980 F3600
G1 X5.900 Y3.700 E1.14938 F3600
G1 X6.000 Y3.600 E1.15416 F3600
G1 X6.200 Y3.800 E1.16374 F3600
G1 X6.300 Y3.700 E1.16852 F3600
G1 X6.600 Y4.000 E1.18288 F3600
;--- Shutdown ---
G1 E0.48288 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---