;FLAVOR:Marlin
;Generated from path with 54 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X3.000 Y-0.600 W32.000 H8.100 ; print area for bed levelling
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
G0 X4.300 Y4.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.400 Y4.400 E0.00479 F3600
G1 X4.100 Y4.700 E0.01915 F3600
G1 X3.500 Y6.000 E0.06761 F3600
G1 X3.000 Y6.500 E0.09155 F3600
G1 X3.300 Y6.800 E0.10591 F3600
G1 X3.400 Y6.700 E0.11069 F3600
G1 X3.600 Y7.000 E0.12290 F3600
G1 X3.700 Y6.900 E0.12769 F3600
G1 X3.800 Y7.000 E0.13247 F3600
G1 X3.900 Y6.900 E0.13726 F3600
G1 X4.000 Y7.100 E0.14483 F3600
G1 X4.100 Y7.200 E0.14962 F3600
G1 X4.200 Y7.100 E0.15440 F3600
G1 X4.400 Y7.400 E0.16661 F3600
G1 X4.500 Y7.300 E0.17139 F3600
G1 X4.700 Y7.500 E0.18097 F3600
G1 X4.800 Y7.500 E0.18435 F3600
G1 X5.000 Y7.300 E0.19393 F3600
G1 X4.800 Y7.100 E0.20350 F3600
G1 X5.100 Y6.900 E0.21570 F3600
G1 X5.100 Y6.700 E0.22247 F3600
G1 X5.300 Y6.500 E0.23205 F3600
G1 X5.200 Y6.400 E0.23684 F3600
G1 X5.600 Y6.000 E0.25598 F3600
G1 X5.500 Y5.900 E0.26077 F3600
G1 X5.700 Y5.700 E0.27034 F3600
G1 X5.600 Y5.500 E0.27791 F3600
G1 X5.900 Y5.300 E0.29012 F3600
G1 X5.800 Y5.200 E0.29490 F3600
G1 X6.500 Y4.500 E0.32841 F3600
G1 X6.400 Y4.400 E0.33320 F3600
G1 X6.500 Y4.300 E0.33799 F3600
G1 X6.400 Y4.200 E0.34277 F3600
G1 X6.200 Y4.300 E0.35034 F3600
G1 X6.100 Y4.200 E0.35513 F3600
G1 X5.900 Y4.200 E0.36190 F3600
G1 X5.800 Y4.100 E0.36669 F3600
G1 X5.900 Y4.000 E0.37147 F3600
G1 X5.700 Y4.100 E0.37904 F3600
G0 X5.500 Y4.000 F9000
G1 X5.100 Y3.600 E0.39819 F3600
G1 X4.600 Y4.100 E0.42212 F3600
G1 X4.400 Y4.100 E0.42889 F3600
G1 X4.300 Y3.900 E0.43646 F3600
G0 X4.500 Y3.700 F9000
G1 X4.700 Y3.400 E0.44867 F3600
G1 X4.600 Y3.500 E0.45345 F3600
G1 E-0.24655 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X4.500 Y3.500 F9000
G0 X3.600 Y6.400 F9000
G1 Z0.200 F9000 ; lower z
G1 E0.45345 F2100 ; unretract
G1 X3.700 Y6.300 E0.45824 F3600
G1 E-0.24176 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X3.600 Y6.200 F9000
G0 X3.700 Y6.100 F9000
;--- Shutdown ---
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---