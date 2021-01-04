within BuildingControlEmulator.Devices.Fault.Examples;
class PIController
  import BuildingControlEmulator;
   extends Modelica.Icons.Example;
  package MediumCHW = IBPSA.Media.Water "Medium for chilled water";
  package MediumCW = IBPSA.Media.Water "Medium for condenser water";
  parameter Modelica.SIunits.Pressure dPCHW_nominal= 1000
    "Pressure difference at the chilled water side";
  parameter Modelica.SIunits.Pressure dPCW_nominal = 1000
    "Pressure difference at the condenser water wide";

  parameter Modelica.SIunits.Temperature TCW_start = 273.15+27
    "The start temperature of condenser water side";
  parameter Modelica.SIunits.Temperature TCHW_start = 273.15+5
    "The start temperature of chilled water side";

  BuildingControlEmulator.Devices.WaterSide.Chiller                 chi(
    per=per,
    redeclare package MediumCHW = MediumCHW,
    redeclare package MediumCW = MediumCW,
    redeclare BuildingControlEmulator.Devices.Fault.conPI conPI(
      k=0.1,
      fauFac=0.01,
      Ti=60),
    dPCHW_nominal=dPCHW_nominal,
    dPCW_nominal=dPCW_nominal,
    mCHW_flow_nominal=per.mEva_flow_nominal,
    mCW_flow_nominal=per.mCon_flow_nominal,
    TCW_start=TCW_start,
    TCHW_start=TCHW_start)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-2,4})));
   parameter Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_23XL_724kW_6_04COP_Vanes
                                                               per
    "Performance data"
    annotation (choicesAllMatching = true,
                Placement(transformation(extent={{40,66},{60,86}})));
  IBPSA.Fluid.Sources.MassFlowSource_T souCHW(
    nPorts=1,
    redeclare package Medium = MediumCHW,
    m_flow=per.mEva_flow_nominal,
    T=273.15 + 20,
    use_T_in=true) "Source for CHW"
    annotation (Placement(transformation(extent={{58,-30},{38,-10}})));
  IBPSA.Fluid.Sources.MassFlowSource_T souCW(
    nPorts=1,
    redeclare package Medium = MediumCW,
    use_T_in=false,
    T=273.15 + 21.11,
    m_flow=per.mCon_flow_nominal) "Source for CHW"
    annotation (Placement(transformation(extent={{-80,18},{-60,38}})));
  IBPSA.Fluid.Sources.Boundary_pT sinCHW(redeclare package Medium =
        MediumCHW, nPorts=1) "Sink for CHW" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-74,-20})));
  IBPSA.Fluid.Sources.Boundary_pT sinCW(nPorts=1, redeclare package Medium =
        MediumCW) "Sink for CW" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={48,28})));
  Modelica.Blocks.Sources.Constant       On(k=1)
    annotation (Placement(transformation(extent={{-80,46},{-60,66}})));
  IBPSA.Fluid.Sensors.TemperatureTwoPort senTCHWLea(
    allowFlowReversal=true,
    redeclare package Medium = MediumCHW,
    m_flow_nominal=per.mEva_flow_nominal) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-40,-20})));
  Modelica.Blocks.Sources.RealExpression TCHWSet(y=273.15 + 5.56)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=1.5,
    offset=275.15 + 5.56,
    freqHz=1/86400)
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
equation
  connect(sinCHW.ports[1], senTCHWLea.port_b) annotation (Line(
      points={{-64,-20},{-64,-20},{-50,-20}},
      color={0,127,255},
      thickness=1));
  connect(chi.port_b_CHW, senTCHWLea.port_a) annotation (Line(
      points={{-10,-6},{-10,-20},{-30,-20}},
      color={0,127,255},
      thickness=1));
  connect(chi.port_a_CHW, souCHW.ports[1]) annotation (Line(
      points={{6,-6},{6,-20},{38,-20}},
      color={0,127,255},
      thickness=1));
  connect(chi.port_b_CW, sinCW.ports[1]) annotation (Line(
      points={{6,14},{6,28},{38,28}},
      color={0,127,255},
      thickness=1));
  connect(chi.port_a_CW, souCW.ports[1]) annotation (Line(
      points={{-10,14},{-10,28},{-60,28}},
      color={0,127,255},
      thickness=1));
  connect(On.y, chi.On) annotation (Line(
      points={{-59,56},{-7,56},{-7,16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(TCHWSet.y, chi.TCHWSet) annotation (Line(
      points={{-59,80},{1,80},{1,16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  connect(sine.y, souCHW.T_in) annotation (Line(
      points={{61,-50},{80,-50},{80,-16},{60,-16}},
      color={0,0,127},
      pattern=LinePattern.Dash));
  annotation (experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end PIController;
