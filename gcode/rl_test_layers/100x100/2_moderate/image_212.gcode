;FLAVOR:Marlin
;Generated from path with 73 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.200 Y-0.600 W32.000 H7.700 ; print area for bed levelling
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
G0 X4.200 Y3.900 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.500 Y4.000 E0.01070 F3600
G1 X4.500 Y4.100 E0.01409 F3600
G1 X4.700 Y4.200 E0.02166 F3600
G1 X4.800 Y4.100 E0.02644 F3600
G1 X4.900 Y4.200 E0.03123 F3600
G1 X5.000 Y4.100 E0.03602 F3600
G1 X5.100 Y4.200 E0.04081 F3600
G1 X5.200 Y4.100 E0.04559 F3600
G1 X4.800 Y3.700 E0.06474 F3600
G1 X4.900 Y3.600 E0.06953 F3600
G1 X4.600 Y3.400 E0.08173 F3600
G1 X4.400 Y3.500 E0.08930 F3600
G1 X4.600 Y3.700 E0.09887 F3600
G1 E-0.60113 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X6.100 Y5.200 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.09887 F2100 ; unretract
G1 X6.300 Y5.400 E0.10845 F3600
G1 X6.000 Y5.700 E0.12281 F3600
G1 X6.100 Y5.800 E0.12760 F3600
G1 X6.000 Y5.900 E0.13238 F3600
G1 X6.100 Y6.000 E0.13717 F3600
G1 X6.000 Y6.100 E0.14196 F3600
G1 X6.200 Y6.300 E0.15153 F3600
G1 X6.100 Y6.500 E0.15910 F3600
G1 X6.200 Y6.600 E0.16389 F3600
G1 X6.300 Y6.500 E0.16867 F3600
G1 X6.500 Y6.700 E0.17825 F3600
G1 X6.600 Y6.700 E0.18163 F3600
G1 X7.000 Y7.100 E0.20078 F3600
G1 X7.200 Y7.100 E0.20755 F3600
G1 X7.300 Y7.000 E0.21234 F3600
G1 X7.400 Y7.100 E0.21712 F3600
G1 X7.600 Y6.900 E0.22670 F3600
G1 X7.300 Y6.600 E0.24106 F3600
G1 X7.200 Y6.700 E0.24585 F3600
G1 X6.500 Y6.000 E0.27935 F3600
G1 X6.600 Y5.900 E0.28414 F3600
G1 X6.500 Y5.800 E0.28893 F3600
G1 X6.700 Y5.600 E0.29850 F3600
G1 X7.900 Y6.700 E0.35360 F3600
G1 X8.100 Y6.500 E0.36318 F3600
G1 X8.200 Y6.600 E0.36796 F3600
G1 X8.500 Y6.300 E0.38233 F3600
G1 X8.200 Y6.000 E0.39669 F3600
G1 X8.000 Y6.200 E0.40626 F3600
G1 X7.000 Y5.200 E0.45413 F3600
G1 X6.900 Y5.300 E0.45892 F3600
G1 X6.400 Y4.900 E0.48059 F3600
G1 X6.700 Y4.600 E0.49495 F3600
G1 X6.900 Y4.800 E0.50452 F3600
G1 X7.100 Y4.800 E0.51129 F3600
G1 X7.300 Y5.000 E0.52087 F3600
G1 X7.400 Y5.000 E0.52425 F3600
G1 X8.000 Y5.600 E0.55297 F3600
G1 X8.200 Y5.600 E0.55974 F3600
G1 X8.500 Y5.900 E0.57411 F3600
G1 X8.700 Y5.700 E0.58368 F3600
G1 X8.600 Y5.600 E0.58847 F3600
G1 X8.700 Y5.500 E0.59325 F3600
G1 X8.600 Y5.400 E0.59804 F3600
G1 X8.800 Y5.200 E0.60761 F3600
G1 X8.600 Y5.000 E0.61719 F3600
G1 X8.300 Y5.300 E0.63155 F3600
G1 X7.700 Y4.700 E0.66027 F3600
G1 X7.300 Y4.600 E0.67423 F3600
G1 X7.000 Y4.300 E0.68859 F3600
G1 X7.200 Y4.100 E0.69816 F3600
G1 X7.300 Y4.200 E0.70295 F3600
G1 X7.400 Y4.100 E0.70774 F3600
G1 X7.500 Y4.200 E0.71252 F3600
G1 X7.700 Y4.000 E0.72210 F3600
G1 X8.300 Y4.700 E0.75330 F3600
G1 X8.400 Y4.600 E0.75809 F3600
;--- Shutdown ---
G1 E0.05809 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---