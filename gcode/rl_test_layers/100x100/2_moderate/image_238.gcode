;FLAVOR:Marlin
;Generated from path with 79 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.100 Y-1.700 W32.000 H8.800 ; print area for bed levelling
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
G0 X4.400 Y4.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.500 Y4.500 E0.00479 F3600
G1 X4.400 Y4.700 E0.01236 F3600
G1 X3.600 Y5.500 E0.05065 F3600
G1 X3.700 Y5.600 E0.05544 F3600
G1 X3.100 Y6.200 E0.08416 F3600
G1 X3.300 Y6.400 E0.09373 F3600
G1 X3.700 Y6.000 E0.11288 F3600
G1 X4.000 Y6.300 E0.12724 F3600
G1 X4.100 Y6.200 E0.13203 F3600
G1 X4.500 Y6.600 E0.15118 F3600
G1 X4.500 Y6.800 E0.15795 F3600
G1 X4.400 Y6.900 E0.16273 F3600
G1 X4.500 Y7.100 E0.17030 F3600
G1 X4.800 Y6.900 E0.18251 F3600
G1 X4.700 Y6.800 E0.18729 F3600
G1 X4.800 Y6.700 E0.19208 F3600
G1 X4.700 Y6.600 E0.19687 F3600
G1 X4.800 Y6.500 E0.20165 F3600
G1 X4.700 Y6.400 E0.20644 F3600
G1 X4.900 Y6.200 E0.21602 F3600
G1 X4.700 Y6.000 E0.22559 F3600
G1 X4.600 Y6.100 E0.23038 F3600
G1 X4.200 Y5.900 E0.24551 F3600
G1 X4.000 Y5.700 E0.25509 F3600
G1 X4.300 Y5.400 E0.26945 F3600
G1 X4.500 Y5.600 E0.27902 F3600
G1 X4.600 Y5.500 E0.28381 F3600
G1 X5.000 Y5.900 E0.30296 F3600
G1 X5.100 Y5.800 E0.30774 F3600
G1 X5.000 Y5.700 E0.31253 F3600
G1 X5.100 Y5.600 E0.31732 F3600
G0 X4.900 Y5.300 F9000
G1 X4.600 Y5.100 E0.32952 F3600
G1 X4.700 Y4.900 E0.33709 F3600
G1 X4.800 Y4.800 E0.34188 F3600
G1 X5.100 Y5.100 E0.35624 F3600
G1 X5.300 Y4.900 E0.36581 F3600
G1 X5.200 Y4.800 E0.37060 F3600
G1 X5.300 Y4.700 E0.37539 F3600
G1 X4.500 Y3.900 E0.41368 F3600
G1 X4.600 Y3.800 E0.41847 F3600
G1 X4.500 Y3.600 E0.42604 F3600
G1 X4.700 Y3.400 E0.43561 F3600
G1 X4.200 Y2.900 E0.45955 F3600
G1 X4.300 Y2.800 E0.46433 F3600
G1 X4.300 Y2.600 E0.47110 F3600
G1 X4.600 Y2.300 E0.48546 F3600
G1 X4.900 Y2.500 E0.49767 F3600
G1 X4.700 Y2.700 E0.50724 F3600
G1 X5.100 Y3.100 E0.52639 F3600
G1 X5.000 Y3.200 E0.53118 F3600
G1 X5.100 Y3.300 E0.53596 F3600
G1 X5.000 Y3.500 E0.54353 F3600
G1 X5.100 Y3.600 E0.54832 F3600
G1 X5.000 Y3.700 E0.55311 F3600
G1 X5.100 Y3.900 E0.56068 F3600
G1 X5.600 Y4.400 E0.58461 F3600
G1 X5.900 Y4.100 E0.59897 F3600
G1 X5.500 Y3.600 E0.62065 F3600
G1 X5.700 Y3.300 E0.63285 F3600
G1 X5.200 Y2.800 E0.65678 F3600
G1 X5.200 Y2.700 E0.66017 F3600
G1 X5.400 Y2.600 E0.66774 F3600
G1 X5.800 Y2.900 E0.68466 F3600
G1 X5.900 Y2.800 E0.68945 F3600
G1 X6.100 Y3.000 E0.69902 F3600
G1 X6.100 Y3.300 E0.70918 F3600
G1 X6.000 Y3.500 E0.71675 F3600
G1 X6.100 Y3.600 E0.72153 F3600
G1 X6.100 Y3.800 E0.72830 F3600
G1 X6.300 Y4.000 E0.73788 F3600
G1 X6.400 Y3.900 E0.74266 F3600
G1 X6.500 Y4.000 E0.74745 F3600
G1 X6.700 Y3.800 E0.75703 F3600
G1 X6.400 Y3.500 E0.77139 F3600
G1 X6.400 Y3.300 E0.77816 F3600
G1 X6.600 Y3.100 E0.78773 F3600
;--- Shutdown ---
G1 E0.08773 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---