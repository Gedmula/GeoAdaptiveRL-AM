;FLAVOR:Marlin
;Generated from path with 95 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.300 Y0.800 W32.000 H4.900 ; print area for bed levelling
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
G0 X1.500 Y4.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.300 Y5.000 E0.00957 F3600
G1 X1.400 Y5.100 E0.01436 F3600
G1 X1.300 Y5.200 E0.01915 F3600
G1 X1.500 Y5.400 E0.02872 F3600
G1 X1.700 Y5.200 E0.03830 F3600
G1 X2.100 Y5.500 E0.05522 F3600
G1 X2.200 Y5.400 E0.06001 F3600
G1 X2.100 Y5.300 E0.06479 F3600
G0 X2.000 Y4.900 F9000
G1 X2.100 Y5.000 E0.06958 F3600
G1 X2.200 Y4.900 E0.07437 F3600
G1 X2.300 Y5.000 E0.07915 F3600
G1 X2.400 Y4.900 E0.08394 F3600
G1 X2.600 Y5.100 E0.09352 F3600
G1 X2.500 Y5.200 E0.09830 F3600
G1 X2.500 Y5.400 E0.10507 F3600
G1 X2.600 Y5.500 E0.10986 F3600
G1 X2.700 Y5.400 E0.11465 F3600
G1 X2.900 Y5.500 E0.12221 F3600
G1 X3.100 Y5.300 E0.13179 F3600
G1 X2.900 Y5.100 E0.14136 F3600
G1 X3.000 Y4.900 E0.14893 F3600
G1 X3.100 Y5.000 E0.15372 F3600
G1 X3.200 Y4.900 E0.15851 F3600
G1 X3.300 Y5.000 E0.16329 F3600
G1 X3.400 Y4.900 E0.16808 F3600
G1 X3.600 Y5.100 E0.17765 F3600
G1 X3.300 Y5.400 E0.19201 F3600
G1 X3.400 Y5.500 E0.19680 F3600
G1 X3.600 Y5.500 E0.20357 F3600
G1 X3.700 Y5.400 E0.20836 F3600
G1 X3.900 Y5.500 E0.21593 F3600
G1 X4.100 Y5.300 E0.22550 F3600
G1 X3.900 Y5.100 E0.23507 F3600
G1 X3.900 Y5.000 E0.23846 F3600
G1 X4.000 Y4.900 E0.24325 F3600
G1 X4.100 Y5.000 E0.24803 F3600
G1 X4.200 Y4.900 E0.25282 F3600
G1 X4.300 Y5.000 E0.25761 F3600
G1 X4.400 Y4.900 E0.26239 F3600
G1 X4.600 Y5.100 E0.27197 F3600
G1 X4.300 Y5.400 E0.28633 F3600
G1 X4.500 Y5.600 E0.29590 F3600
G1 X4.700 Y5.400 E0.30548 F3600
G1 X4.900 Y5.500 E0.31305 F3600
G1 X5.100 Y5.300 E0.32262 F3600
G1 X4.900 Y5.100 E0.33219 F3600
G1 X5.000 Y4.900 E0.33976 F3600
G1 X5.200 Y5.100 E0.34934 F3600
G1 X5.300 Y5.000 E0.35412 F3600
G1 X5.400 Y5.100 E0.35891 F3600
G1 X5.500 Y5.000 E0.36370 F3600
G1 X5.700 Y5.200 E0.37327 F3600
G1 X5.400 Y5.500 E0.38763 F3600
G1 X5.600 Y5.700 E0.39721 F3600
G1 X5.800 Y5.500 E0.40678 F3600
G1 X5.900 Y5.600 E0.41157 F3600
G1 X6.000 Y5.500 E0.41635 F3600
G1 X6.100 Y5.600 E0.42114 F3600
G1 X6.300 Y5.400 E0.43071 F3600
G1 X6.000 Y5.100 E0.44507 F3600
G1 X6.100 Y5.000 E0.44986 F3600
G1 X6.200 Y5.100 E0.45465 F3600
G1 X6.300 Y5.000 E0.45944 F3600
G1 X6.400 Y5.100 E0.46422 F3600
G1 X6.500 Y5.000 E0.46901 F3600
G1 X6.600 Y5.100 E0.47380 F3600
G1 X6.700 Y5.000 E0.47858 F3600
G1 X6.900 Y5.200 E0.48816 F3600
G1 X6.600 Y5.500 E0.50252 F3600
G1 X6.700 Y5.600 E0.50730 F3600
G1 X6.900 Y5.600 E0.51407 F3600
G1 X7.000 Y5.500 E0.51886 F3600
G1 X7.100 Y5.600 E0.52365 F3600
G1 X7.200 Y5.500 E0.52844 F3600
G1 X7.300 Y5.600 E0.53322 F3600
G1 X7.500 Y5.400 E0.54280 F3600
G1 X7.200 Y5.100 E0.55716 F3600
G1 X7.300 Y5.000 E0.56194 F3600
G1 X7.500 Y5.100 E0.56951 F3600
G1 X7.600 Y5.000 E0.57430 F3600
G1 X7.700 Y5.100 E0.57909 F3600
G1 X7.800 Y5.000 E0.58387 F3600
G1 X7.800 Y5.100 E0.58726 F3600
G1 X8.000 Y5.300 E0.59683 F3600
G1 X7.800 Y5.500 E0.60641 F3600
G1 X7.900 Y5.600 E0.61119 F3600
G1 X8.000 Y5.500 E0.61598 F3600
G1 X8.200 Y5.700 E0.62555 F3600
G1 X8.400 Y5.500 E0.63513 F3600
G1 X8.300 Y5.400 E0.63992 F3600
G1 X8.400 Y5.300 E0.64470 F3600
G1 X8.100 Y5.000 E0.65906 F3600
;--- Shutdown ---
G1 E-0.04094 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---