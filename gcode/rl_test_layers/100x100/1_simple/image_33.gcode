;FLAVOR:Marlin
;Generated from path with 91 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-2.100 W32.000 H9.100 ; print area for bed levelling
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
G0 X3.200 Y3.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.300 Y3.500 E0.00479 F3600
G1 X2.900 Y3.900 E0.02393 F3600
G1 X2.800 Y3.900 E0.02732 F3600
G1 X2.600 Y4.100 E0.03689 F3600
G1 X2.500 Y4.000 E0.04168 F3600
G1 X1.600 Y4.900 E0.08476 F3600
G1 X1.700 Y5.000 E0.08955 F3600
G1 X1.600 Y5.100 E0.09434 F3600
G1 X2.200 Y5.700 E0.12306 F3600
G1 X2.200 Y5.800 E0.12644 F3600
G1 X2.500 Y6.100 E0.14080 F3600
G1 X2.500 Y6.200 E0.14419 F3600
G1 X2.800 Y6.500 E0.15855 F3600
G1 X2.800 Y6.600 E0.16193 F3600
G1 X3.200 Y7.000 E0.18108 F3600
G1 X3.300 Y6.900 E0.18587 F3600
G1 X3.400 Y7.000 E0.19066 F3600
G1 X3.700 Y6.700 E0.20502 F3600
G1 X3.500 Y6.500 E0.21459 F3600
G1 X3.400 Y6.500 E0.21798 F3600
G1 X2.100 Y5.100 E0.28264 F3600
G1 X2.400 Y4.800 E0.29700 F3600
G1 X3.900 Y6.300 E0.36881 F3600
G1 X4.000 Y6.500 E0.37638 F3600
G1 X4.300 Y6.200 E0.39074 F3600
G1 X4.400 Y6.300 E0.39553 F3600
G1 X4.700 Y6.000 E0.40989 F3600
G1 X4.400 Y5.700 E0.42425 F3600
G1 X4.300 Y5.700 E0.42763 F3600
G1 X4.100 Y5.900 E0.43721 F3600
G1 X2.700 Y4.500 E0.50422 F3600
G1 X3.000 Y4.200 E0.51858 F3600
G1 X4.100 Y5.300 E0.57124 F3600
G1 X4.200 Y5.200 E0.57603 F3600
G1 X4.400 Y5.400 E0.58560 F3600
G1 X4.500 Y5.300 E0.59039 F3600
G1 X5.000 Y5.800 E0.61432 F3600
G1 X5.300 Y5.500 E0.62868 F3600
G1 X4.600 Y4.800 E0.66219 F3600
G1 X4.500 Y4.900 E0.66698 F3600
G1 X4.300 Y4.800 E0.67455 F3600
G1 X3.400 Y3.900 E0.71763 F3600
G1 X3.700 Y3.600 E0.73199 F3600
G1 X4.500 Y4.400 E0.77029 F3600
G1 X4.700 Y4.500 E0.77786 F3600
G1 X4.800 Y4.400 E0.78264 F3600
G1 X5.500 Y5.100 E0.81615 F3600
G1 X5.600 Y5.300 E0.82372 F3600
G1 X6.000 Y4.900 E0.84287 F3600
G1 X5.100 Y4.000 E0.88595 F3600
G1 X4.900 Y4.000 E0.89272 F3600
G1 X4.800 Y4.100 E0.89751 F3600
G1 X4.100 Y3.400 E0.93102 F3600
G1 X3.800 Y3.300 E0.94172 F3600
G1 X3.700 Y3.200 E0.94651 F3600
G1 X4.000 Y2.900 E0.96087 F3600
G1 X4.100 Y3.000 E0.96565 F3600
G1 X4.300 Y2.900 E0.97322 F3600
G1 X5.000 Y3.600 E1.00673 F3600
G1 X5.100 Y3.500 E1.01152 F3600
G1 X6.400 Y4.800 E1.07375 F3600
G1 X6.700 Y4.500 E1.08811 F3600
G1 X6.700 Y4.400 E1.09150 F3600
G1 X6.500 Y4.300 E1.09906 F3600
G1 X5.300 Y3.100 E1.15651 F3600
G1 X5.200 Y3.100 E1.15989 F3600
G1 X4.900 Y2.800 E1.17425 F3600
G1 X4.700 Y2.800 E1.18102 F3600
G1 X4.500 Y2.600 E1.19060 F3600
G1 X4.800 Y2.300 E1.20496 F3600
G1 X4.900 Y2.400 E1.20974 F3600
G1 X5.400 Y1.900 E1.23368 F3600
G1 X5.700 Y2.200 E1.24804 F3600
G1 X5.300 Y2.600 E1.26719 F3600
G1 X5.700 Y2.900 E1.28411 F3600
G1 X6.100 Y2.500 E1.30326 F3600
G1 X6.200 Y2.600 E1.30805 F3600
G1 X6.200 Y2.800 E1.31482 F3600
G1 X5.900 Y3.100 E1.32918 F3600
G1 X6.200 Y3.400 E1.34354 F3600
G1 X6.500 Y3.100 E1.35790 F3600
G1 X6.600 Y3.300 E1.36547 F3600
G1 X6.400 Y3.600 E1.37767 F3600
G1 X6.600 Y3.900 E1.38988 F3600
G1 X6.800 Y3.700 E1.39945 F3600
G1 X6.900 Y3.700 E1.40284 F3600
G1 X7.000 Y3.800 E1.40762 F3600
G1 X6.900 Y4.000 E1.41519 F3600
G1 X7.000 Y4.100 E1.41998 F3600
;--- Shutdown ---
G1 E0.71998 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---