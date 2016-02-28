//
s.boot;
s.scope(2,0);
//master
(
SynthDef(\master,{|gate=1|
	var mast,env;
	mast = In.ar(20);
	mast = FreeVerb.ar(mast,1,0.25,0.05);
	env = EnvGen.ar(Env.asr(0.01,0.98,0.01),gate);
	Out.ar(0,Pan2.ar(mast*env,[1,-0.99]));
}).add;
);
Synth(\master);//primera vez que se evalua
Synth.replace(1000,\master);//reemplaza el primer nodo (master)
//1
(
SynthDef(\uno, {|gate=1|
	var osc,env;
	osc = SinOsc.ar(440,0,0.5);
	env = EnvGen.ar(Env.perc(0.01,0.99),gate,doneAction:1);
	Out.ar(20,osc*env);
}).add;
);
~uno = Synth(\uno);
~uno.free;
//
Help.gui;
s.queryAllNodes;