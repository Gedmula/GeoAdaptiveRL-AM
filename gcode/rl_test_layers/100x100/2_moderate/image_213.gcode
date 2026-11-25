;FLAVOR:Marlin
;Generated from path with 70 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.700 Y0.500 W32.000 H7.000 ; print area for bed levelling
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
G0 X2.100 Y4.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.700 Y5.300 E0.02167 F3600
G1 X1.800 Y5.400 E0.02646 F3600
G1 X1.700 Y5.600 E0.03403 F3600
G1 X1.800 Y5.700 E0.03882 F3600
G1 X1.700 Y5.800 E0.04360 F3600
G1 X1.800 Y5.900 E0.04839 F3600
G1 X1.700 Y6.000 E0.05318 F3600
G1 X1.800 Y6.100 E0.05796 F3600
G1 X1.700 Y6.200 E0.06275 F3600
G1 X2.000 Y6.800 E0.08546 F3600
G1 X2.200 Y7.000 E0.09503 F3600
G1 X2.100 Y7.100 E0.09982 F3600
G1 X2.600 Y7.500 E0.12149 F3600
G1 X2.800 Y7.300 E0.13107 F3600
G1 X2.600 Y7.100 E0.14064 F3600
G1 X2.700 Y6.900 E0.14821 F3600
G1 X2.200 Y6.400 E0.17214 F3600
G1 X2.300 Y6.300 E0.17693 F3600
G1 X2.200 Y6.200 E0.18172 F3600
G1 X2.300 Y6.000 E0.18929 F3600
G1 X2.200 Y5.900 E0.19407 F3600
G1 X2.300 Y5.700 E0.20164 F3600
G1 X2.200 Y5.600 E0.20643 F3600
G1 X2.300 Y5.400 E0.21400 F3600
G1 X2.200 Y5.300 E0.21878 F3600
G1 X3.000 Y4.500 E0.25708 F3600
G1 X3.200 Y4.700 E0.26665 F3600
G1 X3.200 Y4.800 E0.27004 F3600
G1 X2.700 Y5.300 E0.29397 F3600
G1 X2.800 Y5.400 E0.29876 F3600
G1 X2.700 Y5.500 E0.30355 F3600
G1 X2.800 Y5.600 E0.30833 F3600
G1 X2.700 Y5.700 E0.31312 F3600
G1 X2.700 Y6.000 E0.32328 F3600
G1 X2.600 Y6.100 E0.32806 F3600
G1 X3.200 Y6.800 E0.35927 F3600
G1 X3.100 Y7.000 E0.36684 F3600
G1 X3.400 Y7.400 E0.38376 F3600
G1 X3.500 Y7.400 E0.38715 F3600
G1 X3.700 Y7.200 E0.39672 F3600
G1 X3.600 Y7.100 E0.40151 F3600
G1 X4.000 Y6.800 E0.41843 F3600
G1 X3.800 Y6.600 E0.42801 F3600
G1 X3.600 Y6.700 E0.43558 F3600
G1 X3.000 Y6.100 E0.46430 F3600
G1 X3.200 Y5.800 E0.47650 F3600
G1 X3.800 Y6.400 E0.50522 F3600
G1 X4.000 Y6.300 E0.51279 F3600
G1 X4.100 Y6.200 E0.51758 F3600
G1 X3.800 Y5.900 E0.53194 F3600
G1 X4.000 Y5.700 E0.54151 F3600
G1 X3.900 Y5.600 E0.54630 F3600
G1 X3.400 Y5.600 E0.56323 F3600
G1 X3.200 Y5.400 E0.57280 F3600
G1 X3.600 Y5.000 E0.59195 F3600
G1 X3.900 Y5.300 E0.60631 F3600
G1 X3.900 Y5.400 E0.60969 F3600
G1 E-0.09031 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X3.900 Y5.500 F9000
G0 X5.300 Y5.500 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.60969 F2100 ; unretract
G1 X5.400 Y5.400 E0.61448 F3600
G1 X5.600 Y5.600 E0.62405 F3600
G1 X5.700 Y5.500 E0.62884 F3600
G1 X5.900 Y5.700 E0.63841 F3600
G1 X6.300 Y5.300 E0.65756 F3600
G1 X6.100 Y5.100 E0.66714 F3600
G1 X5.900 Y5.100 E0.67391 F3600
G1 X5.800 Y5.000 E0.67869 F3600
G1 X5.700 Y5.100 E0.68348 F3600
;--- Shutdown ---
G1 E-0.01652 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---