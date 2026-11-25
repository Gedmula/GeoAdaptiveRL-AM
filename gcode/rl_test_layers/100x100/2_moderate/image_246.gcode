;FLAVOR:Marlin
;Generated from path with 67 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X4.100 Y-0.500 W32.000 H6.600 ; print area for bed levelling
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
G0 X4.600 Y4.800 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.100 Y5.300 E0.02393 F3600
G1 X4.200 Y5.400 E0.02872 F3600
G1 X4.100 Y5.500 E0.03351 F3600
G1 X4.500 Y5.900 E0.05266 F3600
G1 X4.700 Y5.900 E0.05943 F3600
G1 X4.900 Y5.700 E0.06900 F3600
G1 X4.600 Y5.400 E0.08336 F3600
G1 X5.000 Y5.000 E0.10251 F3600
G1 X5.200 Y5.200 E0.11208 F3600
G1 X5.200 Y5.400 E0.11885 F3600
G1 X5.300 Y5.500 E0.12364 F3600
G1 X5.700 Y5.100 E0.14279 F3600
G1 X5.900 Y5.300 E0.15236 F3600
G1 X6.000 Y5.200 E0.15715 F3600
G1 X6.300 Y5.500 E0.17151 F3600
G1 X6.300 Y5.700 E0.17828 F3600
G1 X6.400 Y5.800 E0.18307 F3600
G1 X6.600 Y5.600 E0.19264 F3600
G1 X6.800 Y5.700 E0.20021 F3600
G1 X6.900 Y5.600 E0.20500 F3600
G1 X7.200 Y5.800 E0.21720 F3600
G1 X7.300 Y5.700 E0.22199 F3600
G1 X7.400 Y5.800 E0.22677 F3600
G1 X7.500 Y5.700 E0.23156 F3600
G1 X7.700 Y5.900 E0.24113 F3600
G1 X7.800 Y5.800 E0.24592 F3600
G1 X8.100 Y6.100 E0.26028 F3600
G1 X8.300 Y5.900 E0.26986 F3600
G1 X8.200 Y5.800 E0.27464 F3600
G1 X8.400 Y5.500 E0.28685 F3600
G1 X8.300 Y5.300 E0.29442 F3600
G1 X8.000 Y5.500 E0.30662 F3600
G1 X7.600 Y5.200 E0.32354 F3600
G1 X7.500 Y5.300 E0.32833 F3600
G1 X7.400 Y5.200 E0.33312 F3600
G1 X7.200 Y5.300 E0.34069 F3600
G1 X7.000 Y5.100 E0.35026 F3600
G1 X6.800 Y5.300 E0.35984 F3600
G1 X6.500 Y5.000 E0.37420 F3600
G1 X6.300 Y5.000 E0.38097 F3600
G1 X6.000 Y4.800 E0.39317 F3600
G1 X6.200 Y4.600 E0.40274 F3600
G1 X6.000 Y4.400 E0.41232 F3600
G1 X6.200 Y4.200 E0.42189 F3600
G1 X6.700 Y4.700 E0.44583 F3600
G1 X7.300 Y4.800 E0.46642 F3600
G1 X7.500 Y4.600 E0.47599 F3600
G1 X7.200 Y4.300 E0.49035 F3600
G1 X6.900 Y4.300 E0.50051 F3600
G1 X6.800 Y4.100 E0.50807 F3600
G1 X7.500 Y3.500 E0.53928 F3600
G1 X7.600 Y3.600 E0.54407 F3600
G1 X7.700 Y3.500 E0.54886 F3600
G1 X7.900 Y3.700 E0.55843 F3600
G1 X7.600 Y4.000 E0.57279 F3600
G1 X7.600 Y4.100 E0.57617 F3600
G1 X7.800 Y4.300 E0.58575 F3600
G1 X7.800 Y4.600 E0.59590 F3600
G1 X7.700 Y4.800 E0.60347 F3600
G1 X8.100 Y5.100 E0.62040 F3600
G1 X8.300 Y4.900 E0.62997 F3600
G1 X8.200 Y4.800 E0.63476 F3600
G1 X8.300 Y4.600 E0.64233 F3600
G1 X8.000 Y4.300 E0.65669 F3600
G1 X8.100 Y4.200 E0.66147 F3600
;--- Shutdown ---
G1 E-0.03853 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---