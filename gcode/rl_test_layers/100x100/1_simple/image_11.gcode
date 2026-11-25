;FLAVOR:Marlin
;Generated from path with 88 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.400 Y-2.600 W32.000 H8.900 ; print area for bed levelling
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
G0 X2.500 Y2.500 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.600 Y2.600 E0.00479 F3600
G1 X1.800 Y3.600 E0.04813 F3600
G1 X1.800 Y3.700 E0.05152 F3600
G1 X1.400 Y4.100 E0.07067 F3600
G1 X1.500 Y4.200 E0.07545 F3600
G1 X1.400 Y4.300 E0.08024 F3600
G1 X1.600 Y4.500 E0.08982 F3600
G1 X1.700 Y4.400 E0.09460 F3600
G1 X2.200 Y4.900 E0.11854 F3600
G1 X2.300 Y4.800 E0.12332 F3600
G1 X2.900 Y5.400 E0.15205 F3600
G1 X3.000 Y5.300 E0.15683 F3600
G1 X3.900 Y6.200 E0.19991 F3600
G1 X4.100 Y6.300 E0.20748 F3600
G1 X4.300 Y6.100 E0.21706 F3600
G1 X4.400 Y6.200 E0.22184 F3600
G1 X4.500 Y6.000 E0.22941 F3600
G1 X4.300 Y5.800 E0.23899 F3600
G1 X4.200 Y5.900 E0.24377 F3600
G1 X3.100 Y4.800 E0.29643 F3600
G1 X3.000 Y4.900 E0.30122 F3600
G1 X2.500 Y4.400 E0.32515 F3600
G1 X2.200 Y4.300 E0.33586 F3600
G1 X2.000 Y4.100 E0.34543 F3600
G1 X2.300 Y3.800 E0.35979 F3600
G1 X2.600 Y4.100 E0.37415 F3600
G1 X2.700 Y4.100 E0.37754 F3600
G1 X3.200 Y4.500 E0.39921 F3600
G1 X3.400 Y4.500 E0.40598 F3600
G1 X4.700 Y5.800 E0.46821 F3600
G1 X4.900 Y5.600 E0.47778 F3600
G1 X4.800 Y5.500 E0.48257 F3600
G1 X5.000 Y5.300 E0.49215 F3600
G1 X4.800 Y5.200 E0.49971 F3600
G1 X3.700 Y4.100 E0.55237 F3600
G1 X3.500 Y4.100 E0.55914 F3600
G1 X3.000 Y3.700 E0.58081 F3600
G1 X2.900 Y3.800 E0.58560 F3600
G1 X2.500 Y3.400 E0.60475 F3600
G1 X2.800 Y3.100 E0.61911 F3600
G1 X2.900 Y3.200 E0.62390 F3600
G1 X3.000 Y3.100 E0.62868 F3600
G1 X3.700 Y3.700 E0.65989 F3600
G1 X3.800 Y3.600 E0.66468 F3600
G1 X5.200 Y5.000 E0.73169 F3600
G1 X5.500 Y4.700 E0.74606 F3600
G1 X3.900 Y3.100 E0.82265 F3600
G1 X3.800 Y3.200 E0.82743 F3600
G1 X3.300 Y2.700 E0.85137 F3600
G1 X3.000 Y2.700 E0.86152 F3600
G1 X2.900 Y2.600 E0.86631 F3600
G1 X3.000 Y2.500 E0.87110 F3600
G1 X2.800 Y2.300 E0.88067 F3600
G1 X3.200 Y1.900 E0.89982 F3600
G1 X3.100 Y1.800 E0.90461 F3600
G1 X3.500 Y1.400 E0.92375 F3600
G1 X3.800 Y1.700 E0.93811 F3600
G1 X3.400 Y2.100 E0.95726 F3600
G1 X3.400 Y2.300 E0.96403 F3600
G1 X3.900 Y2.700 E0.98571 F3600
G1 X4.100 Y2.700 E0.99247 F3600
G1 X5.700 Y4.300 E1.06907 F3600
G1 X6.000 Y4.000 E1.08343 F3600
G1 X5.900 Y3.900 E1.08821 F3600
G1 X6.300 Y3.500 E1.10736 F3600
G1 X6.100 Y3.300 E1.11694 F3600
G1 X6.000 Y3.300 E1.12032 F3600
G1 X5.600 Y3.600 E1.13724 F3600
G1 X5.400 Y3.400 E1.14682 F3600
G1 X5.800 Y3.000 E1.16597 F3600
G1 X5.700 Y2.900 E1.17075 F3600
G1 X5.300 Y2.900 E1.18429 F3600
G1 X5.100 Y3.100 E1.19387 F3600
G1 X5.000 Y3.100 E1.19725 F3600
G1 X4.800 Y2.900 E1.20683 F3600
G1 X4.800 Y2.800 E1.21021 F3600
G1 X5.000 Y2.600 E1.21978 F3600
G1 X4.800 Y2.400 E1.22936 F3600
G1 X4.700 Y2.500 E1.23415 F3600
G1 X4.400 Y2.500 E1.24430 F3600
G1 X4.200 Y2.300 E1.25387 F3600
G1 X4.000 Y2.300 E1.26064 F3600
G1 X3.900 Y2.200 E1.26543 F3600
G1 X3.900 Y2.100 E1.26882 F3600
G1 X4.200 Y1.800 E1.28318 F3600
G1 X4.300 Y1.900 E1.28796 F3600
;--- Shutdown ---
G1 E0.58796 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---