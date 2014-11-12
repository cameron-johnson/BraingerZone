# ==============================================================================
# DEMO
# ==============================================================================
var canvas_demo = {
  new: func()
  {
    debug.dump("Creating canvas heads-up display...");

    var m = { parents: [canvas_demo] };
    
    # create a new canvas...
    m.canvas = canvas.new({
      "name": "PFD-Test",
      "size": [64, 64],
      "view": [64, 64],
      "mipmapping": 1
    });
    
    # ... and place it on the object called PFD-Screen
    m.canvas.addPlacement({"node": "PFD-Screen"});
    m.canvas.setColorBackground(0,0,0,0.0);
    
    m.ssvepNode = props.globals.addChild("ssvep");
    m.freq1 = m.ssvepNode.addChild("frequency1");
    m.freq1.setDoubleValue(20);
    m.freq2 = m.ssvepNode.addChild("frequency2");
    m.freq2.setDoubleValue(10);
    m.freq3 = m.ssvepNode.addChild("frequency3");
    m.freq3.setDoubleValue(20);
    m.freq4 = m.ssvepNode.addChild("frequency4");
    m.freq4.setDoubleValue(10);
    
    # and now do something with it
    m.dt = props.globals.getNode("sim/time/delta-sec");
    # m.gmt  = props.globals.getNode("sim/time/gmt");
    
    var g = m.canvas.createGroup();

    m.path1 =
      g.createChild("path")
       .setTranslation(0, 16)
       .moveTo(0, 0)
       .lineTo(15, 0)
       .lineTo(15, 31)
       .lineTo(0, 31)
       .close()
       .setColorFill(1,1,1);

    m.path2 =
      g.createChild("path")
       .setTranslation(48, 16)
       .moveTo(0, 0)
       .lineTo(15, 0)
       .lineTo(15, 31)
       .lineTo(0, 31)
       .close()
       .setColorFill(1,1,1);

    m.path3 =
      g.createChild("path")
       .setTranslation(16, 0)
       .moveTo(0, 0)
       .lineTo(31, 0)
       .lineTo(31, 15)
       .lineTo(0, 15)
       .close()
       .setColorFill(1,1,1);

    m.path4 =
      g.createChild("path")
       .setTranslation(16, 48)
       .moveTo(0, 0)
       .lineTo(31, 0)
       .lineTo(31, 15)
       .lineTo(0, 15)
       .close()
       .setColorFill(1,1,1);

    m.maybeTime = 0.0;
    
    return m;
  },
  update: func()
  {
    var dt = me.dt.getValue();
    me.maybeTime += dt;

    var square1 = func() {
        me.path1.toggleVisibility();
        settimer(square1, 0.5/me.freq1.getValue());
    };

    var square2 = func() {
        me.path2.toggleVisibility();
        settimer(square2, 0.5/me.freq2.getValue());
    };

    var square3 = func() {
        me.path3.toggleVisibility();
        settimer(square3, 0.5/me.freq3.getValue());
    };

    var square4 = func() {
        me.path4.toggleVisibility();
        settimer(square4, 0.5/me.freq4.getValue());
    };

    square1();
    square2();
    square3();
    square4();
  },
};

setlistener("/nasal/canvas/loaded", func {
  var demo = canvas_demo.new();
  demo.update();
}, 1);
