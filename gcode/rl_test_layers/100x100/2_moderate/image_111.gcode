;FLAVOR:Marlin
;Generated from path with 80 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.900 Y-1.200 W32.000 H7.800 ; print area for bed levelling
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
G0 X2.500 Y4.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X1.900 Y5.000 E0.03121 F3600
G1 X2.000 Y5.100 E0.03599 F3600
G1 X1.900 Y5.200 E0.04078 F3600
G1 X2.000 Y5.300 E0.04557 F3600
G1 X1.900 Y5.400 E0.05035 F3600
G1 X2.500 Y6.000 E0.07908 F3600
G1 X2.400 Y6.200 E0.08665 F3600
G1 X2.700 Y6.600 E0.10357 F3600
G1 X2.800 Y6.500 E0.10836 F3600
G1 X2.600 Y6.300 E0.11793 F3600
G1 X2.700 Y6.200 E0.12272 F3600
G1 X2.600 Y6.100 E0.12750 F3600
G0 X2.700 Y6.000 F9000
G0 X2.600 Y5.600 F9000
G1 X2.300 Y5.300 E0.14187 F3600
G1 X2.500 Y5.100 E0.15144 F3600
G1 X2.400 Y5.000 E0.15623 F3600
G1 X3.000 Y4.400 E0.18495 F3600
G1 X3.300 Y4.700 E0.19931 F3600
G1 X2.900 Y5.100 E0.21846 F3600
G1 X2.900 Y5.200 E0.22184 F3600
G1 X3.100 Y5.300 E0.22941 F3600
G1 X3.400 Y5.000 E0.24377 F3600
G1 X4.100 Y5.700 E0.27728 F3600
G1 X4.500 Y5.900 E0.29242 F3600
G1 X4.900 Y6.300 E0.31156 F3600
G1 X5.200 Y6.000 E0.32593 F3600
G1 X4.500 Y5.300 E0.35943 F3600
G1 X4.400 Y5.400 E0.36422 F3600
G1 X3.500 Y4.500 E0.40730 F3600
G1 X3.700 Y4.300 E0.41688 F3600
G1 X3.800 Y4.400 E0.42166 F3600
G1 X3.900 Y4.300 E0.42645 F3600
G1 X5.300 Y5.700 E0.49347 F3600
G1 X5.400 Y5.700 E0.49685 F3600
G1 X5.600 Y5.500 E0.50643 F3600
G1 X5.600 Y5.400 E0.50981 F3600
G1 X4.500 Y4.300 E0.56247 F3600
G1 X4.800 Y4.000 E0.57683 F3600
G1 X5.800 Y5.000 E0.62470 F3600
G1 X5.900 Y4.900 E0.62949 F3600
G1 X6.500 Y5.400 E0.65592 F3600
G1 X6.600 Y5.300 E0.66071 F3600
G1 X6.700 Y5.400 E0.66550 F3600
G1 X6.900 Y5.200 E0.67507 F3600
G1 X6.200 Y4.500 E0.70858 F3600
G1 X6.000 Y4.500 E0.71535 F3600
G1 X5.300 Y3.800 E0.74886 F3600
G1 X5.200 Y3.800 E0.75224 F3600
G1 X5.000 Y3.600 E0.76182 F3600
G1 X5.400 Y3.200 E0.78096 F3600
G1 X5.300 Y3.100 E0.78575 F3600
G1 X5.600 Y2.800 E0.80011 F3600
G1 X5.800 Y3.000 E0.80969 F3600
G1 X5.900 Y2.900 E0.81447 F3600
G1 X6.100 Y3.100 E0.82405 F3600
G1 X5.700 Y3.500 E0.84319 F3600
G1 X7.300 Y5.100 E0.91979 F3600
G1 X7.400 Y5.000 E0.92457 F3600
G1 X7.500 Y5.100 E0.92936 F3600
G1 X7.900 Y4.700 E0.94851 F3600
G1 X7.800 Y4.600 E0.95329 F3600
G1 X7.900 Y4.500 E0.95808 F3600
G1 X7.700 Y4.400 E0.96565 F3600
G1 X7.500 Y4.600 E0.97522 F3600
G1 X7.400 Y4.600 E0.97861 F3600
G1 X6.300 Y3.500 E1.03127 F3600
G1 X6.500 Y3.300 E1.04084 F3600
G1 X6.800 Y3.600 E1.05520 F3600
G1 X6.900 Y3.500 E1.05999 F3600
G1 X7.500 Y4.100 E1.08871 F3600
G1 X7.700 Y4.100 E1.09548 F3600
G1 X7.900 Y3.900 E1.10505 F3600
G1 X7.800 Y3.900 E1.10844 F3600
G1 X7.200 Y3.300 E1.13716 F3600
G1 X7.300 Y3.200 E1.14195 F3600
G1 X7.500 Y3.300 E1.14951 F3600
G1 X7.600 Y3.200 E1.15430 F3600
;--- Shutdown ---
G1 E0.45430 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---