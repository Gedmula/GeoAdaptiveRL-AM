;FLAVOR:Marlin
;Generated from path with 51 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.900 Y-1.300 W32.000 H6.400 ; print area for bed levelling
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
G0 X4.900 Y4.400 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.300 Y4.800 E0.01915 F3600
G1 X5.400 Y4.700 E0.02393 F3600
G1 X5.500 Y4.900 E0.03150 F3600
G1 X5.800 Y5.100 E0.04371 F3600
G1 X5.900 Y5.000 E0.04849 F3600
G1 X6.000 Y5.100 E0.05328 F3600
G1 X6.200 Y4.900 E0.06286 F3600
G1 X6.400 Y5.100 E0.07243 F3600
G1 X6.500 Y5.000 E0.07722 F3600
G1 X6.600 Y5.100 E0.08200 F3600
G1 X6.800 Y4.900 E0.09158 F3600
G1 X6.900 Y5.000 E0.09636 F3600
G1 X7.200 Y4.700 E0.11073 F3600
G1 X7.300 Y4.800 E0.11551 F3600
G1 X7.500 Y4.600 E0.12509 F3600
G1 X7.400 Y4.400 E0.13265 F3600
G1 X7.600 Y4.200 E0.14223 F3600
G1 X7.400 Y4.000 E0.15180 F3600
G1 X7.100 Y4.300 E0.16616 F3600
G1 X7.000 Y4.300 E0.16955 F3600
G1 X6.500 Y4.700 E0.19122 F3600
G1 X6.300 Y4.500 E0.20080 F3600
G1 X5.900 Y4.700 E0.21593 F3600
G1 X5.300 Y4.100 E0.24466 F3600
G1 X5.100 Y4.100 E0.25143 F3600
G1 X4.900 Y3.900 E0.26100 F3600
G1 X5.300 Y3.500 E0.28015 F3600
G1 X6.000 Y4.200 E0.31366 F3600
G1 X6.200 Y4.000 E0.32323 F3600
G1 X6.400 Y4.200 E0.33280 F3600
G1 X6.500 Y4.200 E0.33619 F3600
G1 X6.700 Y4.000 E0.34576 F3600
G1 X6.400 Y3.700 E0.36012 F3600
G1 X6.200 Y3.600 E0.36769 F3600
G1 X6.100 Y3.700 E0.37248 F3600
G1 X5.400 Y3.100 E0.40369 F3600
G1 X5.700 Y2.800 E0.41805 F3600
G1 X5.900 Y3.000 E0.42762 F3600
G1 X6.200 Y2.700 E0.44198 F3600
G1 X6.300 Y2.800 E0.44677 F3600
G1 X6.500 Y2.700 E0.45434 F3600
G1 X6.600 Y2.800 E0.45912 F3600
G1 X6.300 Y3.100 E0.47348 F3600
G1 X6.300 Y3.200 E0.47687 F3600
G1 X7.000 Y3.800 E0.50808 F3600
G1 X7.300 Y3.500 E0.52244 F3600
G1 X6.900 Y3.200 E0.53936 F3600
G1 X7.000 Y3.000 E0.54693 F3600
G1 X6.900 Y2.900 E0.55172 F3600
;--- Shutdown ---
G1 E-0.14828 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---