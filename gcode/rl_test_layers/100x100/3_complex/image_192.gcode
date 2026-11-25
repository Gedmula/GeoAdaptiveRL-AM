;FLAVOR:Marlin
;Generated from path with 94 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X2.000 Y-2.900 W32.000 H4.800 ; print area for bed levelling
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
G0 X2.000 Y1.600 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.100 Y1.500 E0.00479 F3600
G1 X2.000 Y1.400 E0.00957 F3600
G1 X2.200 Y1.200 E0.01915 F3600
G1 X2.300 Y1.300 E0.02393 F3600
G1 X2.400 Y1.200 E0.02872 F3600
G1 X2.600 Y1.400 E0.03830 F3600
G1 X2.300 Y1.700 E0.05266 F3600
G1 X2.400 Y1.900 E0.06023 F3600
G1 X2.700 Y1.700 E0.07243 F3600
G1 X2.800 Y1.800 E0.07722 F3600
G1 X2.900 Y1.700 E0.08200 F3600
G1 X3.100 Y1.800 E0.08957 F3600
G1 X3.200 Y1.700 E0.09436 F3600
G1 X3.300 Y1.800 E0.09915 F3600
G1 X3.500 Y1.600 E0.10872 F3600
G1 X3.300 Y1.400 E0.11829 F3600
G1 X3.100 Y1.400 E0.12506 F3600
G1 X2.900 Y1.200 E0.13464 F3600
G1 X3.000 Y1.100 E0.13942 F3600
G1 X3.200 Y1.300 E0.14900 F3600
G1 X3.300 Y1.200 E0.15379 F3600
G1 X3.400 Y1.300 E0.15857 F3600
G0 X3.500 Y1.200 F9000
G0 X3.700 Y1.200 F9000
G1 X3.800 Y1.300 E0.16336 F3600
G1 X3.900 Y1.200 E0.16815 F3600
G1 X4.100 Y1.400 E0.17772 F3600
G1 X3.800 Y1.700 E0.19208 F3600
G1 X3.900 Y1.800 E0.19687 F3600
G1 X4.100 Y1.800 E0.20364 F3600
G1 X4.200 Y1.700 E0.20842 F3600
G1 X4.300 Y1.800 E0.21321 F3600
G1 X4.400 Y1.700 E0.21800 F3600
G1 X4.600 Y1.800 E0.22557 F3600
G1 X4.800 Y1.600 E0.23514 F3600
G1 X4.700 Y1.600 E0.23853 F3600
G1 X4.400 Y1.300 E0.25289 F3600
G1 X4.500 Y1.200 E0.25767 F3600
G1 X4.600 Y1.300 E0.26246 F3600
G1 X4.700 Y1.200 E0.26725 F3600
G1 X4.800 Y1.300 E0.27203 F3600
G1 X4.900 Y1.200 E0.27682 F3600
G1 X5.000 Y1.300 E0.28161 F3600
G1 X5.100 Y1.200 E0.28640 F3600
G1 X5.300 Y1.400 E0.29597 F3600
G1 X5.000 Y1.700 E0.31033 F3600
G1 X5.200 Y1.900 E0.31990 F3600
G1 X5.400 Y1.700 E0.32948 F3600
G1 X5.500 Y1.800 E0.33426 F3600
G1 X5.600 Y1.700 E0.33905 F3600
G1 X5.800 Y1.800 E0.34662 F3600
G1 X6.000 Y1.800 E0.35339 F3600
G1 X6.100 Y1.700 E0.35818 F3600
G1 X5.700 Y1.300 E0.37733 F3600
G1 X5.700 Y1.200 E0.38071 F3600
G1 X5.800 Y1.300 E0.38550 F3600
G1 X5.900 Y1.200 E0.39028 F3600
G1 X6.000 Y1.300 E0.39507 F3600
G1 X6.100 Y1.200 E0.39986 F3600
G1 X6.200 Y1.300 E0.40464 F3600
G1 X6.300 Y1.200 E0.40943 F3600
G1 X6.400 Y1.300 E0.41422 F3600
G1 X6.400 Y1.500 E0.42099 F3600
G1 X6.600 Y1.700 E0.43056 F3600
G1 X6.800 Y1.500 E0.44014 F3600
G1 X6.700 Y1.400 E0.44492 F3600
G1 X6.800 Y1.200 E0.45249 F3600
G1 X6.900 Y1.300 E0.45728 F3600
G1 X7.000 Y1.200 E0.46207 F3600
G1 X7.200 Y1.400 E0.47164 F3600
G1 X7.000 Y1.600 E0.48121 F3600
G1 X7.100 Y1.700 E0.48600 F3600
G1 X7.300 Y1.700 E0.49277 F3600
G1 X7.400 Y1.600 E0.49756 F3600
G1 X7.500 Y1.700 E0.50234 F3600
G1 X7.700 Y1.500 E0.51192 F3600
G1 X7.500 Y1.300 E0.52149 F3600
G1 X7.600 Y1.200 E0.52628 F3600
G1 X7.700 Y1.300 E0.53107 F3600
G1 X7.800 Y1.200 E0.53585 F3600
G1 X7.900 Y1.300 E0.54064 F3600
G1 X8.000 Y1.200 E0.54543 F3600
G1 X8.100 Y1.300 E0.55021 F3600
G1 X8.100 Y1.400 E0.55360 F3600
G1 X7.900 Y1.600 E0.56317 F3600
G1 X8.000 Y1.800 E0.57074 F3600
G1 X8.200 Y1.600 E0.58032 F3600
G1 X8.400 Y1.700 E0.58788 F3600
G1 X8.600 Y1.500 E0.59746 F3600
G1 X8.600 Y1.300 E0.60423 F3600
G1 X8.500 Y1.200 E0.60901 F3600
G1 X8.600 Y1.300 E0.61380 F3600
;--- Shutdown ---
G1 E-0.08620 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---