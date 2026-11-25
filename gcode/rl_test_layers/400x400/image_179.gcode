;FLAVOR:Marlin
;Generated from path with 65 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.800 Y14.800 W32.000 H6.200 ; print area for bed levelling
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
G0 X3.600 Y18.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.700 Y18.900 E0.00479 F3600
G1 X3.600 Y19.000 E0.00957 F3600
G1 X3.100 Y19.000 E0.02650 F3600
G1 X3.000 Y19.100 E0.03129 F3600
G1 X3.100 Y19.200 E0.03607 F3600
G1 X3.000 Y19.300 E0.04086 F3600
G1 X3.100 Y19.400 E0.04565 F3600
G1 X3.100 Y19.600 E0.05242 F3600
G1 X2.900 Y19.800 E0.06199 F3600
G1 X3.000 Y19.900 E0.06678 F3600
G1 X3.000 Y20.200 E0.07693 F3600
G1 X2.800 Y20.400 E0.08651 F3600
G1 X2.900 Y20.500 E0.09129 F3600
G1 X2.800 Y20.600 E0.09608 F3600
G1 X2.800 Y20.800 E0.10285 F3600
G1 X2.900 Y20.900 E0.10764 F3600
G1 X3.200 Y20.700 E0.11984 F3600
G1 X3.300 Y20.800 E0.12463 F3600
G1 X3.500 Y20.600 E0.13420 F3600
G1 X3.300 Y20.400 E0.14377 F3600
G1 X3.500 Y20.200 E0.15335 F3600
G1 X3.300 Y20.000 E0.16292 F3600
G1 X3.500 Y19.800 E0.17250 F3600
G1 X3.800 Y20.100 E0.18686 F3600
G1 X3.800 Y20.400 E0.19701 F3600
G1 X3.900 Y20.500 E0.20180 F3600
G1 X4.000 Y20.400 E0.20659 F3600
G1 X4.100 Y20.500 E0.21137 F3600
G1 X4.200 Y20.400 E0.21616 F3600
G1 X4.300 Y20.500 E0.22095 F3600
G1 X4.400 Y20.400 E0.22573 F3600
G1 X4.600 Y20.500 E0.23330 F3600
G1 X4.800 Y20.300 E0.24288 F3600
G1 X4.900 Y20.400 E0.24766 F3600
G1 X5.100 Y20.300 E0.25523 F3600
G1 X5.300 Y20.500 E0.26481 F3600
G1 X5.400 Y20.400 E0.26959 F3600
G1 X5.600 Y20.600 E0.27917 F3600
G1 X5.700 Y20.500 E0.28395 F3600
G1 X6.300 Y21.000 E0.31039 F3600
G1 X6.500 Y20.800 E0.31996 F3600
G1 X6.400 Y20.700 E0.32475 F3600
G1 X6.600 Y20.500 E0.33433 F3600
G1 X6.500 Y20.400 E0.33911 F3600
G1 X6.300 Y20.500 E0.34668 F3600
G1 X6.000 Y20.200 E0.36104 F3600
G1 X5.800 Y20.100 E0.36861 F3600
G1 X5.500 Y20.100 E0.37877 F3600
G1 X5.200 Y19.800 E0.39313 F3600
G1 X5.100 Y19.900 E0.39791 F3600
G1 X5.000 Y19.800 E0.40270 F3600
G1 X4.900 Y19.900 E0.40749 F3600
G1 X4.700 Y19.800 E0.41506 F3600
G1 X4.300 Y20.100 E0.43198 F3600
G1 X3.500 Y19.400 E0.46796 F3600
G1 X3.600 Y19.300 E0.47275 F3600
G1 X3.700 Y19.400 E0.47754 F3600
G1 X3.900 Y19.200 E0.48711 F3600
G1 X4.300 Y19.600 E0.50626 F3600
G1 X4.400 Y19.500 E0.51104 F3600
G1 X4.600 Y19.700 E0.52062 F3600
G1 E-0.17938 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X4.700 Y19.800 F9000
G0 X6.000 Y19.900 F9000
;--- Shutdown ---
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---