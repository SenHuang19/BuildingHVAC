within BuildingControlEmulator.Devices.Fault;
model TwoWayStuck "Two way valve with equal percentage flow characteristics"
  extends IBPSA.Fluid.Actuators.BaseClasses.PartialTwoWayValveKv(phi=if homotopyInitialization then homotopy(actual=
        IBPSA.Fluid.Actuators.BaseClasses.equalPercentage(
        y_stuck_act,
        R,
        l,
        delta0), simplified=l + y_stuck_act*(1 - l)) else IBPSA.Fluid.Actuators.BaseClasses.equalPercentage(
        y_stuck_act,
        R,
        l,
        delta0));
  parameter Real R=50 "Rangeability, R=50...100 typically";
  parameter Real delta0=0.01
    "Range of significant deviation from equal percentage law";
  Real y_stuck
    "Stuck postion";
  Real y_real
    "Actual postion";
  Real y_stuck_act
    "Stuck postion";
initial equation
  // Since the flow model IBPSA.Fluid.BaseClasses.FlowModels.basicFlowFunction_m_flow computes
  // 1/k^2, the parameter l must not be zero.
  assert(l > 0, "Valve leakage parameter l must be bigger than zero.");
  assert(l < 1/R, "Wrong parameters in valve model.\n"
                + "  Rangeability R = " + String(R) + "\n"
                + "  Leakage flow l = " + String(l) + "\n"
                + "  Must have l < 1/R = " + String(1/R));
equation
  y_stuck_act = y_stuck;
  y_real = y_stuck;
  annotation (
    defaultComponentName="val",
    Documentation(info="<html>
<p>
Two way valve with an equal percentage valve opening characteristic.
</p><p>
This model is based on the partial valve model
<a href=\"modelica://IBPSA.Fluid.Actuators.BaseClasses.PartialTwoWayValve\">
IBPSA.Fluid.Actuators.BaseClasses.PartialTwoWayValve</a>.
Check this model for more information, such
as the regularization near the origin.
</p>
</html>", revisions="<html>
<ul>
<li>
April 4, 2014, by Michael Wetter:<br/>
Moved the assignment of the flow function <code>phi</code>
to the model instantiation because in its base class,
the keyword <code>input</code>
has been added to the variable <code>phi</code>.
</li>
<li>
March 27, 2014 by Michael Wetter:<br/>
Revised model for implementation of new valve model that computes the flow function
based on a table.
</li>
<li>
February 20, 2012 by Michael Wetter:<br/>
Renamed parameter <code>dp_nominal</code> to <code>dpValve_nominal</code>,
and added new parameter <code>dpFixed_nominal</code>.
See
<a href=\"modelica://IBPSA.Fluid.Actuators.UsersGuide\">
IBPSA.Fluid.Actuators.UsersGuide</a>.
</li>
<li>
February 14, 2012 by Michael Wetter:<br/>
Added filter to approximate the travel time of the actuator.
</li>
<li>
March 25, 2011, by Michael Wetter:<br/>
Added homotopy method.
</li>
<li>
June 5, 2008 by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"), Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Text(
          extent={{-74,20},{-36,-24}},
          lineColor={255,255,255},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid,
          textString="%%")}));
end TwoWayStuck;
