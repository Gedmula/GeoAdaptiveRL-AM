;FLAVOR:Marlin
;Generated from path with 68 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.400 Y-1.300 W32.000 H8.100 ; print area for bed levelling
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
G0 X2.900 Y4.100 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.400 Y4.600 E0.02393 F3600
G1 X2.500 Y4.700 E0.02872 F3600
G1 X2.400 Y4.800 E0.03351 F3600
G1 X2.800 Y5.200 E0.05266 F3600
G1 X2.700 Y5.300 E0.05744 F3600
G1 X3.100 Y5.700 E0.07659 F3600
G1 X3.000 Y5.800 E0.08138 F3600
G1 X3.500 Y6.300 E0.10531 F3600
G1 X3.400 Y6.400 E0.11010 F3600
G1 X3.700 Y6.800 E0.12702 F3600
G1 X3.900 Y6.600 E0.13660 F3600
G1 X4.000 Y6.700 E0.14138 F3600
G1 X4.200 Y6.500 E0.15096 F3600
G1 X4.300 Y6.600 E0.15575 F3600
G1 X4.400 Y6.500 E0.16053 F3600
G1 X3.500 Y5.700 E0.20129 F3600
G1 X3.600 Y5.600 E0.20608 F3600
G1 X3.200 Y5.200 E0.22523 F3600
G1 X3.200 Y5.100 E0.22861 F3600
G1 X2.900 Y4.800 E0.24297 F3600
G1 X2.900 Y4.700 E0.24636 F3600
G1 X3.200 Y4.400 E0.26072 F3600
G1 X3.900 Y5.200 E0.29670 F3600
G1 X4.200 Y5.800 E0.31941 F3600
G1 X4.300 Y5.800 E0.32279 F3600
G1 X4.600 Y5.500 E0.33715 F3600
G1 X3.800 Y4.600 E0.37791 F3600
G1 X3.800 Y4.500 E0.38130 F3600
G1 X4.000 Y4.300 E0.39087 F3600
G1 X4.100 Y4.400 E0.39566 F3600
G1 X4.300 Y4.200 E0.40523 F3600
G1 X4.500 Y4.400 E0.41481 F3600
G1 X4.400 Y4.500 E0.41959 F3600
G1 X4.500 Y4.600 E0.42438 F3600
G1 X4.500 Y4.800 E0.43115 F3600
G1 X4.900 Y5.200 E0.45030 F3600
G1 X5.200 Y4.900 E0.46466 F3600
G1 X4.900 Y4.600 E0.47902 F3600
G1 X5.000 Y4.500 E0.48381 F3600
G1 X4.700 Y4.200 E0.49817 F3600
G1 X5.000 Y3.900 E0.51253 F3600
G1 X5.400 Y4.300 E0.53167 F3600
G1 X5.500 Y4.700 E0.54563 F3600
G1 X5.600 Y4.800 E0.55042 F3600
G1 X5.700 Y4.700 E0.55520 F3600
G1 X6.000 Y4.800 E0.56591 F3600
G1 X6.200 Y4.600 E0.57548 F3600
G1 X6.300 Y4.700 E0.58027 F3600
G1 X6.400 Y4.600 E0.58506 F3600
G1 X6.600 Y4.800 E0.59463 F3600
G1 X7.200 Y4.200 E0.62335 F3600
G1 X7.100 Y4.100 E0.62814 F3600
G1 X6.900 Y4.100 E0.63491 F3600
G1 X6.700 Y4.300 E0.64448 F3600
G1 X6.500 Y4.100 E0.65406 F3600
G1 X6.400 Y4.100 E0.65744 F3600
G1 X6.000 Y4.400 E0.67437 F3600
G1 X5.900 Y4.400 E0.67775 F3600
G1 X5.200 Y3.600 E0.71373 F3600
G1 X5.500 Y3.300 E0.72809 F3600
G1 X6.100 Y4.000 E0.75930 F3600
G1 X6.400 Y3.700 E0.77366 F3600
G1 X5.600 Y3.000 E0.80964 F3600
G1 X5.800 Y2.800 E0.81922 F3600
G1 X6.000 Y3.000 E0.82879 F3600
G1 X6.400 Y2.700 E0.84572 F3600
;--- Shutdown ---
G1 E0.14572 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---