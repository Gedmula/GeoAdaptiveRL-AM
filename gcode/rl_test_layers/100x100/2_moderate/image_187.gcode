;FLAVOR:Marlin
;Generated from path with 39 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.400 Y-2.400 W32.000 H7.700 ; print area for bed levelling
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
G0 X3.600 Y3.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.400 Y5.000 E0.05744 F3600
G1 X2.700 Y5.300 E0.07180 F3600
G1 X3.300 Y4.700 E0.10053 F3600
G1 X3.400 Y4.700 E0.10391 F3600
G1 X3.700 Y4.400 E0.11827 F3600
G1 X3.800 Y4.500 E0.12306 F3600
G1 X4.000 Y4.300 E0.13263 F3600
G1 X3.800 Y4.100 E0.14221 F3600
G1 X4.000 Y3.900 E0.15178 F3600
G1 X4.200 Y4.100 E0.16135 F3600
G1 X4.300 Y4.100 E0.16474 F3600
G1 X4.500 Y3.900 E0.17431 F3600
G1 X4.100 Y3.500 E0.19346 F3600
G1 X4.300 Y3.300 E0.20303 F3600
G1 X4.500 Y3.200 E0.21060 F3600
G1 X4.900 Y3.700 E0.23228 F3600
G1 X5.100 Y3.500 E0.24185 F3600
G1 X5.100 Y3.400 E0.24524 F3600
G1 X4.800 Y3.100 E0.25960 F3600
G1 X5.100 Y2.800 E0.27396 F3600
G1 X5.300 Y2.900 E0.28153 F3600
G1 X5.300 Y3.100 E0.28830 F3600
G1 X5.500 Y3.300 E0.29787 F3600
G1 X5.800 Y3.000 E0.31223 F3600
G1 X5.400 Y2.600 E0.33138 F3600
G1 X5.700 Y2.300 E0.34574 F3600
G1 X6.100 Y2.800 E0.36741 F3600
G1 X6.400 Y2.500 E0.38177 F3600
G1 X6.000 Y2.100 E0.40092 F3600
G1 X6.200 Y1.900 E0.41050 F3600
G1 X6.400 Y1.800 E0.41806 F3600
G1 X6.500 Y1.900 E0.42285 F3600
G1 X6.500 Y2.100 E0.42962 F3600
G1 X6.700 Y2.300 E0.43920 F3600
G1 X7.000 Y2.000 E0.45356 F3600
G1 X7.000 Y1.800 E0.46033 F3600
G1 X6.600 Y1.600 E0.47546 F3600
;--- Shutdown ---
G1 E-0.22454 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---