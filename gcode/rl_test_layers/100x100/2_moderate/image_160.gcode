;FLAVOR:Marlin
;Generated from path with 87 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.900 Y-2.300 W32.000 H8.500 ; print area for bed levelling
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
G0 X3.100 Y3.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.200 Y3.200 E0.00479 F3600
G1 X3.100 Y3.300 E0.00957 F3600
G1 X3.100 Y3.500 E0.01634 F3600
G1 X2.900 Y3.700 E0.02592 F3600
G1 X3.000 Y3.800 E0.03070 F3600
G1 X2.900 Y3.900 E0.03549 F3600
G1 X3.000 Y4.000 E0.04028 F3600
G1 X2.900 Y4.100 E0.04507 F3600
G1 X3.200 Y4.500 E0.06199 F3600
G1 X3.200 Y4.700 E0.06876 F3600
G1 X3.300 Y4.800 E0.07355 F3600
G1 X3.200 Y4.900 E0.07833 F3600
G1 X3.300 Y5.000 E0.08312 F3600
G1 X3.200 Y5.100 E0.08791 F3600
G1 X3.300 Y5.200 E0.09269 F3600
G1 X3.200 Y5.300 E0.09748 F3600
G1 X3.300 Y5.400 E0.10227 F3600
G1 X3.200 Y5.500 E0.10706 F3600
G1 X3.300 Y5.700 E0.11462 F3600
G1 X3.800 Y6.200 E0.13856 F3600
G1 X3.900 Y6.100 E0.14335 F3600
G1 X4.000 Y6.200 E0.14813 F3600
G1 X4.300 Y5.900 E0.16249 F3600
G1 X4.400 Y6.000 E0.16728 F3600
G1 X4.600 Y5.800 E0.17685 F3600
G1 X4.500 Y5.700 E0.18164 F3600
G1 X4.600 Y5.600 E0.18643 F3600
G1 X4.400 Y5.400 E0.19600 F3600
G1 X4.000 Y5.800 E0.21515 F3600
G1 X3.700 Y5.500 E0.22951 F3600
G1 X3.900 Y5.300 E0.23908 F3600
G1 X3.700 Y5.100 E0.24866 F3600
G1 X3.800 Y5.000 E0.25345 F3600
G1 X3.700 Y4.900 E0.25823 F3600
G1 X3.800 Y4.800 E0.26302 F3600
G1 X3.300 Y4.300 E0.28695 F3600
G1 X3.400 Y4.200 E0.29174 F3600
G1 X3.300 Y4.100 E0.29653 F3600
G1 X3.500 Y3.900 E0.30610 F3600
G0 X3.400 Y3.800 F9000
G0 X3.400 Y3.600 F9000
G1 X3.700 Y3.300 E0.32046 F3600
G1 X3.300 Y2.900 E0.33961 F3600
G1 X3.600 Y2.600 E0.35397 F3600
G1 X3.400 Y2.400 E0.36354 F3600
G1 X3.600 Y2.200 E0.37312 F3600
G1 X3.500 Y2.100 E0.37791 F3600
G1 X3.900 Y1.700 E0.39705 F3600
G1 X4.100 Y1.900 E0.40663 F3600
G1 X4.000 Y2.000 E0.41141 F3600
G1 X4.100 Y2.100 E0.41620 F3600
G1 X3.900 Y2.400 E0.42841 F3600
G1 X4.000 Y2.600 E0.43597 F3600
G1 X3.800 Y2.800 E0.44555 F3600
G1 X4.600 Y3.600 E0.48384 F3600
G1 X4.700 Y4.000 E0.49780 F3600
G1 X4.800 Y4.100 E0.50259 F3600
G1 X4.100 Y4.800 E0.53610 F3600
G1 X4.300 Y5.100 E0.54830 F3600
G1 X4.500 Y5.000 E0.55587 F3600
G1 X4.700 Y5.200 E0.56544 F3600
G1 X4.800 Y5.100 E0.57023 F3600
G1 X4.600 Y4.900 E0.57980 F3600
G1 X5.000 Y4.500 E0.59895 F3600
G1 X4.900 Y4.400 E0.60374 F3600
G1 X5.100 Y4.200 E0.61331 F3600
G1 X5.000 Y4.100 E0.61810 F3600
G1 X5.100 Y4.000 E0.62289 F3600
G1 X5.000 Y3.900 E0.62767 F3600
G1 X5.100 Y3.800 E0.63246 F3600
G1 X4.900 Y3.600 E0.64203 F3600
G1 X5.000 Y3.500 E0.64682 F3600
G1 X4.700 Y3.200 E0.66118 F3600
G1 X4.800 Y3.000 E0.66875 F3600
G1 X4.700 Y2.900 E0.67354 F3600
G1 X4.600 Y3.000 E0.67832 F3600
G1 X4.400 Y2.800 E0.68790 F3600
G1 X4.500 Y2.700 E0.69269 F3600
G1 X4.300 Y2.500 E0.70226 F3600
G1 X4.400 Y2.400 E0.70705 F3600
G1 X4.600 Y2.600 E0.71662 F3600
G1 X4.800 Y2.400 E0.72619 F3600
G1 X4.700 Y2.300 E0.73098 F3600
G1 X4.700 Y2.100 E0.73775 F3600
G1 X4.400 Y1.800 E0.75211 F3600
;--- Shutdown ---
G1 E0.05211 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---