;FLAVOR:Marlin
;Generated from path with 84 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.000 Y-1.400 W32.000 H8.500 ; print area for bed levelling
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
G0 X3.000 Y3.000 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.100 Y3.100 E0.00479 F3600
G1 X3.000 Y3.200 E0.00957 F3600
G1 X3.100 Y3.300 E0.01436 F3600
G1 X3.000 Y3.400 E0.01915 F3600
G1 X3.300 Y3.700 E0.03351 F3600
G1 X3.700 Y3.900 E0.04865 F3600
G1 X3.900 Y3.700 E0.05822 F3600
G1 X4.100 Y3.900 E0.06779 F3600
G1 X4.200 Y3.800 E0.07258 F3600
G1 X4.300 Y3.900 E0.07737 F3600
G1 X4.400 Y3.800 E0.08215 F3600
G1 X5.200 Y4.600 E0.12045 F3600
G1 X4.700 Y5.100 E0.14439 F3600
G1 X4.900 Y5.300 E0.15396 F3600
G1 X5.100 Y5.200 E0.16153 F3600
G1 X5.500 Y5.600 E0.18068 F3600
G1 X5.400 Y5.700 E0.18546 F3600
G1 X6.000 Y6.300 E0.21418 F3600
G1 X5.900 Y6.400 E0.21897 F3600
G1 X6.000 Y6.500 E0.22376 F3600
G1 X5.900 Y6.600 E0.22855 F3600
G1 X6.400 Y7.100 E0.25248 F3600
G1 X6.600 Y6.900 E0.26205 F3600
G1 X6.600 Y6.800 E0.26544 F3600
G1 X6.400 Y6.600 E0.27501 F3600
G1 X6.600 Y6.400 E0.28459 F3600
G1 X6.900 Y6.700 E0.29895 F3600
G1 X7.200 Y6.400 E0.31331 F3600
G1 X6.700 Y5.900 E0.33724 F3600
G1 X6.500 Y6.100 E0.34682 F3600
G1 X5.400 Y5.000 E0.39947 F3600
G1 X5.600 Y4.800 E0.40905 F3600
G1 X5.800 Y4.800 E0.41582 F3600
G1 X6.500 Y5.500 E0.44933 F3600
G1 X6.700 Y5.400 E0.45689 F3600
G1 X7.400 Y6.100 E0.49040 F3600
G1 X7.700 Y5.800 E0.50476 F3600
G1 X6.800 Y4.900 E0.54785 F3600
G1 X6.700 Y5.000 E0.55263 F3600
G1 X6.100 Y4.400 E0.58135 F3600
G1 X5.900 Y4.300 E0.58892 F3600
G1 X5.700 Y4.500 E0.59850 F3600
G1 X5.100 Y3.900 E0.62722 F3600
G1 X5.000 Y4.000 E0.63201 F3600
G1 X4.500 Y3.500 E0.65594 F3600
G1 X4.300 Y3.500 E0.66271 F3600
G1 X4.100 Y3.300 E0.67228 F3600
G1 X4.300 Y3.100 E0.68186 F3600
G1 X4.200 Y3.000 E0.68665 F3600
G1 X4.100 Y3.000 E0.69003 F3600
G1 X3.700 Y3.400 E0.70918 F3600
G1 X3.600 Y3.400 E0.71256 F3600
G1 X3.400 Y3.000 E0.72770 F3600
G1 X3.200 Y2.800 E0.73727 F3600
G1 X3.400 Y2.600 E0.74685 F3600
G1 X3.600 Y2.800 E0.75642 F3600
G1 X3.800 Y2.600 E0.76600 F3600
G1 X4.200 Y2.800 E0.78113 F3600
G1 E0.08113 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X5.600 Y3.900 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.78113 F2100 ; unretract
G1 X5.900 Y3.600 E0.79549 F3600
G1 X6.200 Y4.000 E0.81242 F3600
G1 X6.400 Y4.000 E0.81919 F3600
G1 X6.500 Y3.900 E0.82398 F3600
G1 X6.700 Y4.100 E0.83355 F3600
G1 X6.600 Y4.200 E0.83834 F3600
G1 X6.700 Y4.400 E0.84591 F3600
G1 X6.900 Y4.600 E0.85548 F3600
G1 X7.000 Y4.500 E0.86027 F3600
G1 X7.600 Y5.100 E0.88899 F3600
G1 X7.600 Y5.200 E0.89237 F3600
G1 X7.800 Y5.400 E0.90195 F3600
G1 X7.900 Y5.400 E0.90533 F3600
G1 X8.100 Y5.200 E0.91491 F3600
G1 X8.000 Y5.100 E0.91969 F3600
G1 X8.100 Y5.000 E0.92448 F3600
G1 X7.900 Y4.800 E0.93405 F3600
G1 X8.200 Y4.500 E0.94841 F3600
G1 X7.900 Y4.200 E0.96277 F3600
G1 X7.600 Y4.500 E0.97714 F3600
G1 X7.500 Y4.500 E0.98052 F3600
G1 X7.000 Y4.000 E1.00446 F3600
G1 X7.100 Y3.900 E1.00924 F3600
;--- Shutdown ---
G1 E0.30924 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---