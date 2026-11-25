;FLAVOR:Marlin
;Generated from path with 87 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X7.300 Y-1.700 W32.000 H10.400 ; print area for bed levelling
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
G0 X7.500 Y4.200 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X7.600 Y4.300 E0.00479 F3600
G1 X7.600 Y4.500 E0.01156 F3600
G1 X7.500 Y4.600 E0.01634 F3600
G1 X7.600 Y4.700 E0.02113 F3600
G1 X7.500 Y4.800 E0.02592 F3600
G1 X7.600 Y4.900 E0.03070 F3600
G1 X7.500 Y5.000 E0.03549 F3600
G1 X7.600 Y5.100 E0.04028 F3600
G1 X7.600 Y5.300 E0.04705 F3600
G1 X7.400 Y5.500 E0.05662 F3600
G1 X7.500 Y5.600 E0.06141 F3600
G1 X7.400 Y5.700 E0.06620 F3600
G1 X7.500 Y5.800 E0.07098 F3600
G1 X7.400 Y5.900 E0.07577 F3600
G1 X7.500 Y6.000 E0.08056 F3600
G1 X7.400 Y6.100 E0.08534 F3600
G1 X7.500 Y6.200 E0.09013 F3600
G1 X7.400 Y6.300 E0.09492 F3600
G1 X7.500 Y6.400 E0.09970 F3600
G1 X7.400 Y6.500 E0.10449 F3600
G1 X7.500 Y6.600 E0.10928 F3600
G1 X7.400 Y6.700 E0.11407 F3600
G1 X7.500 Y6.800 E0.11885 F3600
G1 X7.400 Y6.900 E0.12364 F3600
G1 X7.500 Y7.000 E0.12843 F3600
G1 X7.400 Y7.100 E0.13321 F3600
G1 X7.500 Y7.200 E0.13800 F3600
G1 X7.400 Y7.300 E0.14279 F3600
G1 X7.500 Y7.400 E0.14757 F3600
G1 X7.400 Y7.500 E0.15236 F3600
G1 X7.500 Y7.600 E0.15715 F3600
G1 X7.400 Y7.700 E0.16193 F3600
G1 X7.500 Y7.800 E0.16672 F3600
G1 X7.400 Y7.900 E0.17151 F3600
G1 X7.500 Y8.000 E0.17630 F3600
G1 X7.400 Y8.100 E0.18108 F3600
G1 X7.500 Y8.200 E0.18587 F3600
G1 X7.300 Y8.400 E0.19544 F3600
G1 X7.300 Y8.500 E0.19883 F3600
G1 X7.500 Y8.700 E0.20840 F3600
G1 X7.600 Y8.600 E0.21319 F3600
G1 X7.800 Y8.700 E0.22076 F3600
G1 X8.000 Y8.500 E0.23033 F3600
G1 X7.900 Y8.400 E0.23512 F3600
G1 X8.000 Y8.200 E0.24269 F3600
G1 X7.700 Y7.900 E0.25705 F3600
G1 X7.900 Y7.500 E0.27219 F3600
G0 X8.100 Y7.300 F9000
G1 X7.900 Y7.100 E0.28176 F3600
G1 X8.100 Y6.900 E0.29133 F3600
G1 X7.900 Y6.700 E0.30091 F3600
G1 X8.100 Y6.500 E0.31048 F3600
G1 X7.900 Y6.300 E0.32006 F3600
G1 X8.100 Y6.100 E0.32963 F3600
G1 X7.900 Y5.900 E0.33920 F3600
G1 X8.000 Y5.800 E0.34399 F3600
G1 X7.900 Y5.600 E0.35156 F3600
G1 X8.100 Y5.400 E0.36113 F3600
G1 X8.000 Y5.300 E0.36592 F3600
G1 X8.200 Y5.100 E0.37549 F3600
G1 X8.000 Y4.900 E0.38507 F3600
G1 X8.100 Y4.800 E0.38985 F3600
G1 X8.000 Y4.600 E0.39742 F3600
G1 X8.200 Y4.400 E0.40700 F3600
G1 X8.000 Y4.200 E0.41657 F3600
G1 X8.200 Y4.000 E0.42615 F3600
G1 X8.100 Y3.900 E0.43093 F3600
G1 X7.900 Y4.000 E0.43850 F3600
G1 X7.500 Y3.700 E0.45543 F3600
G1 X7.600 Y3.600 E0.46021 F3600
G1 X7.500 Y3.500 E0.46500 F3600
G1 X7.600 Y3.400 E0.46979 F3600
G1 X7.500 Y3.300 E0.47457 F3600
G1 X7.600 Y3.200 E0.47936 F3600
G1 X7.500 Y3.100 E0.48415 F3600
G1 X7.600 Y3.000 E0.48893 F3600
G1 X8.100 Y3.600 E0.51537 F3600
G1 X8.200 Y3.500 E0.52016 F3600
G1 X8.200 Y3.300 E0.52693 F3600
G1 X8.100 Y3.200 E0.53171 F3600
G1 X8.200 Y3.100 E0.53650 F3600
G1 X7.500 Y2.500 E0.56771 F3600
G1 X7.700 Y2.300 E0.57728 F3600
G1 X7.800 Y2.300 E0.58067 F3600
G1 X8.200 Y2.600 E0.59759 F3600
;--- Shutdown ---
G1 E-0.10241 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---