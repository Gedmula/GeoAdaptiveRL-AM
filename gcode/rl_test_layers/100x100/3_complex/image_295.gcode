;FLAVOR:Marlin
;Generated from path with 92 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.800 Y-1.600 W32.000 H10.200 ; print area for bed levelling
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
G0 X3.200 Y3.200 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X3.300 Y3.300 E0.00479 F3600
G1 X2.800 Y3.800 E0.02872 F3600
G1 X3.000 Y4.000 E0.03830 F3600
G1 X3.200 Y3.900 E0.04586 F3600
G1 X3.600 Y4.200 E0.06279 F3600
G1 X3.800 Y4.100 E0.07036 F3600
G1 X3.900 Y4.200 E0.07514 F3600
G1 X4.100 Y4.000 E0.08472 F3600
G1 X3.900 Y3.800 E0.09429 F3600
G1 X3.700 Y3.800 E0.10106 F3600
G1 X3.500 Y3.600 E0.11064 F3600
G1 X3.900 Y3.300 E0.12756 F3600
G1 X3.500 Y2.900 E0.14671 F3600
G1 X4.000 Y2.400 E0.17064 F3600
G1 X4.200 Y2.600 E0.18022 F3600
G1 X4.100 Y2.800 E0.18779 F3600
G1 X4.200 Y2.900 E0.19257 F3600
G1 X4.200 Y3.300 E0.20611 F3600
G1 X4.100 Y3.400 E0.21090 F3600
G1 X4.200 Y3.600 E0.21847 F3600
G1 X4.300 Y3.600 E0.22185 F3600
G1 X4.600 Y3.300 E0.23621 F3600
G1 X4.500 Y3.200 E0.24100 F3600
G1 X4.700 Y3.000 E0.25057 F3600
G1 X4.600 Y2.900 E0.25536 F3600
G1 X4.700 Y2.800 E0.26015 F3600
G1 X4.600 Y2.900 E0.26494 F3600
G1 E-0.43506 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X4.700 Y2.800 F9000
G0 X5.700 Y3.800 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.26494 F2100 ; unretract
G1 X5.800 Y3.900 E0.26972 F3600
G1 X5.400 Y4.300 E0.28887 F3600
G1 X5.700 Y4.600 E0.30323 F3600
G1 X5.900 Y4.500 E0.31080 F3600
G1 X6.100 Y4.700 E0.32037 F3600
G1 X6.500 Y4.300 E0.33952 F3600
G1 X6.300 Y4.100 E0.34910 F3600
G1 X6.100 Y4.200 E0.35666 F3600
G1 X6.000 Y4.100 E0.36145 F3600
G1 X6.100 Y3.900 E0.36902 F3600
G1 X6.000 Y3.800 E0.37381 F3600
G1 X5.900 Y3.900 E0.37859 F3600
G1 E-0.32141 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X6.000 Y4.000 F9000
G0 X4.000 Y6.500 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.37859 F2100 ; unretract
G1 X3.800 Y6.700 E0.38817 F3600
G1 X3.600 Y6.500 E0.39774 F3600
G1 X3.700 Y6.400 E0.40253 F3600
G1 X3.800 Y6.500 E0.40732 F3600
G0 X4.200 Y6.900 F9000
G1 X4.500 Y6.600 E0.42168 F3600
G1 X4.700 Y6.800 E0.43125 F3600
G1 X4.500 Y7.000 E0.44082 F3600
G1 X5.400 Y7.800 E0.48158 F3600
G1 X5.700 Y7.900 E0.49229 F3600
G1 X6.000 Y8.200 E0.50665 F3600
G1 X6.100 Y8.100 E0.51143 F3600
G1 X6.500 Y8.600 E0.53311 F3600
G1 X6.700 Y8.400 E0.54268 F3600
G1 X6.800 Y8.500 E0.54747 F3600
G1 X7.000 Y8.300 E0.55704 F3600
G1 X6.800 Y8.100 E0.56662 F3600
G1 X6.700 Y8.100 E0.57000 F3600
G1 X6.300 Y7.700 E0.58915 F3600
G1 X6.100 Y7.800 E0.59672 F3600
G1 X5.400 Y7.100 E0.63023 F3600
G1 X5.200 Y7.100 E0.63700 F3600
G1 X5.000 Y6.900 E0.64657 F3600
G1 X5.100 Y6.800 E0.65136 F3600
G1 X5.200 Y6.900 E0.65615 F3600
G1 X5.300 Y6.800 E0.66093 F3600
G1 X5.400 Y6.900 E0.66572 F3600
G0 X6.100 Y7.300 F9000
G1 X6.200 Y7.300 E0.66910 F3600
G0 X6.400 Y7.200 F9000
G1 X7.100 Y7.900 E0.70261 F3600
G1 X7.200 Y7.900 E0.70600 F3600
G1 X7.300 Y7.800 E0.71078 F3600
G1 X7.200 Y7.500 E0.72149 F3600
G1 X6.600 Y6.900 E0.75021 F3600
G1 X6.900 Y6.600 E0.76457 F3600
G1 X7.200 Y6.900 E0.77893 F3600
G1 X7.400 Y6.700 E0.78851 F3600
G1 X7.600 Y6.900 E0.79808 F3600
G1 X7.400 Y7.100 E0.80765 F3600
G1 X7.400 Y7.200 E0.81104 F3600
G1 X7.600 Y7.400 E0.82061 F3600
G1 X7.700 Y7.300 E0.82540 F3600
G1 X7.700 Y7.100 E0.83217 F3600
G1 X7.600 Y7.000 E0.83696 F3600
G0 X7.900 Y6.700 F9000
G1 X8.000 Y6.800 E0.84174 F3600
;--- Shutdown ---
G1 E0.14174 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---