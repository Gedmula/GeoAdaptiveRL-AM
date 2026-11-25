;FLAVOR:Marlin
;Generated from path with 79 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X5.500 Y-2.100 W32.000 H8.200 ; print area for bed levelling
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
G0 X5.500 Y2.700 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X5.700 Y2.900 E0.00957 F3600
G1 X5.800 Y2.800 E0.01436 F3600
G1 X6.000 Y3.000 E0.02393 F3600
G1 X6.200 Y2.800 E0.03351 F3600
G1 X6.400 Y3.000 E0.04308 F3600
G1 X6.500 Y2.900 E0.04787 F3600
G1 X6.900 Y3.300 E0.06702 F3600
G1 X6.900 Y3.500 E0.07379 F3600
G1 X6.800 Y3.600 E0.07857 F3600
G1 X7.000 Y4.000 E0.09371 F3600
G1 X6.700 Y4.300 E0.10807 F3600
G1 X6.800 Y4.400 E0.11286 F3600
G1 X6.700 Y4.600 E0.12043 F3600
G1 X6.800 Y4.800 E0.12800 F3600
G1 X6.700 Y4.900 E0.13278 F3600
G1 X6.900 Y5.300 E0.14792 F3600
G1 X6.600 Y5.600 E0.16228 F3600
G1 X6.700 Y5.700 E0.16707 F3600
G1 X6.600 Y5.800 E0.17186 F3600
G1 X7.000 Y6.100 E0.18878 F3600
G1 X7.100 Y6.000 E0.19357 F3600
G1 X7.200 Y6.100 E0.19835 F3600
G1 X7.300 Y6.000 E0.20314 F3600
G1 X7.500 Y6.100 E0.21071 F3600
G1 X7.700 Y5.900 E0.22028 F3600
G1 X7.600 Y5.800 E0.22507 F3600
G1 X7.800 Y5.600 E0.23465 F3600
G1 X7.600 Y5.400 E0.24422 F3600
G1 X7.300 Y5.700 E0.25858 F3600
G1 X7.200 Y5.700 E0.26196 F3600
G1 X7.100 Y5.600 E0.26675 F3600
G1 X7.300 Y5.400 E0.27633 F3600
G1 X7.200 Y5.300 E0.28111 F3600
G1 X7.300 Y5.200 E0.28590 F3600
G1 X7.100 Y5.000 E0.29547 F3600
G1 X7.300 Y4.800 E0.30505 F3600
G1 X7.700 Y5.200 E0.32419 F3600
G1 X7.900 Y5.000 E0.33377 F3600
G1 X7.500 Y4.500 E0.35544 F3600
G1 X7.400 Y4.600 E0.36023 F3600
G1 X7.200 Y4.400 E0.36980 F3600
G1 X7.500 Y4.100 E0.38416 F3600
G1 X7.800 Y4.400 E0.39853 F3600
G1 X8.000 Y4.200 E0.40810 F3600
G1 X7.800 Y4.000 E0.41767 F3600
G1 X7.900 Y3.800 E0.42524 F3600
G1 X7.700 Y3.600 E0.43482 F3600
G1 X7.500 Y3.800 E0.44439 F3600
G1 X7.300 Y3.700 E0.45196 F3600
G1 X7.400 Y3.500 E0.45953 F3600
G1 X7.300 Y3.400 E0.46431 F3600
G1 X7.400 Y3.300 E0.46910 F3600
G1 X6.600 Y2.400 E0.50986 F3600
G1 X6.500 Y2.500 E0.51465 F3600
G1 X6.400 Y2.400 E0.51943 F3600
G1 X5.900 Y2.500 E0.53669 F3600
G1 X5.600 Y2.200 E0.55105 F3600
G1 X5.900 Y1.900 E0.56542 F3600
G1 X6.000 Y2.000 E0.57020 F3600
G1 X6.200 Y1.900 E0.57777 F3600
G1 X6.300 Y2.000 E0.58256 F3600
G1 X6.400 Y1.900 E0.58735 F3600
G1 X6.500 Y2.000 E0.59213 F3600
G1 X6.600 Y1.900 E0.59692 F3600
G1 X6.900 Y2.100 E0.60912 F3600
G1 X7.000 Y2.000 E0.61391 F3600
G1 X7.200 Y2.200 E0.62348 F3600
G1 X7.100 Y2.300 E0.62827 F3600
G1 X7.900 Y3.300 E0.67162 F3600
G1 X8.000 Y3.200 E0.67641 F3600
G1 X7.900 Y3.000 E0.68397 F3600
G1 X8.000 Y2.900 E0.68876 F3600
G1 X7.900 Y2.800 E0.69355 F3600
G1 X8.000 Y2.600 E0.70112 F3600
G1 X7.500 Y2.200 E0.72279 F3600
G1 X7.600 Y2.000 E0.73036 F3600
G1 X7.700 Y2.100 E0.73515 F3600
;--- Shutdown ---
G1 E0.03515 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---