*********************************************************************
*             Advanced Setpoint Generation Toolbox                  *
*********************************************************************
*                                                                   *
*  Copyright 2004, Paul Lambrechts, The MathWorks, Inc.             *
*                                                                   *
*  Originally created at, and published with permission of:         *
*  Eindhoven University of Technology, Faculty of Mechanical        *
*  Engineering, Control Systems Technology Group                    *
*********************************************************************

Properties:
This toolbox allows planning of 2nd, 3d and 4th order trajectories 
for single axis motion systems in MATLAB(R) software.
It also shows how to use use them in feedforward control.
The planners are limited to symmetrical trajectories for 
point-to-point motions.
Discrete time implementation is fully supported, dealing with 
quantization effects is indicated.
Use of planners and feedforward controllers in the Simulink(R) 
environment is also supported.
*********************************************************************

Main Contents:
 make4.m      MATLAB(R) function to calculate timing for symmetrical 
              4th order profiles (analytical solution)
 profile4.m   MATLAB(R) function to calculate symmetrical 4th order 
              profiles from timing info 
 motion.mdl   Simulink(R) library containing profile generators
              feedforward controllers and motion system models
             
Auxiliary and additional:
 make2.m      MATLAB(R) function to calculate timing for symmetrical 
              2nd order profiles plus profiles themselves
 make3.m      MATLAB(R) function to calculate timing for symmetrical 
              3d order profiles
 make4_it.m   MATLAB(R) function to calculate timing for symmetrical 
              4th order profiles using iterations to solve 
              3d order polynomial (obsolete)
 profile3.m   MATLAB(R) function to calculate symmetrical 3d order 
              profiles from timing info 

 makeplant.m  MATLAB(R) script to define several parameters and 
              state-space models for examples
              
 motion_example1.mdl   Simulink(R) models giving examples of use
 motion_example2.mdl   of the motion library
 motion_example3.mdl
 ref4_rt.mdl           Real-time implementation for single axis
 ref4_xy.mdl           Real-time implementation for X-Y moves

*********************************************************************
 
Installation and first use:
Extract files to work directory or any directory specified in 
matlabpath.
At MATLAB(R) command prompt: enter 'motion' to open motion library
and run examples.
For more details and command line use: see help make# and 
help profile#.
*********************************************************************

MATLAB and Simulink are registered trademarks of The MathWorks, Inc.
See www.mathworks.com/trademarks for a list of additional trademarks.
*********************************************************************
