within BuildingControlEmulator.Devices.Fault.BaseClasses;
model Pressure "Ideal pressure sensor"
  extends IBPSA.Fluid.Sensors.BaseClasses.PartialAbsoluteSensor;
  extends Modelica.Icons.RotationalSensor;
  Real p_real;
equation
  p_real = port.p;
  annotation (defaultComponentName="senPre",
  Icon(coordinateSystem(
        preserveAspectRatio=false,
        extent={{-100,-100},{100,100}},
        grid={1,1}), graphics={
        Line(points={{70,0},{100,0}}, color={0,0,127}),
        Line(points={{0,-70},{0,-100}}, color={0,127,255}),
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          lineColor={0,0,255}),
        Text(
          extent={{151,-20},{57,-50}},
          lineColor={0,0,0},
          textString="p")}),
    Documentation(info="<html>
<p>
This model outputs the absolute pressure of the fluid connected to its port.
The sensor is ideal, i.e., it does not influence the fluid.
</p>
</html>",
revisions="<html>
<ul>
<li>June 30, 2020 by Sen Huang:</li>
<p>Added a interface for implement various faults. </p>
<li>May 9, 2017, by Filip Jorissen:<br>Changed output quantity to <code>AbsolutePressure</code>. See <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/770\">#770</a>. </li>
<li>September 29, 2009, by Michael Wetter:<br>First implementation, based on <code>Modelica.Fluid</code>. </li>
</ul>
</html>"));
end Pressure;
