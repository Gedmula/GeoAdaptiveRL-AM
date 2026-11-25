;FLAVOR:Marlin
;Generated from path with 94 points
;Layer height: 0.2 mm
;Nozzle diameter: 0.4 mm
;Retraction distance: 0.7 mm
;Retraction speed: 2100 mm/min
;MATERIAL:PLA
G90                      ; absolute coordinates
M82                      ; absolute extrusion
M555 X1.600 Y-2.900 W32.000 H9.600 ; print area for bed levelling
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
G0 X2.300 Y2.300 F9000 ; to first bead
G1 Z0.200 F9000 ; lower z
G1 E0.00000 F2100 ; unretract
G1 X2.400 Y2.400 E0.00479 F3600
G1 X2.300 Y2.500 E0.00957 F3600
G1 X2.500 Y2.700 E0.01915 F3600
G1 X2.400 Y2.800 E0.02393 F3600
G1 X2.500 Y2.900 E0.02872 F3600
G1 X2.400 Y3.100 E0.03629 F3600
G1 X2.500 Y3.200 E0.04108 F3600
G1 X2.400 Y3.400 E0.04865 F3600
G1 X2.500 Y3.500 E0.05343 F3600
G1 X2.400 Y3.600 E0.05822 F3600
G1 X2.600 Y4.000 E0.07336 F3600
G1 X2.400 Y4.200 E0.08293 F3600
G1 X2.500 Y4.300 E0.08772 F3600
G1 X2.300 Y4.500 E0.09729 F3600
G1 X1.800 Y5.500 E0.13514 F3600
G1 X1.900 Y5.600 E0.13992 F3600
G1 X1.600 Y5.900 E0.15428 F3600
G1 X1.700 Y6.000 E0.15907 F3600
G1 X1.600 Y6.100 E0.16386 F3600
G1 X1.700 Y6.300 E0.17143 F3600
G1 X2.100 Y6.700 E0.19057 F3600
G1 X2.300 Y6.600 E0.19814 F3600
G1 X2.400 Y6.700 E0.20293 F3600
G1 X2.700 Y6.400 E0.21729 F3600
G1 X2.100 Y6.100 E0.24000 F3600
G1 X2.200 Y6.000 E0.24478 F3600
G1 X2.100 Y5.900 E0.24957 F3600
G1 X2.300 Y5.700 E0.25915 F3600
G1 X2.800 Y6.200 E0.28308 F3600
G1 X3.100 Y5.900 E0.29744 F3600
G1 X2.400 Y5.200 E0.33095 F3600
G1 X2.600 Y5.000 E0.34052 F3600
G1 X3.300 Y5.700 E0.37403 F3600
G1 X3.600 Y5.400 E0.38839 F3600
G1 X2.800 Y4.600 E0.42669 F3600
G1 X2.900 Y4.500 E0.43148 F3600
G1 X2.800 Y4.300 E0.43904 F3600
G1 X3.000 Y4.100 E0.44862 F3600
G1 X3.600 Y4.700 E0.47734 F3600
G1 X3.600 Y4.900 E0.48411 F3600
G1 X3.800 Y5.100 E0.49368 F3600
G1 X4.200 Y4.600 E0.51536 F3600
G1 X4.000 Y4.500 E0.52293 F3600
G1 X3.200 Y3.700 E0.56122 F3600
G1 X3.000 Y3.700 E0.56799 F3600
G1 X2.900 Y3.600 E0.57278 F3600
G1 X3.000 Y3.500 E0.57757 F3600
G1 X2.900 Y3.400 E0.58235 F3600
G1 X3.000 Y3.300 E0.58714 F3600
G1 X2.900 Y3.100 E0.59471 F3600
G1 X3.100 Y2.900 E0.60428 F3600
G1 X4.400 Y4.300 E0.66895 F3600
G1 X4.700 Y4.000 E0.68331 F3600
G1 X3.200 Y2.400 E0.75755 F3600
G1 X3.000 Y2.600 E0.76712 F3600
G1 X2.800 Y2.400 E0.77670 F3600
G1 X2.800 Y2.200 E0.78346 F3600
G1 X2.400 Y1.900 E0.80039 F3600
G1 X2.500 Y1.700 E0.80796 F3600
G1 X2.400 Y1.600 E0.81275 F3600
G1 X2.700 Y1.300 E0.82711 F3600
G1 X2.800 Y1.400 E0.83189 F3600
G1 X3.000 Y1.200 E0.84147 F3600
G1 X3.100 Y1.300 E0.84625 F3600
G1 X3.300 Y1.100 E0.85583 F3600
G1 X3.500 Y1.300 E0.86540 F3600
G1 X3.000 Y1.800 E0.88934 F3600
G1 X3.200 Y2.000 E0.89891 F3600
G1 X3.400 Y1.900 E0.90648 F3600
G1 X3.500 Y2.100 E0.91405 F3600
G1 X4.300 Y2.900 E0.95234 F3600
G1 X4.500 Y3.400 E0.97057 F3600
G1 X4.800 Y3.700 E0.98493 F3600
G1 X4.900 Y3.600 E0.98972 F3600
G1 X4.800 Y3.500 E0.99451 F3600
G1 X4.900 Y3.400 E0.99929 F3600
G1 X4.800 Y3.300 E1.00408 F3600
G1 X4.900 Y3.200 E1.00887 F3600
G1 X4.800 Y3.100 E1.01365 F3600
G1 X4.900 Y2.900 E1.02122 F3600
G1 X4.700 Y2.700 E1.03080 F3600
G1 X4.800 Y2.600 E1.03558 F3600
G1 X4.700 Y2.500 E1.04037 F3600
G1 X4.600 Y2.600 E1.04516 F3600
G1 X4.300 Y2.300 E1.05952 F3600
G1 X4.500 Y2.100 E1.06909 F3600
G1 X4.300 Y1.900 E1.07867 F3600
G1 X4.000 Y2.000 E1.08937 F3600
G1 X3.700 Y1.700 E1.10373 F3600
G1 X3.700 Y1.600 E1.10712 F3600
G1 X3.900 Y1.400 E1.11669 F3600
G1 X4.000 Y1.500 E1.12148 F3600
;--- Shutdown ---
G1 E0.42148 F2100 ; final retract
G92 E0                   ; reset extruder
G1 Z5.0 F3000            ; lift nozzle
M104 S0                  ; turn off hotend
M140 S0                  ; turn off bed
M107                     ; turn off fan
G28 X Y                  ; home X and Y
M84                      ; disable steppers
;--- End of G-code ---