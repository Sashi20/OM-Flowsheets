package Pres_swin_Dist
  model Material_Streams
    //instantiation of chemsep database
    import data = Simulator.Files.Chemsep_Database;
    //instantiation of Methanol
    parameter data.Methanol meth;
    //instantiation of Chloroform
    parameter data.Chloroform chlor;
    extends Simulator.Streams.Material_Stream(NOC = 2, comp = {meth, chlor}, totMolFlo(each start = 1), compMolFrac(each start = 0.5), T(start = sum(comp.Tb / NOC)));
    //material stream extended in which parameter NOC and comp are given values and other variables are given start values
    extends Simulator.Files.Thermodynamic_Packages.NRTL;
    //thermodynamic package NRTL is extended
  end Material_Streams;

model flowsheet
  import data = Simulator.Files.Chemsep_Database;
  //instantiation of Ethanol
  parameter data.Ethanol eth;
  //instantiation of Toluene
  parameter data.Toluene tol;
  //Number of Components
  parameter Integer NOC = 2;
  parameter data.General_Properties comp[NOC] = {eth, tol};
Material_Streams Feed(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-104, -12}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Material_Streams Recycle(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {-102, 32}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Pres_swin_Dist.LPC.DistColumn LPC(NOC = NOC, comp = comp, feedStages = {6, 16}, noOfFeeds = 2, noOfStages = 35)  annotation(
    Placement(visible = true, transformation(origin = {-40, 8}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
Pres_swin_Dist.Material_Streams Distillate1(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {8, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Pres_swin_Dist.Material_Streams Bottoms1(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {10, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Simulator.Streams.Energy_Stream C_duty1 annotation(
    Placement(visible = true, transformation(origin = {-30, 70}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Simulator.Streams.Energy_Stream R_duty1 annotation(
    Placement(visible = true, transformation(origin = {-30, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Pres_swin_Dist.HPC.DistColumn HPC(NOC = NOC, comp = comp, feedStages = {16}, noOfFeeds = 1, noOfStages = 22 )  annotation(
    Placement(visible = true, transformation(origin = {62, 8}, extent = {{-28, -28}, {28, 28}}, rotation = 0)));
Material_Streams Distillate2(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {118, 58}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Material_Streams Bottoms2(NOC = NOC, comp = comp)  annotation(
    Placement(visible = true, transformation(origin = {122, -38}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Simulator.Streams.Energy_Stream C_duty2 annotation(
    Placement(visible = true, transformation(origin = {74, 68}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
Simulator.Streams.Energy_Stream R_duty2 annotation(
    Placement(visible = true, transformation(origin = {76, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
  connect(Bottoms2.inlet, HPC.bottoms) annotation(
    Line(points = {{112, -38}, {104, -38}, {104, -12}, {90, -12}, {90, -12}, {90, -12}}));
  connect(Distillate2.inlet, HPC.distillate) annotation(
    Line(points = {{108, 58}, {100, 58}, {100, 28}, {90, 28}, {90, 28}, {90, 28}}));
  connect(R_duty2.inlet, HPC.reboiler_duty) annotation(
    Line(points = {{66, -50}, {56, -50}, {56, -34}, {82, -34}, {82, -22}, {82, -22}, {82, -20}}));
  connect(C_duty2.inlet, HPC.condensor_duty) annotation(
    Line(points = {{64, 68}, {58, 68}, {58, 42}, {78, 42}, {78, 34}, {78, 34}, {78, 34}}));
  connect(Distillate1.outlet, HPC.feed[1]) annotation(
    Line(points = {{18, 58}, {26, 58}, {26, 6}, {34, 6}, {34, 6}}));
  connect(Bottoms1.inlet, LPC.bottoms) annotation(
    Line(points = {{0, -38}, {-4, -38}, {-4, -12}, {-12, -12}, {-12, -12}, {-12, -12}}));
  connect(Distillate1.inlet, LPC.distillate) annotation(
    Line(points = {{-2, 58}, {-8, 58}, {-8, 28}, {-12, 28}, {-12, 28}, {-12, 28}}));
  connect(C_duty1.inlet, LPC.condensor_duty) annotation(
    Line(points = {{-40, 70}, {-48, 70}, {-48, 50}, {-24, 50}, {-24, 34}, {-24, 34}}));
  connect(R_duty1.inlet, LPC.reboiler_duty) annotation(
    Line(points = {{-40, -50}, {-48, -50}, {-48, -32}, {-20, -32}, {-20, -22}, {-20, -22}, {-20, -20}}));
  connect(Recycle.outlet, LPC.feed[2]) annotation(
    Line(points = {{-92, 32}, {-68, 32}, {-68, 8}, {-68, 8}, {-68, 6}}));
  connect(Feed.outlet, LPC.feed[1]) annotation(
    Line(points = {{-94, -12}, {-80, -12}, {-80, 8}, {-66, 8}, {-66, 6}, {-68, 6}}));
    
    Feed.compMolFrac[1, :] = {0.83721374, 0.16278626};
    Feed.T = 303.15;
    Feed.totMolFlo[1] = 18.149;
    Feed.P = 101325;
    
    Recycle.compMolFrac[1, :] = {0.918367, 0.081633};
    Recycle.T = 428.76;
    Recycle.totMolFlo[1] = 17.5529;
    Recycle.P = 1.11458E+06;
    
    LPC.condensor.P = 50662.5;
    LPC.reboiler.P = 50662.5;
    LPC.refluxRatio = 1.09839;
//    Distillate1.compMolFrac[1,2]=0.213586;
//    Distillate1.totMolFlo[1] = 20.5056;

    HPC.condensor.P = 1114575;
    HPC.reboiler.P = 1114575;
    HPC.refluxRatio = 0.37585;
//   Distillate2.compMolFrac[1,1] = 0.918367;

// Distillate1. compMolFrac[1,1] = 0.786414;
// Distillate2.compMolFrac[1,1] = 0.918367;
    Bottoms1.compMolFrac[1,1] = 0.9995;
    Bottoms2.compMolFrac[1,1] = 0.002;
  
end flowsheet;

  //===============================================================================================

  package LPC
    model Condensor
      extends Simulator.Unit_Operations.Distillation_Column.Cond;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Condensor;

    model Tray
      extends Simulator.Unit_Operations.Distillation_Column.DistTray;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Tray;

    model Reboiler
      extends Simulator.Unit_Operations.Distillation_Column.Reb;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Reboiler;

    model DistColumn
      extends Simulator.Unit_Operations.Distillation_Column.DistCol;
      Condensor condensor(NOC = NOC, comp = comp, condType = condType,boolFeed = boolFeed[1], T(start = 300));
      Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp,boolFeed = boolFeed[2:noOfStages-1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
    end DistColumn;
  end LPC;

  package HPC
    model Condensor
      extends Simulator.Unit_Operations.Distillation_Column.Cond;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Condensor;

    model Tray
      extends Simulator.Unit_Operations.Distillation_Column.DistTray;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Tray;

    model Reboiler
      extends Simulator.Unit_Operations.Distillation_Column.Reb;
      extends Simulator.Files.Thermodynamic_Packages.NRTL;
    end Reboiler;

    model DistColumn
      extends Simulator.Unit_Operations.Distillation_Column.DistCol;
      Condensor condensor(NOC = NOC, comp = comp, condType = condType,boolFeed = boolFeed[1], T(start = 300));
      Reboiler reboiler(NOC = NOC, comp = comp, boolFeed = boolFeed[noOfStages]);
      Tray tray[noOfStages - 2](each NOC = NOC, each comp = comp,boolFeed = boolFeed[2:noOfStages-1], each liqMolFlo(each start = 150), each vapMolFlo(each start = 150));
    end DistColumn;
  end HPC;
end Pres_swin_Dist;
