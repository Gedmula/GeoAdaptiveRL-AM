;FLAVOR:Marlin
;Generated from path with 86 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.500 Y-0.200 W32.000 H8.700 ; print area for bed levelling
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
G0 X4.500 Y4.000 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.800 Y4.300 E0.01436 F3600
G1 X4.700 Y4.400 E0.01915 F3600
G1 X4.800 Y4.500 E0.02393 F3600
G1 X4.800 Y4.900 E0.03747 F3600
G1 X4.900 Y5.000 E0.04226 F3600
G1 X4.500 Y5.400 E0.06141 F3600
G1 X4.600 Y5.500 E0.06620 F3600
G1 X4.900 Y5.500 E0.07635 F3600
G1 X5.100 Y5.400 E0.08392 F3600
G1 X5.500 Y5.800 E0.10307 F3600
G1 X5.300 Y6.000 E0.11264 F3600
G1 X4.900 Y6.700 E0.13993 F3600
G1 X4.500 Y7.100 E0.15908 F3600
G1 X5.000 Y7.600 E0.18301 F3600
G1 X5.100 Y7.600 E0.18640 F3600
G1 X5.300 Y7.800 E0.19597 F3600
G1 X5.400 Y7.700 E0.20076 F3600
G1 X6.200 Y8.500 E0.23905 F3600
G1 X6.500 Y8.200 E0.25342 F3600
G1 X5.500 Y7.200 E0.30128 F3600
G1 X5.300 Y7.300 E0.30885 F3600
G1 X5.100 Y7.100 E0.31843 F3600
G1 X5.400 Y6.800 E0.33279 F3600
G1 X5.300 Y6.700 E0.33758 F3600
G1 X5.600 Y6.400 E0.35194 F3600
G1 X5.800 Y6.600 E0.36151 F3600
G1 X5.800 Y6.800 E0.36828 F3600
G1 X6.500 Y7.500 E0.40179 F3600
G1 X6.500 Y7.700 E0.40856 F3600
G1 X6.700 Y7.900 E0.41813 F3600
G1 X7.000 Y7.600 E0.43249 F3600
G1 X6.900 Y7.500 E0.43728 F3600
G1 X7.100 Y7.300 E0.44685 F3600
G1 X6.900 Y7.200 E0.45442 F3600
G1 X5.800 Y6.100 E0.50708 F3600
G1 X6.100 Y5.800 E0.52144 F3600
G1 X7.300 Y7.000 E0.57888 F3600
G1 X7.600 Y6.700 E0.59324 F3600
G1 X6.200 Y5.300 E0.66026 F3600
G1 X5.900 Y5.600 E0.67462 F3600
G1 X5.200 Y4.900 E0.70813 F3600
G1 X5.300 Y4.800 E0.71292 F3600
G1 X5.200 Y4.600 E0.72049 F3600
G1 X5.300 Y4.500 E0.72527 F3600
G1 X5.300 Y4.300 E0.73204 F3600
G1 X5.100 Y4.100 E0.74162 F3600
G1 X5.400 Y3.800 E0.75598 F3600
G1 X5.500 Y3.900 E0.76076 F3600
G1 X5.600 Y3.800 E0.76555 F3600
G1 X5.800 Y4.000 E0.77513 F3600
G1 X5.700 Y4.100 E0.77991 F3600
G1 X5.800 Y4.200 E0.78470 F3600
G1 X5.700 Y4.300 E0.78949 F3600
G1 X5.800 Y4.400 E0.79427 F3600
G1 X5.700 Y4.500 E0.79906 F3600
G1 X5.800 Y4.600 E0.80385 F3600
G1 X5.700 Y4.700 E0.80863 F3600
G1 X5.800 Y4.900 E0.81620 F3600
G1 X5.900 Y5.000 E0.82099 F3600
G1 X6.100 Y4.800 E0.83056 F3600
G1 X6.400 Y4.900 E0.84127 F3600
G1 X7.800 Y6.300 E0.90829 F3600
G1 X8.000 Y6.100 E0.91786 F3600
G1 X8.100 Y5.800 E0.92856 F3600
G1 X8.400 Y5.500 E0.94292 F3600
G1 X8.300 Y5.300 E0.95049 F3600
G1 X8.200 Y5.200 E0.95528 F3600
G1 X7.800 Y5.600 E0.97443 F3600
G1 X7.700 Y5.600 E0.97781 F3600
G1 X7.500 Y5.400 E0.98739 F3600
G1 X7.900 Y5.000 E1.00653 F3600
G1 X7.700 Y4.800 E1.01611 F3600
G1 X7.600 Y4.800 E1.01949 F3600
G1 X7.300 Y5.100 E1.03385 F3600
G1 X7.200 Y5.100 E1.03724 F3600
G1 X6.800 Y4.700 E1.05639 F3600
G1 X6.400 Y4.600 E1.07034 F3600
G1 X6.100 Y4.300 E1.08470 F3600
G1 X6.300 Y4.000 E1.09691 F3600
G1 X6.500 Y4.200 E1.10648 F3600
G1 X6.600 Y4.100 E1.11127 F3600
G1 X6.800 Y4.300 E1.12084 F3600
G1 X6.900 Y4.200 E1.12563 F3600
G1 X7.100 Y4.400 E1.13520 F3600
;--- Shutdown ---
G1 E0.43520 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---