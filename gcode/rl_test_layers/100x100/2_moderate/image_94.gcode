;FLAVOR:Marlin
;Generated from path with 87 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.900 Y-2.400 W32.000 H8.800 ; print area for bed levelling
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
G0 X4.800 Y4.500 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X4.900 Y4.500 E0.00338 F3600
G1 X5.300 Y4.900 E0.02253 F3600
G1 X5.300 Y5.000 E0.02592 F3600
G1 X5.100 Y5.200 E0.03549 F3600
G1 X5.200 Y5.300 E0.04028 F3600
G1 X5.400 Y5.300 E0.04705 F3600
G1 X5.800 Y5.800 E0.06872 F3600
G1 X5.900 Y5.700 E0.07351 F3600
G1 X6.000 Y5.800 E0.07830 F3600
G1 X6.200 Y5.600 E0.08787 F3600
G1 X6.500 Y5.900 E0.10223 F3600
G1 X6.800 Y5.700 E0.11443 F3600
G1 X6.200 Y5.100 E0.14316 F3600
G1 X6.000 Y5.300 E0.15273 F3600
G1 X5.800 Y5.100 E0.16230 F3600
G1 X5.800 Y4.900 E0.16907 F3600
G1 X5.300 Y4.300 E0.19551 F3600
G1 X5.400 Y4.200 E0.20030 F3600
G1 X5.200 Y4.000 E0.20987 F3600
G1 X5.300 Y3.900 E0.21466 F3600
G1 X5.200 Y3.800 E0.21945 F3600
G1 X5.400 Y3.600 E0.22902 F3600
G1 X5.900 Y4.100 E0.25295 F3600
G1 X5.800 Y4.200 E0.25774 F3600
G1 X6.200 Y4.700 E0.27941 F3600
G1 X6.500 Y4.800 E0.29012 F3600
G1 X7.200 Y5.500 E0.32363 F3600
G1 X7.400 Y5.300 E0.33320 F3600
G1 X7.200 Y5.100 E0.34278 F3600
G1 X7.300 Y4.900 E0.35034 F3600
G1 X7.100 Y4.800 E0.35791 F3600
G1 X6.700 Y4.400 E0.37706 F3600
G1 X6.600 Y4.400 E0.38045 F3600
G1 X6.400 Y4.200 E0.39002 F3600
G1 X6.300 Y3.900 E0.40072 F3600
G1 X5.400 Y3.000 E0.44381 F3600
G1 X5.700 Y2.700 E0.45817 F3600
G1 X7.700 Y4.800 E0.55633 F3600
G1 X7.900 Y4.600 E0.56590 F3600
G1 X7.800 Y4.500 E0.57069 F3600
G0 X7.500 Y4.000 F9000
G1 X7.600 Y3.900 E0.57548 F3600
G1 X7.500 Y3.800 E0.58026 F3600
G1 X7.300 Y3.800 E0.58703 F3600
G1 X5.900 Y2.300 E0.65648 F3600
G1 X6.100 Y2.100 E0.66606 F3600
G1 X6.400 Y2.000 E0.67676 F3600
G1 X6.500 Y2.100 E0.68155 F3600
G1 X6.400 Y2.200 E0.68634 F3600
G1 X7.300 Y3.100 E0.72942 F3600
G1 X7.300 Y3.200 E0.73280 F3600
G1 X7.500 Y3.400 E0.74238 F3600
G1 X7.700 Y3.400 E0.74915 F3600
G1 X7.900 Y3.200 E0.75872 F3600
G1 X7.900 Y3.100 E0.76211 F3600
G1 X6.700 Y1.900 E0.81955 F3600
G1 X6.700 Y1.800 E0.82293 F3600
G1 X7.100 Y1.600 E0.83807 F3600
G1 X7.300 Y1.800 E0.84765 F3600
G1 X7.500 Y1.600 E0.85722 F3600
G1 X7.700 Y1.800 E0.86679 F3600
G1 X7.500 Y2.000 E0.87637 F3600
G1 X7.800 Y2.300 E0.89073 F3600
G1 X7.800 Y2.500 E0.89750 F3600
G1 X8.200 Y2.900 E0.91665 F3600
G1 X8.500 Y2.600 E0.93101 F3600
G1 X8.300 Y2.400 E0.94058 F3600
G1 X8.400 Y2.300 E0.94537 F3600
G1 X8.300 Y2.200 E0.95015 F3600
G1 X8.100 Y2.200 E0.95692 F3600
G1 X7.900 Y2.000 E0.96650 F3600
G1 X8.000 Y1.800 E0.97407 F3600
G1 X8.100 Y1.700 E0.97885 F3600
G1 X8.300 Y1.800 E0.98642 F3600
G1 X8.600 Y2.100 E1.00078 F3600
G1 X8.500 Y2.200 E1.00557 F3600
G1 E0.30557 F2100 ; retract
G1 Z0.400 F9000 ; z-hop
G0 X2.800 Y6.300 F9000
G1 Z0.200 F9000 ; lower z
G1 E1.00557 F2100 ; unretract
G1 X2.700 Y6.200 E1.01036 F3600
G1 X2.500 Y6.400 E1.01993 F3600
G1 X2.300 Y6.400 E1.02670 F3600
G1 X1.900 Y6.000 E1.04585 F3600
G1 X1.900 Y5.800 E1.05262 F3600
G1 X2.100 Y5.600 E1.06219 F3600
G1 X2.400 Y5.900 E1.07655 F3600
G1 X2.600 Y5.700 E1.08613 F3600
;--- Shutdown ---
G1 E0.38613 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---